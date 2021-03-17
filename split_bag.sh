#!/bin/sh
# USAGE: ./split_bag.sh 
# in directory of desired file, called data.bag
# to do: make name of bag  file input, and edit data.bag calls below
num_snips=5 # number of files to create  

# grab bag info 
length="$(rosbag info -y -k duration data.bag| tee /dev/stderr)"# duration of bag printed in yaml format
starttime="$(rosbag info -y -k start data.bag | tee /dev/stderr)" # start time
endtime="$(rosbag info -y -k end data.bag | tee /dev/stderr)" # end time

# split bag into desired size
trunc_length=$(echo $length | cut -d "." -f 1) #truncate length for easier division
snip_length=$((trunc_length / num_snips )) # length of each snippet

