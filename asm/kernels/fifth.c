void main()
{
   char *screenptr = 0xb8000;
   int i;

   for( i = 0; i < 1000; i++ )
   {
      *screenptr = i % 255;
      screenptr++;
   }
   while( 1 );
}
