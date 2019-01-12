import csv
import simplekml

inputfile = csv.reader(open('placemarks.csv','r'))
kml=simplekml.Kml()

for row in inputfile:
  kml.newpoint(name=row[0], coords=[(row[1],row[2])])


with open('placemarks.csv') as csvfile:
    coordinates = [(float(y), float(z)) for x, y, z in csv.reader(csvfile, delimiter= ',')]


ls = kml.newlinestring(name='Drone Path')
ls.coords = coordinates
ls.tessellate = 1
ls.style.linestyle.width = 5
ls.style.linestyle.color = simplekml.Color.aqua

kml.save('dronepath.kml')
