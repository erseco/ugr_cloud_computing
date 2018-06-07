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
import java.util.Iterator;
import java.util.*;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reducer;
import org.apache.hadoop.mapred.Reporter;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Map;

public class DevSTDReducer extends MapReduceBase implements Reducer<Text, DoubleWritable, Text, DoubleWritable>
{

	private ArrayList<Double> commentLengths = new ArrayList<Double>();

	public void reduce(Text key, Iterator<DoubleWritable> values, OutputCollector<Text, DoubleWritable> output, Reporter reporter) throws IOException
	{

		// Calculate Max (for test purposes)
		// Double maxValue = Double.MIN_VALUE;
		// while (values.hasNext()) {
		// 	maxValue = Math.max(maxValue, values.next().get());
		// }
		// output.collect(key, new DoubleWritable(maxValue));

		// Calculate Min (for test purposes)
		// Double minValue = Double.MAX_VALUE;
		// while (values.hasNext()) {
		// 	minValue = Math.min(minValue, values.next().get());
		// }
		// output.collect(key, new DoubleWritable(minValue));


		double sum = 0;
		double count = 0;
		commentLengths.clear();

		while (values.hasNext()) {
			double val = values.next().get();
			commentLengths.add(val);
			sum += val;
			++count;
		}

		// sort commentLengths to calculate median
		Collections.sort(commentLengths);

		// calculate standard deviation
		double mean = sum / count;

		double sumOfSquares = 0.0f;
		for (double f : commentLengths) {
			sumOfSquares += (f - mean) * (f - mean);
		}

		output.collect(key, new DoubleWritable(Math.sqrt(sumOfSquares / (count - 1))));

	}

}

