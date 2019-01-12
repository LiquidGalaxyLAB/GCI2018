#!/usr/bin/python
import os
import sys


# directory to queries file
queries_directory = '/var/www/html/queries.txt'
# open exported file
kml_file = open(sys.argv[1])
# read file
doc = kml_file.read()
# close file
kml_file.close()

points_list = []
position = 0

# loop for every point
while doc.find("<Placemark>", position) > -1:
    # update position
    position = doc.find("<Placemark>", position) + 1
    # save name
    name = doc[doc.find("<name>", position) + 6: doc.find("</name>", position)]
    # save the rest of point
    look_at = doc[doc.find("<LookAt>", position): doc.find("</LookAt>", position) + 9]\
        .replace("	", "")\
        .replace("\n", "")
    # add point to list
    points_list.append("earth@{0}@flytoview={1}\n".format(name, look_at))

# open file in appending mode
directory_file = open(os.path.join(queries_directory), "a")

for i in points_list:
    # write new line in file
    directory_file.write(i)

# close file
directory_file.close()
