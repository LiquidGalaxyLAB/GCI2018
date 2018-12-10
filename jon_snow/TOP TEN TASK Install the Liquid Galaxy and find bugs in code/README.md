copy of conversation

I think it is working now :)
attachment IMG_20181117_130436.jpg (4.9 MB)

Also, since this installation does not seem to be working, can I manually edit the configuration files to create a liquid galaxy like setup to complete the other tasks?

Óscar Carrasco November 14, 2018 at 18:43 (India Standard Time)
About your question, jon_snow: No reason at all to use class A subnets, I guess. It's not a critical factor in terms of the software implementation though.

jon_snow November 13, 2018 at 21:44 (India Standard Time)
I also had a question. Why does the script the hosts file to be of the form 10.42.<octet>
jon_snow November 13, 2018 at 21:43 (India Standard Time)
So, I reinstalled everything as you specified and the problem still persists. While installing the slave, I noticed it said sudo unable to resolve host
attachment IMG_20181113_213536.jpg (5.7 MB)

Óscar Carrasco November 13, 2018 at 15:19 (India Standard Time)
Use the password you've set for your distro. If your user and password in Ubuntu are both "lg", you'll then have to use those.
face
jon_snow November 13, 2018 at 07:44 (India Standard Time)
Also, while installing the script for the machine user password, am I supposed to put in lg user password(that the instructions ask me to) or lg password(that the script asks me to)

Óscar Carrasco November 13, 2018 at 03:40 (India Standard Time)
I doubt it. We often use "lg" both as user and password for ease of configuration. You might want to try reinstalling your Liquid Galaxy system at this point, though.
face
jon_snow November 12, 2018 at 23:38 (India Standard Time)
Maybe it is because my systems have a password?
face
jon_snow November 12, 2018 at 23:37 (India Standard Time)
I did that and it is back to the original connect to host, connection times out error

Óscar Carrasco November 12, 2018 at 19:12 (India Standard Time)
Before reinstalling anything, restore the /etc/hosts file and add the address to master. Just in case there is a chance of getting it working without a reinstallation.

Óscar Carrasco November 12, 2018 at 19:11 (India Standard Time)
That might happen because the keys are not made for the ip addresses that you changed in the /etc/hosts file. I'd suggest you to reinstall Liquid Galaxy on each computer, then configure the master subnet address with "ip addr add 10.42.<octet>.1 dev wlp3s0".
face
jon_snow November 12, 2018 at 18:54 (India Standard Time)
I changed the ip addresses in the host file in order for the script to work but it then shows a remote host identification has changed error and ends with a host key verification failed error
face
jon_snow November 12, 2018 at 18:30 (India Standard Time)
These are the logs
face
jon_snow November 12, 2018 at 18:29 (India Standard Time)
deathsatyr@lg1:~$ ifconfig
enp2s0 Link encap:Ethernet HWaddr c8:5b:76:57:07:cd 
UP BROADCAST MULTICAST MTU:1500 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000 
RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)

lo Link encap:Local Loopback 
inet addr:127.0.0.1 Mask:255.0.0.0
inet6 addr: ::1/128 Scope:Host
UP LOOPBACK RUNNING MTU:65536 Metric:1
RX packets:750 errors:0 dropped:0 overruns:0 frame:0
TX packets:750 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000 
RX bytes:67385 (67.3 KB) TX bytes:67385 (67.3 KB)

wlp3s0 Link encap:Ethernet HWaddr 34:e6:ad:7f:2d:49 
inet addr:192.168.1.4 Bcast:192.168.1.255 Mask:255.255.255.0
inet6 addr: fe80::faec:5186:35bd:b548/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:4640 errors:0 dropped:0 overruns:0 frame:0
TX packets:2320 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000 
RX bytes:4324802 (4.3 MB) TX bytes:336393 (336.3 KB)
face
jon_snow November 12, 2018 at 18:28 (India Standard Time)
deathsatyr@lg1:~$ ping lg2
PING lg2 (10.42.42.2) 56(84) bytes of data.
^C
--- lg2 ping statistics ---
19 packets transmitted, 0 received, 100% packet loss, time 18424ms

deathsatyr@lg1:~$ service ssh status
● ssh.service - OpenBSD Secure Shell server
Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enab
Active: active (running) since Mon 2018-11-12 17:50:51 IST; 30min ago
Process: 2937 ExecReload=/bin/kill -HUP $MAINPID (code=exited, status=0/SUCCES
Process: 2932 ExecReload=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
Process: 1057 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
Main PID: 1062 (sshd)
CGroup: /system.slice/ssh.service
└─1062 /usr/sbin/sshd -D

Nov 12 18:02:02 lg1 systemd[1]: Reloading OpenBSD Secure Shell server.
Nov 12 18:02:02 lg1 sshd[1062]: Received SIGHUP; restarting.
Nov 12 18:02:02 lg1 systemd[1]: Reloaded OpenBSD Secure Shell server.
Nov 12 18:02:02 lg1 sshd[1062]: Server listening on 0.0.0.0 port 22.
Nov 12 18:02:02 lg1 sshd[1062]: Server listening on :: port 22.
Nov 12 18:09:32 lg1 systemd[1]: Reloading OpenBSD Secure Shell server.
Nov 12 18:09:32 lg1 sshd[1062]: Received SIGHUP; restarting.
Nov 12 18:09:32 lg1 systemd[1]: Reloaded OpenBSD Secure Shell server.
Nov 12 18:09:32 lg1 sshd[1062]: Server listening on 0.0.0.0 port 22.
Nov 12 18:09:32 lg1 sshd[1062]: Server listening on :: port 22.
face
jon_snow November 12, 2018 at 18:26 (India Standard Time)
Also I can run the ssh statements with the ip of the system but not lg1/2
face
jon_snow November 12, 2018 at 18:25 (India Standard Time)
Service ssh status tells me that the service is and running and Is listening on port 22, both the ping statements receive no packets and end with a hundred packet loss.

Óscar Carrasco November 12, 2018 at 17:51 (India Standard Time)
Since your ssh connection is timing out, I guess the issue might be in a misconfiguration on the network interfaces, or the OpenSSH server just turned off for some reason. If you still have issues, you can send me the outputs for "ifconfig" and "ping lg1", "ping lg2" and "service ssh status" so we can investigate further on what's going on with the installation.

Óscar Carrasco November 12, 2018 at 17:48 (India Standard Time)
check the output for "service ssh status"
face
jon_snow November 12, 2018 at 17:43 (India Standard Time)
lg-relaunch, lg-run all give the same ssh error
assignment_late
jon_snow November 12, 2018 at 17:41 (India Standard Time)
Submitted for review
face
jon_snow November 12, 2018 at 17:41 (India Standard Time)
Is there any particular file that I should look at that the error might lie in?
face
jon_snow November 12, 2018 at 17:41 (India Standard Time)
and following that the message was able to show my ip address. However, ssh commands are still not able to run and show the error connection timed out. Also, the system boots into the message and not the google earth window
face
jon_snow November 12, 2018 at 17:39 (India Standard Time)
These are the errors that i faced so far. When I first rebooted the system, the message the popped up didn't show an ip address, so i edited startup-script.sh and found out that my system doesn't have eth0 and instead has wlp3s0, so I chnaged eth0 with wlp3s0