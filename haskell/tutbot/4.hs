import Control.Monad.Reader
import Control.Exception
import Data.List
import Network
import System.IO
import System.Exit
import Text.Printf
import Prelude hiding (catch)

server = "irc.hwcommunity.com"
port = 6667
chan = "#bottest"
nick = "tutbot"

-- The Net monad, a wrapper over IO, carrying the bot's immutable state
data Bot = Bot { socket :: Handle }
type Net = ReaderT Bot IO

-- Set up actions to run on start and end, then run the main loop.
main :: IO ()
main =
   bracket connect disconnect loop
  where
   disconnect = hClose . socket
   loop st    = catch (runReaderT run st) (const $ return ())

-- Connect to the server and return the initial bot state
connect :: IO Bot
connect = notify $ do
   h <- connectTo server (PortNumber (fromIntegral port))
   hSetBuffering h NoBuffering
   return (Bot h)
  where
   notify a = bracket_ 
      (printf "Connecting to %s... " server >> hFlush stdout)
      (putStrLn "done.")
      a

-- We're in the Net monad now, so we've connected
-- Join a channel and process commands.
run :: Net ()
run = do
   write "NICK" nick
   write "USER" (nick ++ " 0 * :tutorial bot")
   write "JOIN" chan
   asks socket >>= listen

-- Process each line from the server
eval :: String -> Net ()
eval "!quit" = 
   write "QUIT" ":Exiting" >> io (exitWith ExitSuccess)

eval x | "!id" `isPrefixOf` x = 
   privmsg (drop 4 x)

eval _ =
   return ()


-- We're in the Net monad now, so 


write :: String -> String -> Net ()
write s t = do
   h <- asks socket
   io $ hPrintf h "%s %s\r\n" s t
   io $ printf    "> %s %s\n" s t

listen :: Handle -> Net ()
listen h = forever $ do
   s <- init `fmap` io (hGetLine h)
   io (putStrLn s)
   if ping s then pong s else eval (clean s)
  where
   forever a = a >> forever a 
   clean = drop 1 . dropWhile (/= ':') . drop 1
   ping x = "PING :" `isPrefixOf` x
   pong x = write "PONG" (':' : drop 6 x)

privmsg :: String -> Net ()
privmsg s = write "PRIVMSG" (chan ++ " :" ++ s)


io :: IO a -> Net a
io = liftIO

