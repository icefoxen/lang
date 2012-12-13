/* inspect.c 
   Show the binary representation of Ocaml types.
   Muahahahaha!!!  I love it!

   To compile: 
   ocamlmktop -custom -o inspector inspect.ml inspectc.c

   Simon Heath
   9/09/2004
*/


#include <stdio.h>
#include <caml/mlvalues.h>

value inspect_dostuff( value v, int i );
value inspect( value v );

void margin( int m )
{
   while( m-- > 0 )
      printf( "." );
      return;
}

void print_block( value v, int m )
{
   int size, i;
   margin( m );
   size = Wosize_val( v );

   switch( Tag_val( v ) )
   {
      case Closure_tag:
         printf( "Closure with %d free variables\n", size - 1 );
	 margin( m + 1 );
	 printf( "Code pointer: %p\n", Code_val( v ) );
	 for( i = 1; i < size; i++ )
	    print_block( Field( v, i ), m + 1 );
	 break;
      case String_tag:
         printf( "String: %s (%s)\n", String_val( v ), (char*) v );
	 break;
      case Double_tag:
         printf( "Float: %g\n", Double_val( v ) );
	 break;
      case Double_array_tag:
         printf( "Float array: " );
	 for( i = 0; i < (size / Double_wosize); i++ )
	    printf( " %g", Double_field( v, i ) );
	 printf( "\n" );
	 break;
      case Abstract_tag:
         printf( "Abstract type; not much we can do with that\n" );
	 break;
      /*case Final_tag: 
         printf( "Abstract finalized type\n" );
	 break; */
      default:
         if( Tag_val( v ) >= No_scan_tag )
	 {
	    printf( "Unknown tag\n" );
	    break;
	 }
	 printf( "Structured block (tag=%d):\n", Tag_val( v ) );
	 /* XXX: Causes segfault.  Why???!!! */
	 for( i = 0; i < size; i++ )
	 {
	    inspect_dostuff( Field( v, i ), m + 1 );
	 }
   }

   return;
}


value inspect_dostuff( value v, int m )
{
   margin( m );
   if( Is_long( v ) )
   {
      printf( "This is a number: %d  (Literally %d)  (0x%X : 0x%X)\n", 
              Long_val( v ), (long) v, Long_val( v ), (long) v );
   }
   else if( Is_block( v ) )
   {
      printf( "This is a pointer: 0x%X\n", (long) v );
      margin( m );
      printf( "This block has a size %d and a tag 0x%X\n", Wosize_val( v ),
              Tag_val( v ) );
      print_block( v, m );
   }
   else
   {
      printf( "This isn't a pointer or integer.  Weeeeird.\n" );
   }
   fflush( stdout );
   return v;
}


value inspect( value v )
{
   return inspect_dostuff( v, 1 );
}

