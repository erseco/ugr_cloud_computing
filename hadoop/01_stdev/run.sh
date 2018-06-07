#!/bin/bash

hdfs dfs -rm -r  /user/CC_74003802/output

rm DevSTD.jar
rm -rf java_classes

mkdir java_classes

/usr/bin/javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop-0.20-mapreduce/* -d java_classes DevSTD*

/usr/java/jdk1.7.0_51/bin/jar -cvf DevSTD.jar -C java_classes/ .

hadoop jar DevSTD.jar oldapi.DevSTD /user/manuparra/ECBDL14_10tra.data /user/CC_74003802/output

hdfs dfs -cat /user/CC_74003802/output/*