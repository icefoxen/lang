

#include <iostream>
#include <exception>

using namespace std;

class myException: /* public */ exception
{
   public:
      /* char*, not string?  Evil. */
      virtual const char* what()
      {
	 return "My exception happened!";
      }
};

int main()
{
   myException myex;
   try
   {
      throw myex;
   }
   catch( myException& e )
   {
      cout << e.what() << endl;
   }
   return 0;
}
