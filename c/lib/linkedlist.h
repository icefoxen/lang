/* linkedlist.h
 * Okay, as ye may have surmised, this is a linked-list implementation.
 * It seems to work so far, so let's build upon that.
 * Grr.
 * And if I have any problems with free() I'm going to bite something.
 *
 * Simon Heath
 * 26/9/2003
 */

#ifndef _LINKEDLIST_H
#define _LINKEDLIST_H

typedef void* ll_ptr;

/* YEEESH!  Defining recursive types in C is BITCHY!
 * So... many... hoops to jump through!  Even in OCaml this is normally
 * simple...
 */
typedef struct LL
{
   ll_ptr item;
   struct LL *next;
} LL;


LL* ll_getEnd( LL* lst );

void ll_add( LL* lst, void* itm );

void ll_remove( LL* lst, ll_ptr itm );

/* Starts counting at 0 */
void ll_removeIndex( LL* lst, int index );

/* Starts counting at 0 */
int ll_find( LL* lst, ll_ptr itm );

/* Starts counting from 0 */
ll_ptr ll_get( LL* lst, int index );

/* Starts counting from 1 */
int ll_length( LL* lst );

/* Does NOT free the items in the list!  Do that manually. */
void ll_free( LL* lst );

void ll_printNode( LL* lst );
void ll_printList( LL* lst );

void ll_concat( LL* lst1, LL* lst2 );

#endif /* _LINKEDLIST_H */
