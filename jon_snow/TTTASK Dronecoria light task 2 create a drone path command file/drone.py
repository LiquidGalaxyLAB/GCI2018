import time
import dronekit
import math
#Plot line chart

lat=[-35.363561,-35.5,-35.6,-35.7]
lon=[149.165230,149.3,149.4,149.5]
def arm_and_takeoff(aTargetAltitude):
    while not vehicle.is_armable:
        print (" Waiting for vehicle to initialise...")
        time.sleep(1)
    VehicleMode = dronekit.VehicleMode
    vehicle.mode = VehicleMode("GUIDED")
    vehicle.armed = True

    while not vehicle.armed:
        print (" Waiting for arming...")
        time.sleep(1)

    print ("Taking off!")
    vehicle.simple_takeoff(aTargetAltitude)
    # Wait for takeoff to finish
    while True:
        print (" Altitude: "+ str(vehicle.location.global_relative_frame.alt))
        if vehicle.location.global_relative_frame.alt>=aTargetAltitude*0.95: #Trigger just below target alt.
            print ("Reached target altitude")
            break
        time.sleep(1)

def get_distance_metres(aLocation1, aLocation2):
    dlat = aLocation2.lat - aLocation1.lat
    dlong = aLocation2.lon - aLocation1.lon
    return math.sqrt((dlat*dlat) + (dlong*dlong)) * 1.113195e5

# define connection method
# see all the methods at http://python.dronekit.io/guide/connecting_vehicle.html

# Connect
vehicle = dronekit.connect('tcp:127.0.0.1:5760', wait_ready=True)
# arm and takeooff to 10m
aTargetAltitude=input("Please enter the required altitude")
arm_and_takeoff(aTargetAltitude)
# set airspeed to 3 m/s
vehicle.airspeed = input("input air speed")

for (ilat,ilon) in zip(lat,lon):
    point1 = dronekit.LocationGlobalRelative(ilat, ilon, aTargetAltitude)
    vehicle.simple_goto(point1)
    targetDistance = get_distance_metres(vehicle.location.global_frame, point1)

    while vehicle.mode.name=="GUIDED": #Stop action if we are no longer in guided mode.
            remainingDistance=get_distance_metres(vehicle.location.global_frame, point1)
            print ("Distance to target: ", remainingDistance)
            if remainingDistance<=targetDistance*1: #Just below target, in case of undershoot.
                print ("Reached target")
                break;
            time.sleep(2)
