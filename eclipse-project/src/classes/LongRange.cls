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
public class LongRange {

	private Long min;
	private Long max;
	
	public LongRange(Long number1){
		min = max = number1;
	} 
	public LongRange(Long number1, Long number2){
		if(number1 < number2){
			min = number1;
			max = number2;	
		} else {
			min = number2;
			max = number1;	
		}
	}
	
	public Long max(){ return max; }
	public Long min(){ return min;}
	public String toAString(){ return '[' + min + ',' + max + ']'; }
	public Boolean contains(Long value){ return min <= value && value <= max; }
	public Boolean contains(LongRange value){ return min <= value.min() && value.max() <= max; }
	public Boolean overlaps(LongRange value){ return min <= value.max() && value.min() <= max; }

}