---
layout: post
title: Disable rp_filter on unix
comments: true
---

Sometimes in a more complicated network setups you want to disable
rp_filtering.

For a good explanation of what rp_filter is and why it is enabled see this
excellent slashroot article [here][rp_filter_slashroot].

<!-- more -->

I came across a situation where one box had two NICs:

    # grep -Ev '^#.*$' /etc/network/interfaces

    auto lo
    iface lo inet loopback

    auto eth1
    iface eth1 inet static
    address 192.168.11.8
    netmask 255.255.255.0
    gateway 192.168.11.254
    dns-nameservers 192.168.11.4

    auto eth2
    iface eth2 inet static
    address 192.168.100.41
    netmask 255.255.255.0
    up route add default gw 192.168.100.254


From another box that was in the same 192.168.11.0/24 range I could only access
this machine over its 192.168.11.8 ip address. When I tried a ping, curl, wget,
ssh, telnet or whatever to 192.168.100.41 I got nothing.

A tcpdump on this box showed that packets on the 192.168.100.41 interface were
received but my machine had trouble sending the return packets causing the
above described behaviour. You get; Nothing.

And whenever I tried to access this box from a machine in the 192.168.100.0/24
network I got the same behaviour but with the 192.168.11.8 ip.

The routing table on this box looks like the following:

    # ip route
    192.168.11.0/24 dev eth1  proto kernel  scope link  src 192.168.11.8 
    192.168.100.0/24 dev eth2  proto kernel  scope link  src 192.168.100.41 
    default via 192.168.100.254 dev eth2 
    default via 192.168.11.254 dev eth1  metric 100

Since you cannot have two default routes the kernel tries to sent packets back
over the wrong interface.

I solved this by disabling [reverse path filtering][rp_filter].

To get your current kernel configuration run:

    sysctl -a | grep \\.rp_filter


To enable rp_filtering (persisted up until the next reboot)

    sysctl -w net.ipv4.conf.all.rp_filter=1
    sysctl -w net.ipv4.conf.default.rp_filter=1
    sysctl -w net.ipv4.conf.lo.rp_filter=1

    # Replace eth1 and eth2 with your interface names
    sysctl -w net.ipv4.conf.eth2.rp_filter=1
    sysctl -w net.ipv4.conf.eth1.rp_filter=1



To disable  rp_filtering (persisted up until the next reboot)

    sysctl -w net.ipv4.conf.all.rp_filter=0
    sysctl -w net.ipv4.conf.default.rp_filter=0
    sysctl -w net.ipv4.conf.lo.rp_filter=0

    # Replace eth1 and eth2 with your interface names
    sysctl -w net.ipv4.conf.eth2.rp_filter=0
    sysctl -w net.ipv4.conf.eth1.rp_filter=0


If you want to disable rp_filtering permanently create a file
`90-disable-rp_filter.conf` inside `/etc/sysctl.d` with the following 
contents:

    # cat /etc/sysctl.d/90-disable-rp_filter.conf 
    net.ipv4.conf.all.rp_filter=0
    net.ipv4.conf.default.rp_filter=0
    net.ipv4.conf.lo.rp_filter=0
    net.ipv4.conf.eth2.rp_filter=0
    net.ipv4.conf.eth1.rp_filter=0


[rp_filter]: http://tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.kernel.rpf.html
[rp_filter_slashroot]: http://www.slashroot.in/linux-kernel-rpfilter-settings-reverse-path-filtering
