int main()
{
   int *ptr1, *ptr2;
   int a, b = 0;
   ptr1 = &a;
   ptr2 = &b;
   ptr1 = ptr2;
   ptr1 = &a;
   *ptr1 = *ptr2;
   return 0;
}
