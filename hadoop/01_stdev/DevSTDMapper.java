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
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;

public class DevSTDMapper extends MapReduceBase implements Mapper<LongWritable, Text, Text, DoubleWritable>
{
    public static int col=5;
	public void map(LongWritable key, Text value, OutputCollector<Text, DoubleWritable> output, Reporter reporter) throws IOException
    {
        String line = value.toString();
        String[] parts = line.split(",");
        int cols = parts.length - 1;
        for (int col = 0; col < cols; col++) {
            output.collect(new Text(Integer.toString(col)), new DoubleWritable(Double.parseDouble(parts[col])));
        }
    }
}
