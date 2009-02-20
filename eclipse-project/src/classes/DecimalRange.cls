public class DecimalRange {

	private Decimal min;
	private Decimal max;
	
	public DecimalRange(Decimal number1){
		min = max = number1;
	} 
	public DecimalRange(Decimal number1, Decimal number2){
		if(number1 < number2){
			min = number1;
			max = number2;	
		} else {
			min = number2;
			max = number1;	
		}
	}
	
	public Decimal max(){ return max; }
	public Decimal min(){ return min;}
	public String toAString(){ return '[' + min + ',' + max + ']'; }
	public Boolean contains(Decimal value){ return min <= value && value <= max; }
	public Boolean contains(DecimalRange value){ return min <= value.min() && value.max() <= max; }
	public Boolean overlaps(DecimalRange value){ return min <= value.max() && value.min() <= max; }

}