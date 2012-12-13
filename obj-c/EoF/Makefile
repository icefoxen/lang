# I hate make and this probably won't even work better than my fucked-up shell
# scripts.  Let's give it a try anyway.


INCS = -I/sys/dev/dev-cpp/include -I/sys/dev/dev-cpp/include/SDL -I./include
FILES = EoF.m LinkedList.m ConfigParser.m Sprite.m util.m

LIBPATH = -L./ -Ld:/sys/dev/dev-cpp/lib
LIBS = -lobjc -lmingw32 -lSDLmain -lSDL -lSDL_image -lSDL_gfx
OBJS = EoF.o LinkedList.o ConfigParser.o Sprite.o util.o

build: clean compile link
	echo built!

compile: $(FILES)
	gcc -c -Wall -Wno-import $(INCS) $(FILES)

link: compile
	gcc -Wall $(LIBPATH) -o EoF.exe $(LIBS) $(OBJS)


