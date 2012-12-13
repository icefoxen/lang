#include <iostream>
#include <string>


class Reading{

   private:
   long   BookLength, BookMark, CurrentLine;
   string Book;
   string CurrentWord;
   int    TypeOfWord;
 

 public:


 

   Reading()
   {
      BookMark = 0; 
      CurrentLine = 1;
   }

   void OpenBook(string FileName);
   void GetNextWord();
   bool SkipWhiteSpace();
   void GetIdentifier();
   void GetNumber();
   void GetString();
   void GetSymbol();
   void CheckWordLength();
   string Word();
   int WordType();
   
   enum WordTypes
   {
      EndOfLine, 
      Identifier, 
      Number, 
      String, 
      Symbol, 
      None
   };

};

 
