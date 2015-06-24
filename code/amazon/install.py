#!/usr/bin/python

import boto.ec2
import boto.ec2.address
import sys

def create_instance(connection):
    instance_t = "t2.micro"
    # image = "ami-bf0897c8"
    # image = "ami-c5bdf8b2"
    #ownimage PV
    #image = "ami-e4c18493"
    #own image HVM
    image = "ami-62ade915"


    connection.run_instances(image, key_name='amazon_harm_dermois',security_group_ids=['sg-62e4da07',
    'sg-8ec1ffeb'], instance_type=instance_t)
nr_instances = 0
if len(sys.argv) > 1:
    nr_instances= int(sys.argv[1])

connection = boto.ec2.connect_to_region("eu-west-1")

print connection.get_all_instance_status()
print connection.get_all_instances()

for i in range(nr_instances):
    create_instance(connection)

# print connection.get_all_network_interfaces()
# print "bla"
# print connection.get_all_addresses()
# print "bla2"
# print connection.get_all_placement_groups()
# print "haha"
# print connection.get_all_instance_status()
# print "waaa"
instances = connection.get_only_instances()
#
f = open('hosts', 'w+')
for i in instances:
    if i.ip_address:
        f.writelines("root@%s\n"%i.ip_address)


