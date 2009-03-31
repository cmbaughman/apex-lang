/* ============================================================
 * This code is part of the "apex-lang" open source project avaiable at:
 * 
 *      http://code.google.com/p/apex-lang/
 *
 * This code is licensed under the Apache License, Version 2.0.  You may obtain a 
 * copy of the License at:
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * ============================================================
 */
public class DoubleRange {

	private Double min;
	private Double max;
	
	public DoubleRange(Double number1){
		min = max = number1;
	} 
	public DoubleRange(Double number1, Double number2){
		if(number1 < number2){
			min = number1;
			max = number2;	
		} else {
			min = number2;
			max = number1;	
		}
	}
	
	public Double max(){ return max; }
	public Double min(){ return min;}
	public String toAString(){ return '[' + min + ',' + max + ']'; }
	public Boolean contains(Double value){ return min <= value && value <= max; }
	public Boolean contains(DoubleRange value){ return min <= value.min() && value.max() <= max; }
	public Boolean overlaps(DoubleRange value){ return min <= value.max() && value.min() <= max; }

}