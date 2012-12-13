//#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>

void Start();
void Compile();
void Stop();

unsigned long StartTime;

int main(int argc, char *argv[])
{
  Start();
  Compile();
  Stop();
  return 0;
}

void Start()
{
   StartTime = GetTickCount();
}

void Compile()
{
}

void Stop()
{
   printf( "Total time: %d ms\n", (unsigned int) (GetTickCount() - StartTime) );
}
