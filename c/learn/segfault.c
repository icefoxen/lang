/* Sets the address of a pointer at 0, which generally causes a 
segmentation fault.  Yay. */

main()
{
   int *x;
   x = 0;   /* Sets address to 0 */
   *x = 12; /* Sets value to 12 */
   printf( "%d %d", x, *x );
}