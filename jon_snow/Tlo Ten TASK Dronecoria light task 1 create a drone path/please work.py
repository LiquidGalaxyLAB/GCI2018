import time
import dronekit
#Plot line chart

lat=[-77.6192,-77.6192,-77.6195,-77.6198,-77.6208,-77.6216,-77.6216,-77.6216]
lon=[43.1725,43.1725,43.1728,43.173,43.1725,43.1719,43.1719,43.1719,43.1719]
def arm_and_takeoff(aTargetAltitude):
    while not vehicle.is_armable:
        print " Waiting for vehicle to initialise..."
        time.sleep(1)
    vehicle.mode = VehicleMode("GUIDED")
    vehicle.armed = True

    while not vehicle.armed:
        print " Waiting for arming..."
        time.sleep(1)

    print "Taking off!"
    vehicle.simple_takeoff(aTargetAltitude)
    # Wait for takeoff to finish
    while True:
        print " Altitude: ", vehicle.location.global_relative_frame.alt
        if vehicle.location.global_relative_frame.alt>=aTargetAltitude*0.95: #Trigger just below target alt.
            print "Reached target altitude"
            break
        time.sleep(1)

def get_distance_metres(aLocation1, aLocation2):
    dlat = aLocation2.lat - aLocation1.lat
    dlong = aLocation2.lon - aLocation1.lon
    return math.sqrt((dlat*dlat) + (dlong*dlong)) * 1.113195e5

# define connection method
# see all the methods at http://python.dronekit.io/guide/connecting_vehicle.html
connection_string = "127.0.0.1:14550"

# Connect
vehicle = connect(connection_string, wait_ready=True)
# arm and takeooff to 10m
aTargetAltitude=input("Please enter the required altitude")
arm_and_takeoff(aTargetAltitude)
# set airspeed to 3 m/s
vehicle.airspeed = input("input air speed")

for (ilat,ilon) in zip(lat,lon):
    point1 = LocationGlobalRelative(ilat, ilon, aTargetAltitude)
    vehicle.simple_goto(point1)

    while vehicle.mode.name=="GUIDED": #Stop action if we are no longer in guided mode.
            remainingDistance=get_distance_metres(vehicle.location.global_frame, point1)
            print "Distance to target: ", remainingDistance
            if remainingDistance<=targetDistance*0.01: #Just below target, in case of undershoot.
                print "Reached target"
                break;
            time.sleep(2)
