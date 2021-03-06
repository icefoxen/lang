module Main where
import Control.Monad.Error
import Monad
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

data LispVal = Atom String
   | List [LispVal]
   | DottedList [LispVal] LispVal
   | Number Integer
   | String String
   | Bool Bool

data LispError = NumArgs Integer [LispVal]
   | TypeMismatch String LispVal
   | Parser ParseError
   | BadSpecialForm String LispVal
   | NotFunction String String
   | UnboundVar String String
   | Default String

showError :: LispError -> String
showError (UnboundVar message varname) = message ++ ": " ++ varname
showError (BadSpecialForm message form) = message ++ ": " ++ show form
showError (NotFunction message func) = message ++ ": " ++ show func
showError (NumArgs expected found) = "Expected " ++ show expected
   ++ " args, found values " ++ unwordsList found
showError (TypeMismatch expected found) = "Expected " ++ show expected
   ++ ", found " ++ show found
showError (Parser parseErr) = "Parse error at " ++ show parseErr

instance Show LispError where show = showError

instance Error LispError where
   noMsg = Default "An error has occured."
   strMsg = Default

type ThrowsError = Either LispError

trapError action = catchError action (return . show)

extractValue :: ThrowsError a -> a
extractValue (Right val) = val

showVal :: LispVal -> String
showVal (String contents) = "\"" ++ contents ++ "\""
showVal (Atom name) = name
showVal (Number contents) = show contents
showVal (Bool True) = "#t"
showVal (Bool False) = "#f"
showVal (List contents) = "(" ++ unwordsList contents ++ ")"
showVal (DottedList head tail) = 
   "(" ++ unwordsList head ++ " . " ++ showVal tail ++ ")"

unwordsList :: [LispVal] -> String
unwordsList = unwords . map showVal

instance Show LispVal where show = showVal

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>@^_~" 

spaces :: Parser ()
spaces = skipMany1 space

escape :: Char -> Parser Char
escape x = (char '\\') >> (char x)

escapedChar :: Parser Char
escapedChar =
   escape '"' <|> escape 't' <|> escape 'n' <|> escape 'r' <|> escape '\\'
   

parseString :: Parser LispVal
parseString = do 
   char '"'
   x <- many $ escapedChar <|> (noneOf "\"") 
   char '"'
   return $ String x

parseAtom :: Parser LispVal
parseAtom = do first <- letter <|> symbol
               rest <- many (letter <|> digit <|> symbol)
               let atom = first:rest
               return $ case atom of 
                  "#t" -> Bool True
                  "#f" -> Bool False
                  otherwise -> Atom atom




parseDecimal :: Parser [Char]
parseDecimal = many1 digit

parseHex :: Parser [Char]
parseHex = do
   char '\\'
   char 'x' <|> char 'X'
   x <- many1 hexDigit
   return x

parseOctal :: Parser [Char]
parseOctal = do
   char '\\'
   char 'o' <|> char 'O'
   x <- many1 octDigit
   return x

parseInt :: Parser LispVal
parseInt = liftM (Number . read) $ parseDecimal <|> parseHex <|> parseOctal

parseExpr :: Parser LispVal
parseExpr = parseAtom 
   <|> parseString 
   <|> parseInt
   <|> parseQuoted
   <|> do char '('
          x <- (try parseList) <|> parseDottedList
          char ')'
          return x

parseList :: Parser LispVal
parseList = liftM List $ sepBy parseExpr spaces

parseDottedList :: Parser LispVal
parseDottedList = do
   head <- endBy parseExpr spaces
   tail <- char '.' >> spaces >> parseExpr
   return $ DottedList head tail

parseQuoted :: Parser LispVal
parseQuoted = do
   char '\''
   x <- parseExpr
   return $ List [Atom "quote", x]

-- http://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours/Parsing
readExpr :: String -> ThrowsError LispVal
readExpr input = 
   case parse parseExpr "lisp" input of
      Left err -> throwError $ Parser err
      Right val -> return val

eval :: LispVal -> ThrowsError LispVal
eval val@(String _) = return val
eval val@(Number _) = return val
eval val@(Bool _)   = return val
eval (List [Atom "quote", val]) = return val
eval (List (Atom func : args)) = mapM eval args >>= apply func
eval badForm = throwError $ BadSpecialForm "Unrecognized special form" badForm

apply :: String -> [LispVal] -> ThrowsError LispVal
apply func args = maybe
   (throwError $ NotFunction "Unrecognized primitive function args" func)
   ($ args)
   (lookup func primitives)

primitives :: [(String, [LispVal] -> ThrowsError LispVal)]
primitives =
   [("+", numericBinop (+)),
    ("-", numericBinop (-)),
    ("*", numericBinop (*)),
    ("/", numericBinop (div)),
    ("mod", numericBinop mod),
    ("quotient", numericBinop quot),
    ("remainder", numericBinop rem),
    ("=", numBoolBinop (==)),
    ("<", numBoolBinop (<)),
    (">", numBoolBinop (>)),
    ("/=", numBoolBinop (/=)),
    (">=", numBoolBinop (>=)),
    ("<=", numBoolBinop (<=)),
    ("&&", boolBoolBinop (&&)),
    ("||", boolBoolBinop (||)),
    ("string=?", strBoolBinop (==)),
    ("string<?", strBoolBinop (<)),
    ("string>?", strBoolBinop (>)),
    ("string>=?", strBoolBinop (>=)),
    ("string<=?", strBoolBinop (<=)),
    ("string/=?", strBoolBinop (/=))]

numericBinop :: (Integer -> Integer -> Integer) -> [LispVal] -> ThrowsError LispVal
numericBinop op singleVal@[_] = throwError $ NumArgs 2 singleVal
numericBinop op params = mapM unpackNum params >>= return . Number . foldl1 op

boolBinop :: (LispVal -> ThrowsError a) -> (a -> a -> Bool) -> [LispVal] -> ThrowsError LispVal
boolBinop unpacker op args = 
   if length args /= 2 then
      throwError $ NumArgs 2 args
   else do
      left <- unpacker $ args !! 0
      right <- unpacker $ args !! 1
      return $ Bool $ left `op` right

numBoolBinop = boolBinop unpackNum
strBoolBinop = boolBinop unpackStr
boolBoolBinop = boolBinop unpackBool

unpackStr :: LispVal -> ThrowsError String
unpackStr (String s) = return s
unpackStr (Number s) = return $ show s
unpackStr (Bool s) = return $ show s
unpack notString = throwError $ TypeMismatch "string" notString

unpackBool :: LispVal -> ThrowsError Bool
unpackBool (Bool b) = return b
unpackBool notBool = throwError $ TypeMismatch "boolean" notBool

unpackNum :: LispVal -> ThrowsError Integer
unpackNum (Number n) = return n
unpackNum (String n) = 
   let parsed = reads n in
      if null parsed then
         throwError $ TypeMismatch "number" $ String n
      else return $ fst $ parsed !! 0
unpackNum (List [n]) = unpackNum n
unpackNum notNum = throwError $ TypeMismatch "number" notNum
         
         

main :: IO ()
main = do
   args <- getArgs
   evaled <- return $ liftM show (readExpr (args !! 0) >>= eval)
   putStrLn $ extractValue $ trapError evaled
