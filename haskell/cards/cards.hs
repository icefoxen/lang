module Cards where

data Card = Card Suit Face
data Suit = Hearts
          | Spades
          | Diamonds
          | Clubs
data Face = Jack
          | Queen
          | King
          | Ace
          | Number Int

instance Show Suit where
   show Hearts = "Hearts"
   show Spades = "Spades"
   show Diamonds = "Diamonds"
   show Clubs = "Clubs"

instance Show Face where
   show Jack = "Jack"
   show Queen = "Queen"
   show King = "King"
   show Ace = "Ace"
   show (Number i) = show i

instance Show Card where 
   show (Card s f) = (show f) ++ " of " ++ (show s)

newDeck =
   let faces = [Number 2, Number 3, Number 4, Number 5, Number 6, Number 7,
                Number 8, Number 9, Number 10, Jack, Queen, King, Ace] in
   let makeCard = \x y -> Card x y in
      (map (makeCard Hearts) faces) ++ (map (makeCard Spades) faces) ++
         (map (makeCard Diamonds) faces) ++ (map (makeCard Clubs) faces)

shuffle deck =
   ()

draw deck n =
   ()

