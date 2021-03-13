# Práctica 2: Procesamiento de datos con Hadoop y Spark

> Ernesto Serrano Collado

## Objetivos

- Implementar programas que usen técnicas de procesamiento de datos masivos con Hadoop
- Conocer la biblioteca de algoritmos de Machine Learning de Hadoop- Mahout y aplicar las técnicas a un conjuntos de datos.
- Conocer y trabajar con Spark y Python
- Implementar código para el procesamiento de datos masivos en Spark con Python


## Parte A

Se adjuntan los siguientes ficheros:

- `DevSTDMapper.java`: que contiene la fase Map
- `DevSTDReducer.java`: que contiene la fase Reducer
- `DevSTD.java`: contiene el main para ejecutar la aplicación.


## Parte B

Lo primero de todo vamos a hacer un análisis del fichero que nos han proporcionado

Vemos el tamaño del fichero que es de 1,1 gigabytes
```
[user@hadoop-master 01_stdev]$ hdfs dfs -ls -h /user/manuparra/ECBDL14_10tra.data
-rw-r--r--   2 supergroup supergroup      1.1 G 2018-05-18 18:48 /user/manuparra/ECBDL14_10tra.data
```

Vamos a analizar tanto la cabecera como el pie para haernos una idea de que valores vamos a encontrarnos

```
[user@hadoop-master 01_stdev]$ hdfs dfs -cat /user/manuparra/ECBDL14_10tra.data | head
0.182,0.041,-1,-3,-5,-5,-3,-3,2,-1,0
0.154,0.062,0,2,3,5,-4,-5,0,-2,0
0.260,0.024,-3,1,-3,-6,6,-6,-5,-6,0
0.229,0.035,-2,-3,-2,0,-2,2,-8,-2,0
0.191,0.064,-2,-1,0,1,-1,-5,6,1,0
0.112,0.088,-6,5,1,-4,-5,-3,-7,-4,0
0.205,0.062,-6,-2,-6,-4,-4,-5,2,1,0
0.111,0.057,-4,-5,-5,-5,-7,-6,-9,-7,0
0.399,0.023,-4,-2,-2,-2,-5,3,-4,1,0
0.094,0.052,-5,-3,3,-5,-4,-5,-6,-7,0
cat: Unable to write to output stream.

[user@hadoop-master 01_stdev]$ hdfs dfs -cat /user/manuparra/ECBDL14_10tra.data | tail
0.217,0.045,-5,0,-4,0,-4,9,-7,3,0
0.221,0.076,-2,-2,1,-2,1,-4,-3,1,0
0.152,0.055,-4,-8,-3,0,-6,-2,1,-4,0
0.247,0.045,-2,2,-1,1,-3,-1,-1,0,0
0.227,0.077,-4,-1,-4,-4,-1,0,-2,0,0
0.289,0.100,-1,0,-1,-2,-6,-8,1,-8,0
0.198,0.043,-2,-3,-6,-1,-4,1,-4,-2,0
0.191,0.106,2,-2,-3,-3,2,-5,3,-5,0
0.395,0.065,-4,1,2,-1,-1,-4,3,-1,0
0.225,0.070,-1,-3,-3,0,-3,-5,4,4,0
```

Procedemos a la compilación del programa:
```
mkdir java_classes
/usr/bin/javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop-0.20-mapreduce/* -d java_classes DevSTD*
/usr/java/jdk1.7.0_51/bin/jar -cvf DevSTD.jar -C java_classes/ .
```

