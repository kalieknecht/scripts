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

# for loop to filter bag  for each snip
# for i in {0..num_snips-1} check syntax
#do
#    rosbag filter data.bag parti.bag "t.secs>="
#done

# format given 5 iterations
# not sure about formatting or how to give  variable for t.secs for filter command
rosbag filter data.bag part1.bag "t.secs<=starttime+snip_length"
rosbag filter data.bag part2.bag "t.secs<=starttime+snip_length*2 and t.secs>=starttime+snip_length"
rosbag filter data.bag part3.bag "t.secs<=starttime+snip_length*3 and t.secs>=starttime+snip_length*2"
rosbag filter data.bag part4.bag "t.secs<=starttime+snip_length*4 and t.secs>=starttime+snip_length*3"
rosbag filter data.bag part5.bag "t.secs>=starttime+snip_length*4"

# add some check with end_time to figure out if on last iteration or not
# put part1 and partN outside of for loop and iterate thru middle slices