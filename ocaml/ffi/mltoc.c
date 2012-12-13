/* mltoc.c
 * Tests using a C function in OCaml.
 *
 * Simon Heath
 * 25/4/2003
 */

/* Half of these are probably unnecessary for something so simple, but...
 */
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/custom.h>
#include <caml/intext.h>

CAMLprim value cpow( value n )
{
   int i;
   int final = 0;
   for( i = 0; i < n; i++ )
   {
      final += n;
   }

   return final;
}
