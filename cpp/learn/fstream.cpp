// fstream.cpp
// file copy stuff.
// whooo.
// 1/2/2004

using namespace std;

#include <iostream>
#include <fstream>

int main()
{
   ifstream infile;
   ofstream outfile;
   ofstream printer;
   char filename[32];

   cout << "Enter desired filename to copy: ";
   cin >> filename;
   
   infile.open( filename );
   if( !infile )
   {
      cout << "Input file could not be created\n";
      exit( 1 );
   }
   
   outfile.open( "copy" );
   if( !outfile )
   {
      cout << "Output file could not be created\n";
      exit( 1 );
   }

   printer.open( "/dev/tty" );  // Silly, yes.  Fun tho.
   if( !printer )
   {
      cout << "Printer file could not be created\n";
      exit( 1 );
   }
   
   char c;
   printer << "This is the beginning of the printed copy" << endl << '*';
   while( infile.get( c ) )
   {
      outfile.put( c );
      printer.put( c );
      if( c == '\n' )
         printer.put( '*' );
   }
   
   infile.close();
   outfile.close();
   printer.close();

   return 0;
      
}
