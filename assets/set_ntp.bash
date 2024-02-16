#!/bin/bash

systemctl stop chronyd
systemctl disable chronyd
systemctl stop ntpd
ntpdate 10.15.38.1
sleep 1
systemctl start ntpd

