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