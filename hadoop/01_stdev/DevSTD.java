/*
 * Cloud Computing
 * Master in Computer Engineering
 *
 * 2018 © Copyleft - All Wrongs Reserved
 *
 * Ernesto Serrano <erseco@correo.ugr.es>
 *
 */
package oldapi;

import java.io.IOException;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;
import org.apache.hadoop.mapred.FileOutputFormat;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;

public class DevSTD
{
	public static void main(String[] args) throws IOException
	{
		if (args.length != 2)
		{
			System.err.println("Usage: DevSTD <input path> <output path>");
			System.exit(-1);
		}
		JobConf conf = new JobConf(DevSTD.class);
		conf.setJobName("DevSTD");
		FileInputFormat.addInputPath(conf, new Path(args[0]));
		FileOutputFormat.setOutputPath(conf, new Path(args[1]));
		conf.setMapperClass(DevSTDMapper.class);
		conf.setReducerClass(DevSTDReducer.class);
		conf.setOutputKeyClass(Text.class);
		conf.setOutputValueClass(DoubleWritable.class);
		JobClient.runJob(conf);
	}
}

