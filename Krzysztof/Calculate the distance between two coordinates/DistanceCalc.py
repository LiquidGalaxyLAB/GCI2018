import geopy.distance

print("Insert first coordinates")
lat1 = float(input("Latitude: "))
lon1 = float(input("Lontitude: "))
print("Insert second coordinates")
lat2 = float(input("Latitude: "))
lon2 = float(input("Lontitude: "))

firstCords = (lat1, lon1)
secondCords = (lat2, lon2)

print(geopy.distance.vincenty(firstCords, secondCords).km + " Kilometers")