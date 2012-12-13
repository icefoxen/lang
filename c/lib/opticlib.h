/* This is a library of functions for optics.
 * Physics, yaknow.  Refraction in materials, lenses, that kinda stuff.
 *
 * Simon Heath
 * 8/11/2002
 */

#ifndef _opticlib_h
#define _opticlib_h

/* Speed of light in a vacuum --297,000 m/s
 * AKA c */
#define SPDLIGHT 297000.0


/* Finds the index of refraction in a substance, given the speed of light
 * in the substance.
 * Equation is:
 * ng = c / vg
 * where ng is the index of refraction, c is speed of light in a vacuum,
 * and vg is the velocity of light in the substance.
 */
double indexRef( double vG );



/* Calculate the angle of refraction at an interface between two substances
 * as determined by Snell's Law:
 * n1 * sin( theta1 ) = n2 * sin( theta2 )
 * where n is the index of refraction of the substance, and theta is
 * the angle from the normal.
 */

/* Takes n1, theta1, and n2, and returns the angle of n2.
 */
double snellAngle( double n1, double theta1, double n2 );

/* Takes n1, theta1, and theta2, and returns the index of refraction of n2.
 */
double snellIndex( double n1, double theta1, double theta2 );


/* Returns the magnification factor of a lens.
 * Equation is:
 * m = Hi / Ho
 */
double magFactor( double imageH, double objectH );





#endif  /* end _opticlib_h */
