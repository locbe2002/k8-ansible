#!/usr/bin/python

import sys
import os.path

insert_str="EnvironmentFile=/etc/sysconfig/service_env_proxy\n"
match_str1 = '[Service]'
match_str2 = '['

if len(sys.argv) < 2:
   zmsg = "Usage: " + sys.argv[0] + " serviceFile"
   print zmsg
   exit(-1)

fx = sys.argv[1]
 
if not os.path.isfile(fx):
   zmsg = "File " + fx + " does not exist"
   print zmsg
   exit(-1)  

timetoadd = False
with open(fx, 'r+') as fd:
    contents = fd.readlines()
    if "[Service" in contents[-1]:  # Handle last line to prevent IndexError
        contents.append(insert_string)
    else:
        for index, line in enumerate(contents):
            if match_str1 in line:
                timetoadd = True
            elif match_str2 in line and timetoadd:
                contents.insert(index - 1, insert_str)
                zmsg = "Added env sourcing to " + fx
                print zmsg
                break
    fd.seek(0)
    fd.writelines(contents)
exit(0)
