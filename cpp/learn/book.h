
#ifndef _CLASSTEST_H
#define _CLASSTEST_H

#include <iostream>

using namespace std;


class Book
{
   private:
      string title;
      string author;
      string isbn;
      int published;
      int pages;

   public:
      Book::Book( string title, string author, string isbn, 
		  int published, int pages );
      string getTitle();
      string getAuthor();
      string getIsbn();
      int getPublished();
      int getPages();

      void printBook();

};


#endif
