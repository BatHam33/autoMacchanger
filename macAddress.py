#!/usr/bin/env python

import time, socket, fcntl, struct
import nmap

def get_ip_address(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

host_ip = get_ip_address('eth0')  # '192.168.0.110'
#print (host_ip)

#nmScan = nmap.PortScanner()
#nmScan.scan(host_ip)
subprocess.call('nmap', '-sP', host_ip)