Y procedemos a la ejecución del programa:
```
[CC_jjnn003802@hadoop-master 01_stdev]$ hadoop jar DevSTD.jar oldapi.DevSTD /user/manuparra/ECBDL14_10tra.data /user/output
18/06/02 11:36:50 INFO client.RMProxy: Connecting to ResourceManager at hadoop-master/192.168.10.1:8032
18/06/02 11:36:50 INFO client.RMProxy: Connecting to ResourceManager at hadoop-master/192.168.10.1:8032
18/06/02 11:36:50 WARN mapreduce.JobResourceUploader: Hadoop command-line option parsing not performed. Implement the Tool interface and execute your application with ToolRunner to remedy this.
18/06/02 11:36:50 INFO mapred.FileInputFormat: Total input paths to process : 1
18/06/02 11:36:50 INFO mapreduce.JobSubmitter: number of splits:9
18/06/02 11:36:51 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1527921105787_0015
18/06/02 11:36:51 INFO impl.YarnClientImpl: Submitted application application_1527921105787_0015
18/06/02 11:36:51 INFO mapreduce.Job: The url to track the job: http://hadoop.ugr.es:8088/proxy/application_1527921105787_0015/
18/06/02 11:36:51 INFO mapreduce.Job: Running job: job_1527921105787_0015
18/06/02 11:36:55 INFO mapreduce.Job: Job job_1527921105787_0015 running in uber mode : false
18/06/02 11:36:55 INFO mapreduce.Job:  map 0% reduce 0%
18/06/02 11:37:05 INFO mapreduce.Job:  map 12% reduce 0%
[...]
18/06/02 11:39:36 INFO mapreduce.Job:  map 100% reduce 98%
18/06/02 11:39:38 INFO mapreduce.Job:  map 100% reduce 100%
18/06/02 11:39:39 INFO mapreduce.Job: Job job_1527921105787_0015 completed successfully
18/06/02 11:39:40 INFO mapreduce.Job: Counters: 52
    File System Counters
        FILE: Number of bytes read=806971007
        FILE: Number of bytes written=1166503784
        FILE: Number of read operations=0
        FILE: Number of large read operations=0
        FILE: Number of write operations=0
        HDFS: Number of bytes read=1133951952
        HDFS: Number of bytes written=210
        HDFS: Number of read operations=75
        HDFS: Number of large read operations=0
        HDFS: Number of write operations=32
    Job Counters
        Killed map tasks=1
        Killed reduce tasks=2
        Launched map tasks=10
        Launched reduce tasks=18
        Data-local map tasks=6
        Rack-local map tasks=4
        Total time spent by all maps in occupied slots (ms)=3002736
        Total time spent by all reduces in occupied slots (ms)=6337464
        Total time spent by all map tasks (ms)=750684
        Total time spent by all reduce tasks (ms)=1584366
        Total vcore-seconds taken by all map tasks=750684
        Total vcore-seconds taken by all reduce tasks=1584366
        Total megabyte-seconds taken by all map tasks=3074801664
        Total megabyte-seconds taken by all reduce tasks=6489563136
    Map-Reduce Framework
        Map input records=31992921
        Map output records=319929210
        Map output bytes=3199292100
        Map output materialized bytes=361146416
        Input split bytes=954
        Combine input records=0
        Combine output records=0
        Reduce input groups=10
        Reduce shuffle bytes=361146416
        Reduce input records=319929210
        Reduce output records=10
        Spilled Records=1030438764
        Shuffled Maps =144
        Failed Shuffles=0
        Merged Map outputs=144
        GC time elapsed (ms)=67746
        CPU time spent (ms)=1797920
        Physical memory (bytes) snapshot=35938844672
        Virtual memory (bytes) snapshot=96287916032
        Total committed heap usage (bytes)=40757100544
    Shuffle Errors
        BAD_ID=0
        CONNECTION=0
        IO_ERROR=0
        WRONG_LENGTH=0
        WRONG_MAP=0
        WRONG_REDUCE=0
    File Input Format Counters
        Bytes Read=1133950998
    File Output Format Counters
        Bytes Written=210
```

Por último mostramos la salida del programa tal y como indica la práctica para mostrar el valor de la desviación estándar de las 9 primeras columnas

```
[user@hadoop-master 01_stdev]$ hdfs dfs -cat  /user/output/*
1   0.022106364868689547
2   3.120921804806522
3   2.8697504207311573
4   3.1076611686441145
5   2.5967858721354946
6   3.2549339168854696
7   2.911585419493007
8   3.007996506602418
9   3.3427230707042788
0   0.09919735080286314
```


## Parte C

Analizamos el dataset ECBDL14_10tra.data para saber que columnas hay:

```
hadoop fs -cat /user/manuparra/ECBDL14_10tra.data | head
0.182,0.041,-1,-3,-5,-5,-3,-3,2,-1,0
```

Creamos el descriptor de fichero usando 10 N L (10 numéricos y un Label):
```
hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.tools.Describe -p /user/manuparra/ECBDL14_10tra.data -f /user/descriptor.info -d 10 N L
18/06/02 12:00:46 INFO tools.Describe: Generating the descriptor...
18/06/02 12:00:47 INFO tools.Describe: generating the dataset...
18/06/02 12:01:53 INFO tools.Describe: storing the dataset description
```

