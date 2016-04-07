Funny-FTP is designed to be an incredibly simple to deploy FTP honeypot which will allow malicious users to scan, probe, fingerprint, and brute force a fake FTP service while preventing the malicious attempt from compromising your system.

This is useful to system administrators because it allows them to collect evidence of hacking attempts which can help planning on security budgets and what actions to take. Additionally, it fatigues hacking attempts. Often times, malicious users look for weak targets. If they are unable to gain access within a reasonable amount of time, they will look for a new target. Funny-FTP will waste the malicious user's time that they could have spent finding real vulnerabilities on your server.

## Installing
Funny-FTP requires tools included in the Nmap package. For Linux systems, your distro repo will most likely allow for a streamlined package download if it is not already included in your distro. Ubuntu or Debian users can install it using the following command when connected to the Internet:
`sudo apt-get install nmap`
Windows users can follow the instructions on the following link to setup nmap on their system:
[https://nmap.org/book/inst-windows.html](https://nmap.org/book/inst-windows.html)

After Nmap is installed and working, you will need the "funny-ftp.lua" script located in the [https://github.com/Eggsanity/funny-ftp/](https://github.com/Eggsanity/funny-ftp/) git repo. This file can be placed anywhere, but an easy-to-find place is recommended for your convenience. Also keep in mind all Funny-FTP usage examples will assume that the "funny-ftp.lua" script is in the current working directory from your terminal/shell.

## Launching
Funny-FTP follows a "just enough" philosophy. It makes use of Nmap utilities to do most of the heavy listing since Nmap is a common tool for System Administrators. Ncat, a utility included with Nmap, is the intended way to launch Funny-FTP. All following examples will assume Ncat is in your shell's path since this is the default and recommended way to setup Nmap.

### The most basic way to start Funny-FTP
In a command shell/terminal or over an SSH connection, ENTER the following command:
`ncat -vklp 21 --lua-exec funny-ftp.lua`
**ncat** - the default command to call Ncat
**-vklp 21** - 'v' to increase terminal verbosity (optional), 'k' allows for multiple simultaneous connections, 'l' tells ncat to listen to a port, 'p 21' tells Ncat to use port 21, a widely known default FTP port, other ports can be used if preferred.
**--lua-exec funny-ftp.lua** - Launches the funny-ftp.lua script for each user connecting. (note: if this script is not in the current working directory you will need to include the full file path to the funny-ftp.lua script).

NOTE: This command may require admin/root or otherwise elevated privileges to bind to port 21. If you would like to do this without using elevated privileges try binding to another port greater than 1024. The service can be stopped by pressing [control]+[c] inside the terminal.

### Limiting maximum connected users
`ncat -vklp 21 -m 10 --lua-exec funny-ftp.lua`
**-m 10** - No more than 10 connections will be established at a time. The number can be changed accordingly to your preferences. This is useful to protect against the possibility of a significant number of malicious users from consuming more bandwidth than what your server can afford.

### Blocking IP addresses from connecting to the Funny-FTP service
`ncat -vklp 21 --deny 192.168.0.2,192.168.0.3 --lua-exec funny-ftp.lua`
**--deny** - IP addresses separated with a comma (if more than one IP is given) that follow the '--deny' flag will prevent those IP addresses from connecting to Funny-FTP. This is useful if an IP address has been banned from other services that are already known, and you prefer the IP addresses to also be banned from the Funny-FTP service. You can also specify a file containing a list of IP addresses with the '--denyfile' flag.

### More?
More options you can utilize can be found in the Ncat manual located here: [http://man7.org/linux/man-pages/man1/ncat.1.html](http://man7.org/linux/man-pages/man1/ncat.1.html)

## Traffic capturing
Due to the "just enough" philosophy Funny-FTP follows, it doesn't log information by itself. To best allow admins to choose what information to log--where, when and how--there is no better way than to let them use the traffic sniffing tool of their choice. Tcpdump is a popular command-line tool for traffic capturing. For those preferring a graphical interface Wireshark may be used. You are not limited to just the tools mentioned prior. If you wish to collect traffic from Funny-FTP simply set a capture filter on your chosen packet sniffer to the port your Funny-FTP service is running on.
