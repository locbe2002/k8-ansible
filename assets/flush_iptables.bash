#!/bin/bash

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Filter table
iptables -F
iptables -X
iptables -Z

#nat table
iptables -t nat -F
iptables -t nat -X
iptables -t nat -Z

# mangle table
iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -Z

# raw table
iptables -t raw -F
iptables -t raw -X
iptables -t raw -Z

# ip6tables
ip6tables -P INPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -P OUTPUT ACCEPT

# Filter table
ip6tables -F
ip6tables -X
ip6tables -Z

#nat table
ip6tables -t nat -F
ip6tables -t nat -X
ip6tables -t nat -Z

# mangle table
ip6tables -t mangle -F
ip6tables -t mangle -X
ip6tables -t mangle -Z

# raw table
ip6tables -t raw -F
ip6tables -t raw -X
ip6tables -t raw -Z