Ejecutamos el random forest:

```
hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.mapreduce.BuildForest -Dmapreduce.input.fileinputformat.split.minsize=11886574 -Dmapreduce.input.fileinputformat.split.maxsize=11886574 -o /user/output -d /user/manuparra/ECBDL14_10tra.data -ds /user/descriptor.info -sl 6 -p -t 100
18/06/02 12:03:00 INFO mapreduce.BuildForest: Partial Mapred implementation
18/06/02 12:03:00 INFO mapreduce.BuildForest: Building the forest...
18/06/02 12:03:00 INFO client.RMProxy: Connecting to ResourceManager at hadoop-master/192.168.10.1:8032
18/06/02 12:03:01 INFO input.FileInputFormat: Total input paths to process : 1
18/06/02 12:03:01 INFO mapreduce.JobSubmitter: number of splits:96
18/06/02 12:03:01 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1527921105787_0016
18/06/02 12:03:01 INFO impl.YarnClientImpl: Submitted application application_1527921105787_0016
18/06/02 12:03:01 INFO mapreduce.Job: The url to track the job: http://hadoop.ugr.es:8088/proxy/application_1527921105787_0016/
18/06/02 12:03:01 INFO mapreduce.Job: Running job: job_1527921105787_0016
18/06/02 12:03:08 INFO mapreduce.Job: Job job_1527921105787_0016 running in uber mode : false
18/06/02 12:03:08 INFO mapreduce.Job:  map 0% reduce 0%
[...]
18/06/02 12:03:27 INFO mapreduce.Job:  map 100% reduce 0%
18/06/02 12:03:47 INFO mapreduce.Job: Job job_1527921105787_0016 completed successfully
18/06/02 12:03:47 INFO mapreduce.Job: Counters: 31
    File System Counters
        FILE: Number of bytes read=52416
        FILE: Number of bytes written=11839574
        FILE: Number of read operations=0
        FILE: Number of large read operations=0
        FILE: Number of write operations=0
        HDFS: Number of bytes read=1134263126
        HDFS: Number of bytes written=20276456
        HDFS: Number of read operations=480
        HDFS: Number of large read operations=0
        HDFS: Number of write operations=192
    Job Counters
        Launched map tasks=96
        Data-local map tasks=60
        Rack-local map tasks=36
        Total time spent by all maps in occupied slots (ms)=5567672
        Total time spent by all reduces in occupied slots (ms)=0
        Total time spent by all map tasks (ms)=1391918
        Total vcore-seconds taken by all map tasks=1391918
        Total megabyte-seconds taken by all map tasks=5701296128
    Map-Reduce Framework
        Map input records=31992921
        Map output records=100
        Input split bytes=11424
        Spilled Records=0
        Failed Shuffles=0
        Merged Map outputs=0
        GC time elapsed (ms)=20997
        CPU time spent (ms)=1271750
        Physical memory (bytes) snapshot=79475834880
        Virtual memory (bytes) snapshot=369085829120
        Total committed heap usage (bytes)=161392099328
    File Input Format Counters
        Bytes Read=1134251702
    File Output Format Counters
        Bytes Written=20276456
18/06/02 12:03:48 INFO common.HadoopUtil: Deleting hdfs://hadoop-master/user/output
18/06/02 12:03:48 INFO mapreduce.BuildForest: Build Time: 0h 0m 48s 486
18/06/02 12:03:48 INFO mapreduce.BuildForest: Forest num Nodes: 1447252
18/06/02 12:03:48 INFO mapreduce.BuildForest: Forest mean num Nodes: 14472
18/06/02 12:03:48 INFO mapreduce.BuildForest: Forest mean max Depth: 42
18/06/02 12:03:48 INFO mapreduce.BuildForest: Storing the forest in: /user/output/forest.seq
```

