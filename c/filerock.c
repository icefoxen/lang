#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

static const char* filename = "foo.txt";

int main() {
   int i;
   int f = open(filename, O_CREAT | O_TRUNC | O_WRONLY);
   close(f);
      f = open(filename, O_APPEND | O_WRONLY);
   for(i = 0; i < 1000; i++) {
      write(f, "Arrrrrrg!\n", 10);
      fsync(f);
   }
      close(f);
   return 0;
}
