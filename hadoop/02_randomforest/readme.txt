hadoop jar $MAHOUT_HOME/core/target/mahout-core-<VERSION>-job.jar org.apache.mahout.classifier.df.tools.Describe -p testdata/KDDTrain+.arff -f testdata/KDDTrain+.info -d N 3 C 2 N C 4 N C 8 N 2 C 19 N L


$HADOOP_HOME/bin/hadoop jar $MAHOUT_HOME/examples/target/mahout-examples-<version>-job.jar org.apache.mahout.classifier.df.mapreduce.BuildForest -Dmapred.max.split.size=1874231 -d testdata/KDDTrain+.arff -ds testdata/KDDTrain+.info -sl 5 -p -t 100 -o nsl-forest



$HADOOP_HOME/bin/hadoop jar $MAHOUT_HOME/examples/target/mahout-examples-<version>-job.jar org.apache.mahout.classifier.df.mapreduce.TestForest -i nsl-kdd/KDDTest+.arff -ds nsl-kdd/KDDTrain+.info -m nsl-forest -a -mr -o predictions

/user/manuparra/ECBDL14_10tra.data
/user/manuparra/ECBDL14_10tst.data


hadoop fs -cat /user/manuparra/ECBDL14_10tra.data | head

10N L
0.182,0.041,-1,-3,-5,-5,-3,-3,2,-1,0

hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.tools.Describe -p /user/manuparra/ECBDL14_10tra.data -f /user/CC_74003802/descriptor.info -d 10 N L

hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.mapreduce.BuildForest -Dmapreduce.input.fileinputformat.split.minsize=11886574 -Dmapreduce.input.fileinputformat.split.maxsize=11886574 -o /user/CC_74003802/output -d /user/manuparra/ECBDL14_10tra.data -ds /user/CC_74003802/descriptor.info -sl 6 -p -t 100

hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.mapreduce.TestForest -i /user/manuparra/ECBDL14_10tst.data -ds /user/CC_74003802/descriptor.info -m /user/CC_74003802/output/forest.seq -a -mr -o /user/CC_74003802/predictions