Obtenemos las predicciones:
```
hadoop jar ~/mahout-distribution-0.9.jar org.apache.mahout.classifier.df.mapreduce.TestForest -i /user/manuparra/ECBDL14_10tst.data -ds /user/descriptor.info -m /user/output/forest.seq -a -mr -o /user/predictions
18/06/02 12:06:56 INFO mapreduce.Classifier: Adding the dataset to the DistributedCache
18/06/02 12:06:56 INFO mapreduce.Classifier: Adding the decision forest to the DistributedCache
18/06/02 12:06:56 INFO mapreduce.Classifier: Configuring the job...
18/06/02 12:06:56 INFO mapreduce.Classifier: Running the job...
18/06/02 12:06:56 INFO client.RMProxy: Connecting to ResourceManager at hadoop-master/192.168.10.1:8032
18/06/02 12:06:57 INFO input.FileInputFormat: Total input paths to process : 1
18/06/02 12:06:57 INFO mapreduce.JobSubmitter: number of splits:1
18/06/02 12:06:57 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1527921105787_0017
18/06/02 12:06:57 INFO impl.YarnClientImpl: Submitted application application_1527921105787_0017
18/06/02 12:06:58 INFO mapreduce.Job: The url to track the job: http://hadoop.ugr.es:8088/proxy/application_1527921105787_0017/
18/06/02 12:06:58 INFO mapreduce.Job: Running job: job_1527921105787_0017
18/06/02 12:07:03 INFO mapreduce.Job: Job job_1527921105787_0017 running in uber mode : false
18/06/02 12:07:03 INFO mapreduce.Job:  map 0% reduce 0%
[...]
18/06/02 12:08:03 INFO mapreduce.Job:  map 100% reduce 0%
18/06/02 12:08:03 INFO mapreduce.Job: Job job_1527921105787_0017 completed successfully
18/06/02 12:08:03 INFO mapreduce.Job: Counters: 30
    File System Counters
        FILE: Number of bytes read=20261878
        FILE: Number of bytes written=122727
        FILE: Number of read operations=0
        FILE: Number of large read operations=0
        FILE: Number of write operations=0
        HDFS: Number of bytes read=102747263
        HDFS: Number of bytes written=58538043
        HDFS: Number of read operations=5
        HDFS: Number of large read operations=0
        HDFS: Number of write operations=2
    Job Counters
        Launched map tasks=1
        Rack-local map tasks=1
        Total time spent by all maps in occupied slots (ms)=229560
        Total time spent by all reduces in occupied slots (ms)=0
        Total time spent by all map tasks (ms)=57390
        Total vcore-seconds taken by all map tasks=57390
        Total megabyte-seconds taken by all map tasks=235069440
    Map-Reduce Framework
        Map input records=2897917
        Map output records=2897918
        Input split bytes=119
        Spilled Records=0
        Failed Shuffles=0
        Merged Map outputs=0
        GC time elapsed (ms)=180
        CPU time spent (ms)=57860
        Physical memory (bytes) snapshot=294076416
        Virtual memory (bytes) snapshot=3837587456
        Total committed heap usage (bytes)=831520768
    File Input Format Counters
        Bytes Read=102747144
    File Output Format Counters
        Bytes Written=58538043
18/06/02 12:08:08 INFO common.HadoopUtil: Deleting /user/predictions/mappers
18/06/02 12:08:09 INFO mapreduce.TestForest:
=======================================================
Summary
-------------------------------------------------------
Correctly Classified Instances          :    2849280       98.3217%
Incorrectly Classified Instances        :      48637        1.6783%
Total Classified Instances              :    2897917

=======================================================
Confusion Matrix
-------------------------------------------------------
a       b       <--Classified as
2849280 0        |  2849280 a     = 0
48637   0        |  48637   b     = 1

=======================================================
Statistics
-------------------------------------------------------
Kappa                                           -0
Accuracy                                   98.3217%
Reliability                                33.3333%
Reliability (standard deviation)            0.5774
```

Donde podemos ver la matriz de confusión solicitada por el ejercicio:
```
=======================================================
Confusion Matrix
-------------------------------------------------------
a       b       <--Classified as
2849280 0        |  2849280 a     = 0
48637   0        |  48637   b     = 1
```

## Parte F

Se adjunta el archivo `ernesto.py` que contiene el código Python de la práctica

Podemos ver el porcentaje de error que es muy bajo:
```
Test Error = 0.01656
```
Y tambien podemos ver los valores de la tabla
```
+-------+-------------------+
|summary|              label|
+-------+-------------------+
|  count|             100000|
|   mean|            0.01656|
| stddev|0.12761633617720297|
|    min|                0.0|
|    max|                1.0|
+-------+-------------------+
```
