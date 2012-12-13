/* book.cpp
 * Yeah.
 */

#include <book.h>

#include <iostream>

using namespace std;


Book::Book( string Title, string Author, 
	    string Isbn, int Published, int Pages )
{
   title = Title;
   author = Author;
   isbn = Isbn;
   published = Published;
   pages = Pages;
}

string Book::getTitle()
{
   return title;
}

string Book::getAuthor()
{
   return author;
}

string Book::getIsbn()
{
   return isbn;
}

int Book::getPublished()
{
   return published;
}

int Book::getPages()
{
   return pages;
}

void Book::printBook()
{
   cout << title << endl;
   cout << author << endl;
   cout << isbn << endl;
   cout << published << endl;
   cout << pages << endl;
}
