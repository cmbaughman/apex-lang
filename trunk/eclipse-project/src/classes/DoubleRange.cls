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