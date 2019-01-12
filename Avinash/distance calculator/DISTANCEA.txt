//Code by Avinash to calculate distance between two places using latitude and longitude
//Haversine formula used
#include<iostream.h>
#include <math.h>
#include<conio.h>
#define earthRadiusKm 6371.0
double distanceEarth(double lat1d, double lon1d, double lat2d, double lon2d);
void main()
{
double lat1d,lon1d,lat2d,lon2d;
clrscr();
cout<<"Enter the latitude and longitude of initial position: \n";
cin>>lat1d;
cin>>lon1d;
cout<<"Enter the latitude and longitude of final position: \n";
cin>>lat2d;
cin>>lon2d;
 double distance = distanceEarth(lat1d,lon1d,lat2d,lon2d);
cout<<"The distane is : "<<distance;
 getch();
}
double deg2rad(double deg) {
  return (deg * M_PI / 180);
}

double rad2deg(double rad) {
  return (rad * 180 / M_PI);
}
double distanceEarth(double lat1d, double lon1d, double lat2d, double lon2d) {
  double lat1r, lon1r, lat2r, lon2r, u, v;
  lat1r = deg2rad(lat1d);
  lon1r = deg2rad(lon1d);
  lat2r = deg2rad(lat2d);
  lon2r = deg2rad(lon2d);
  u = sin((lat2r - lat1r)/2);
  v = sin((lon2r - lon1r)/2);

return 2.0 * earthRadiusKm * asin(sqrt(u * u + cos(lat1r) * cos(lat2r) * v * v));
}