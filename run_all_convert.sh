#!/bin/bash

repo_path='/Users/mike.xiao/Documents/GitHub/'

for activity in $(cat "$repo_path/KSADS_ML_Applet/activity_names.txt"); do

  cd "$repo_path/KSADS-$activity"
  node convert.js data_dic.csv
  
done

