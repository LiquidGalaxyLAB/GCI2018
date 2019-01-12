#include <iostream>
#include <cmath>
#include <math.h>
#include <iomanip> //setprecision
using namespace std;

long double fct (long double degrees) //for converting degrees to radians
{
    return ((M_PI/180)*degrees);
}

long double receiveDistance (long double latitude1, long double longitude1, long double latitude2, long double longitude2)
{
    long double radius=6371; //km
    latitude1=fct(latitude1); //convert to radians;
    longitude1=fct(longitude1);
    latitude2=fct(latitude2);
    longitude2=fct(longitude2);
    long double distanceLatitude = latitude2-latitude1;
    long double distanceLongitude = longitude2-longitude1;
    long double a=pow(sin(distanceLatitude/2),2)+cos(latitude1)*cos(latitude2)*pow(sin(distanceLongitude/2),2);
    a=2*asin(sqrt(a));
    a=a*radius;
    return a;
}

int main()
{
    long double latitude1, longitude1, latitude2, longitude2;
    cout<<"latitude1= ";cin>>latitude1;
    cout<<"longitude1= ";cin>>longitude1;
    cout<<"latitude2= ";cin>>latitude2;
    cout<<"longitude2= ";cin>>longitude2;
    cout<<setprecision(15)<<fixed<<receiveDistance(latitude1,longitude1,latitude2,longitude2)<<"Km";
    return 0;
}
