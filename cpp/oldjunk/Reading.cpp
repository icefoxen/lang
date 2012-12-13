#include "Reading.h"


void Reading::OpenBook( string FileName )
{
   ifstream File( FileName.c_str(), ios::in );
   long FileStart;
   long FileEnd
   char *temp;
   
   if( File.is_open() == false )
   {
      printf( "Error!  Could not open file %s", FileName );
      exit( 1 );
   }
   
   FileStart = File.tellg();
   File.seekg( 0, ios::end );
   FileEnd = File.tellg();
   File.seekg( 0, ios::beg );
   temp = new char[FileEnd - FileStart];
   File.read( temp, FileEnd - FileStart );
   Book = temp;
   BookLength = Book.length();
   delete[] temp;
   File.close();
   return;
}
