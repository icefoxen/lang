/* Allegedly a Pong game.
   Hmm.
 */

#include <stdio.h>
#include <stdlib.h>
#include <allegro.h>

#define DOWN_RIGHT 0
#define UP_RIGHT   1
#define DOWN_LEFT  2
#define UP_LEFT    3

#define SCREEN_WIDTH   800
#define SCREEN_HEIGHT   600



/* Bitmaps for the sprites loaded from files, and for the screen buffer. */
BITMAP *ball_image, *paddle_image, *buffer;
RGB ball_palette[256], paddle_palette[256];

/* Ball structure --holds location and direction */
typedef struct BALL
{
   int x;
   int y;
   int direction;
} BALL;

BALL ball;

/* paddle positions */
int paddle1_x = 30;
int paddle2_x = SCREEN_WIDTH - 30;

/* Score */
int p1_score = 0;
int p2_score = 0;

/* Ball speed */
int speed = 2;


/* Does pretty much what you'd expect */
void ErrorAndDie()
{
   allegro_exit();
   printf( "Error: %s\n", allegro_error );
   exit( 1 );
}

/* Loads bitmaps */
void LoadBitmaps()
{
   ball_image = load_bitmap( "ball.bmp", ball_palette );
   paddle_image = load_bitmap( "paddle.bmp", paddle_palette );
   buffer = create_bitmap( SCREEN_WIDTH, SCREEN_HEIGHT );
   clear( buffer );
   if( ball_image == NULL || paddle_image == NULL || buffer == NULL )
      ErrorAndDie();
   
   /* Set palette for the sprites... kinda... */
   set_palette( ball_palette );
}

void move_ball()
{
   /* Figure out /where/ to move the ball */
   switch( ball.direction )
   {
      case DOWN_RIGHT:
            ball.x += speed;
            ball.y += speed;
            if( (ball.y >= paddle2_x - 20) );
      
      if( ball.x > SCREEN_HEIGHT );
      if( ball.y > SCREEN_WIDTH );
      if( ball.x < 0 );
      if( ball.y < 0 );
   }
}


void pong_game()
{
   ball.direction = rand() % 3;
   
   /* Mainloop!  Yaay! */
   while( !( key[KEY_ESC] || key[KEY_Q] ) )
   {
      move_ball();
      
      textout( buffer, font, itoa( ball.x, NULL, 10 ), 10, 10, 1 );
      textout( buffer, font, itoa( ball.y, NULL, 10 ), 10, 80, 1 );
      
      /* Draw a line to set the boundries */
      line( buffer, 0, 30, SCREEN_WIDTH, 30, 10 );
      
      /* Blit the buffer  to the screen */
      blit( buffer, screen, 0, 0, 0, 0, 640, 480 );
      
      /* Clear the buffer */
      clear( buffer );
   }
   
   return;
}


int main()
{
   /* Init random generator */
   srand( 19421 );

   /* Init Allegro */
   allegro_init();
   install_timer();
   install_keyboard();
   install_mouse();
   
   printf( "Setting up sound.\n" );
   if( install_sound( DIGI_AUTODETECT, MIDI_AUTODETECT, NULL ) != 0 )
      ErrorAndDie();
   
   LoadBitmaps();
   
   printf( "Setting graphics mode\n" );
   if( set_gfx_mode( GFX_AUTODETECT, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0 ) != 0 )
      ErrorAndDie();
   
   /* Set ball in the middle of the wossname */
   ball.x = SCREEN_WIDTH / 2;
   ball.y = SCREEN_HEIGHT / 2;

   /* Play da game */
   pong_game();
   
   /* Exit the game */
   allegro_exit();
   return 0;
}
END_OF_MAIN()
