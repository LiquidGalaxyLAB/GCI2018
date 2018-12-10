I faced a couple of errors. 1. Ever since protobufjs has been upgraded from v5 to v6, there is this repeated not a function error. S o i had to change the packages.json in order to get the correct npm installation. This is my final packages.json

2. There was some error with the server.js file because of which even though it showed that it was running, the link wouldn't load. So i wrote my own server.js file, the code of which is here

3. I had to configure the hosts file on the slave to resolve the domain of the master

However, it still doesn't work. The script I wrote loads the displays and the links but I'm not able to get the slave to follow the master. And for the server.js that was part of the source code, as can be seen from the image even though terminal shows the server running I am not able to connect to it
