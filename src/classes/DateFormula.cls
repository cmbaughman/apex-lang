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
global class DateFormula implements Soqlable{

    private String literal = null;
    
    global String toSoql(){ return this.toSoql(SoqlOptions.DEFAULT_OPTIONS); }
    
    global String toSoql(final SoqlOptions options){
    	if(StringUtils.isBlank(literal)){
    		throw new IllegalStateException();
    	}
    	return literal;
    }

    global DateFormula yesterdayx(){ this.literal = 'YESTERDAY'; return this;}
    global DateFormula todayx(){     this.literal = 'TODAY'; return this;}
    global DateFormula tomorrowx(){  this.literal = 'TOMORROW'; return this;}
    global DateFormula thisx(UnitOfTime unit){
    	if(unit == UnitOfTime.Day){
    		return todayx();
    	} 
    	this.literal = 'THIS_' + unitToLabel(unit); 
    	return this;
    }

    global DateFormula last90Days(){ return last(90,UnitOfTime.Day); }
    global DateFormula next90Days(){ return next(90,UnitOfTime.Day); }

    global DateFormula last(UnitOfTime unit){ return last(1,unit); }
    global DateFormula next(UnitOfTime unit){ return next(1,unit); }
    
    global DateFormula last(Integer n, UnitOfTime unit){ this.literal = 'LAST_' + toUnitAndAmount(n,unit); return this;}
    global DateFormula next(Integer n, UnitOfTime unit){ this.literal = 'NEXT_' + toUnitAndAmount(n,unit); return this;}
    
    private String toUnitAndAmount(Integer n, UnitOfTime unit){
    	String unitAndAmount = '';
    	if(n < 0){
            throw new IllegalArgumentException('n cannot be negative');
    	} else if(n == 90 && unit == UnitOfTime.Day){
        	unitAndAmount += '90_' + unitToLabel(UnitOfTime.Day) + 'S'; 
        } else if(n == 1 && unit != UnitOfTime.Day){
            unitAndAmount += unitToLabel(unit);
        } else if(unit == UnitOfTime.Week || unit == UnitOfTime.Month){
        	throw new IllegalArgumentException('N_WEEKS and N_MONTHS are not supported');
        } else {
            unitAndAmount += 'N_' + unitToLabel(unit) + 'S:' + n;
        }
        return unitAndAmount;
    }
    
    private static String unitToLabel(UnitOfTime unit){
    	String label = '';
        if(     unit == UnitOfTime.Day){           label = 'DAY';            }
        else if(unit == UnitOfTime.Week){          label = 'WEEK';           }
        else if(unit == UnitOfTime.Month){         label = 'MONTH';         }
        else if(unit == UnitOfTime.Quarter){       label = 'QUARTER';        } 
        else if(unit == UnitOfTime.FiscalQuarter){ label = 'FISCAL_QUARTER'; }
        else if(unit == UnitOfTime.Year){          label = 'YEAR';           }
        else if(unit == UnitOfTime.FiscalYear){    label = 'FISCAL_YEAR';    }  
        return label;
    }
    

}