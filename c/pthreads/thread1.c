/* pthread.c
 * Demonstrates Posix threads
 * Yay!
 *
 * Simon Heath
 * 3/9/2003
 */


#include <stdio.h>
#include <pthread.h>

void do_one_thing( int * );
void do_another_thing( int * );
void do_wrap_up( int, int );

int r1 = 0;
int r2 = 0;

int main()
{
   int i;

   pthread_t thread1, thread2;

   /* pthread_create() creates a new thread.
    * It's args are: the thread object to create, a thread attribute object
    * (NULL here means default), a process pointer, and an argument pointer
    */
   pthread_create( &thread1, NULL, (void *) do_one_thing, (void *) &r1 );
   pthread_create( &thread2, NULL, (void *) do_another_thing, (void *) &r2 );

   for( i = 0; i < 6; i++ )
   {
      printf( "Parent waiting\n" );
      sleep( 1 );
   }

   pthread_join( thread1, NULL );
   pthread_join( thread2, NULL );

   do_wrap_up( r1, r2 );

   return 0;
}


void do_one_thing( int *times )
{
   int i;

   for( i = 0; i < 4; i++ )
   {
      printf( "Doing one thing:\n" );
      (*times)++;

      sleep( 1 );
   }
}

void do_another_thing( int *times )
{
   int i;

   for( i = 0; i < 4; i++ )
   {
      printf( "Doing another:\n" );
      (*times)++;

      sleep( 1 );
   }
}

void do_wrap_up( int one, int another )
{
   printf( "Wrap up: one thing %d, another %d, total %d\n",
      one, another, one + another );
}
