#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
//VARIABLE DECLARATION
  double a;
  double c;
  double r = 6371000; //EARTH RADIUS
  double distance;
  double lat1 = 41.61717152974034 * 0.0174533; //LATITUDE OF POINT 1 (FROM DEGREES TO RADIANS)
  double lon1 = 0.6209071229335139 * 0.0174533; //LONGITUDE OF POINT 1 (RADIANS)
  double lat2 = 41.38527893985712 * 0.0174533; //LATITUDE OF POINT 2 (RADIANS)
  double lon2 = 2.173889075146671 * 0.0174533; //LONGITUDE OF POINT 2 (RADIANS)
  double deltalat = lat2 - lat1;
  double deltalon = lon2 - lon1;

//DISTANCE COMPUTING (HARVESINE METHOD)
  a = sin(deltalat/2) * sin(deltalat/2) + cos(lat1) * cos(lat2) * sin(deltalon/2) * sin(deltalon/2);
  c = 2 * atan2(sqrt(a), sqrt(1-a));
  distance = r * c;
//OUTPUT IN METERS
  printf("%f", distance);

  return 0;
}
