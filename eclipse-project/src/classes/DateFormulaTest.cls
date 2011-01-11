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
@IsTest
private class DateFormulaTest {


    private static testmethod void test_ILLEGAL_STATE(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().toSoql();
        }catch(IllegalStateException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalStateException not thrown');
    }

    private static testmethod void test_INVALID_N(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().next(-1,UnitOfTime.Year).toSoql();
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }

    private static testmethod void test_YESTERDAY(){
        System.assertEquals('YESTERDAY',new DateFormula().yesterdayx().toSoql());
    }

    private static testmethod void test_TODAY(){
        System.assertEquals('TODAY',new DateFormula().todayx().toSoql());
    }
    
    private static testmethod void test_TOMORROW(){
        System.assertEquals('TOMORROW',new DateFormula().tomorrowx().toSoql());
    }
    
    private static testmethod void test_LAST_90_DAYS(){
        System.assertEquals('LAST_90_DAYS',new DateFormula().last90Days().toSoql());
    }
    
    private static testmethod void test_NEXT_90_DAYS(){
        System.assertEquals('NEXT_90_DAYS',new DateFormula().next90Days().toSoql());
    }
    
    private static testmethod void test_NEXT_DAY(){
        System.assertEquals('NEXT_N_DAYS:1',new DateFormula().next(UnitOfTime.Day).toSoql());
        System.assertEquals('NEXT_N_DAYS:1',new DateFormula().next(1,UnitOfTime.Day).toSoql());
    }
    
    private static testmethod void test_NEXT_WEEK(){
        System.assertEquals('NEXT_WEEK',new DateFormula().next(UnitOfTime.Week).toSoql());
        System.assertEquals('NEXT_WEEK',new DateFormula().next(1,UnitOfTime.Week).toSoql());
    }
    
    private static testmethod void test_NEXT_MONTH(){
        System.assertEquals('NEXT_MONTH',new DateFormula().next(UnitOfTime.Month).toSoql());
        System.assertEquals('NEXT_MONTH',new DateFormula().next(1,UnitOfTime.Month).toSoql());
    }
    
    private static testmethod void test_NEXT_QUARTER(){
        System.assertEquals('NEXT_QUARTER',new DateFormula().next(UnitOfTime.Quarter).toSoql());
        System.assertEquals('NEXT_QUARTER',new DateFormula().next(1,UnitOfTime.Quarter).toSoql());
    }
    
    private static testmethod void test_NEXT_YEAR(){
        System.assertEquals('NEXT_YEAR',new DateFormula().next(UnitOfTime.Year).toSoql());
        System.assertEquals('NEXT_YEAR',new DateFormula().next(1,UnitOfTime.Year).toSoql());
    }
    
    private static testmethod void test_NEXT_FISCAL_QUARTER(){
        System.assertEquals('NEXT_FISCAL_QUARTER',new DateFormula().next(UnitOfTime.FiscalQuarter).toSoql());
        System.assertEquals('NEXT_FISCAL_QUARTER',new DateFormula().next(1,UnitOfTime.FiscalQuarter).toSoql());
    }
    
    private static testmethod void test_NEXT_FISCAL_YEAR(){
        System.assertEquals('NEXT_FISCAL_YEAR',new DateFormula().next(UnitOfTime.FiscalYear).toSoql());
        System.assertEquals('NEXT_FISCAL_YEAR',new DateFormula().next(1,UnitOfTime.FiscalYear).toSoql());
    }

    private static testmethod void test_LAST_DAY(){
        System.assertEquals('LAST_N_DAYS:1',new DateFormula().last(UnitOfTime.Day).toSoql());
        System.assertEquals('LAST_N_DAYS:1',new DateFormula().last(1,UnitOfTime.Day).toSoql());
    }
    
    private static testmethod void test_LAST_WEEK(){
        System.assertEquals('LAST_WEEK',new DateFormula().last(UnitOfTime.Week).toSoql());
        System.assertEquals('LAST_WEEK',new DateFormula().last(1,UnitOfTime.Week).toSoql());
    }
    
    private static testmethod void test_LAST_MONTH(){
        System.assertEquals('LAST_MONTH',new DateFormula().last(UnitOfTime.Month).toSoql());
        System.assertEquals('LAST_MONTH',new DateFormula().last(1,UnitOfTime.Month).toSoql());
    }
    
    private static testmethod void test_LAST_QUARTER(){
        System.assertEquals('LAST_QUARTER',new DateFormula().last(UnitOfTime.Quarter).toSoql());
        System.assertEquals('LAST_QUARTER',new DateFormula().last(1,UnitOfTime.Quarter).toSoql());
    }
    
    private static testmethod void test_LAST_YEAR(){
        System.assertEquals('LAST_YEAR',new DateFormula().last(UnitOfTime.Year).toSoql());
        System.assertEquals('LAST_YEAR',new DateFormula().last(1,UnitOfTime.Year).toSoql());
    }
    
    private static testmethod void test_LAST_FISCAL_QUARTER(){
        System.assertEquals('LAST_FISCAL_QUARTER',new DateFormula().last(UnitOfTime.FiscalQuarter).toSoql());
        System.assertEquals('LAST_FISCAL_QUARTER',new DateFormula().last(1,UnitOfTime.FiscalQuarter).toSoql());
    }
    
    private static testmethod void test_LAST_FISCAL_YEAR(){
        System.assertEquals('LAST_FISCAL_YEAR',new DateFormula().last(UnitOfTime.FiscalYear).toSoql());
        System.assertEquals('LAST_FISCAL_YEAR',new DateFormula().last(1,UnitOfTime.FiscalYear).toSoql());
    }

    private static testmethod void test_THIS_DAY(){
        System.assertEquals('TODAY',new DateFormula().thisx(UnitOfTime.Day).toSoql());
    }
    
    private static testmethod void test_THIS_WEEK(){
        System.assertEquals('THIS_WEEK',new DateFormula().thisx(UnitOfTime.Week).toSoql());
    }
    
    private static testmethod void test_THIS_MONTH(){
        System.assertEquals('THIS_MONTH',new DateFormula().thisx(UnitOfTime.Month).toSoql());
    }
    
    private static testmethod void test_THIS_QUARTER(){
        System.assertEquals('THIS_QUARTER',new DateFormula().thisx(UnitOfTime.Quarter).toSoql());
    }
    
    private static testmethod void test_THIS_YEAR(){
        System.assertEquals('THIS_YEAR',new DateFormula().thisx(UnitOfTime.Year).toSoql());
    }
    
    private static testmethod void test_THIS_FISCAL_QUARTER(){
        System.assertEquals('THIS_FISCAL_QUARTER',new DateFormula().thisx(UnitOfTime.FiscalQuarter).toSoql());
    }
    
    private static testmethod void test_THIS_FISCAL_YEAR(){
        System.assertEquals('THIS_FISCAL_YEAR',new DateFormula().thisx(UnitOfTime.FiscalYear).toSoql());
    }

    private static testmethod void test_NEXT_N_DAYS(){
        System.assertEquals('NEXT_N_DAYS:0',new DateFormula().next(0,UnitOfTime.Day).toSoql());
        System.assertEquals('NEXT_N_DAYS:1',new DateFormula().next(1,UnitOfTime.Day).toSoql());
        System.assertEquals('NEXT_N_DAYS:2',new DateFormula().next(2,UnitOfTime.Day).toSoql());
    }
    
    private static testmethod void test_NEXT_N_WEEKS(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().next(2,UnitOfTime.Week);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }
    
    private static testmethod void test_NEXT_N_MONTHS(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().next(2,UnitOfTime.Month);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }
    
    private static testmethod void test_NEXT_N_QUARTERS(){
        System.assertEquals('NEXT_N_QUARTERS:2',new DateFormula().next(2,UnitOfTime.Quarter).toSoql());
    }
    
    private static testmethod void test_NEXT_N_YEARS(){
        System.assertEquals('NEXT_N_YEARS:2',new DateFormula().next(2,UnitOfTime.Year).toSoql());
    }
    
    private static testmethod void test_NEXT_N_FISCAL_QUARTERS(){
        System.assertEquals('NEXT_N_FISCAL_QUARTERS:2',new DateFormula().next(2,UnitOfTime.FiscalQuarter).toSoql());
    }
    
    private static testmethod void test_NEXT_N_FISCAL_YEARS(){
        System.assertEquals('NEXT_N_FISCAL_YEARS:2',new DateFormula().next(2,UnitOfTime.FiscalYear).toSoql());
    }

    private static testmethod void test_LAST_N_DAYS(){
        System.assertEquals('LAST_N_DAYS:0',new DateFormula().last(0,UnitOfTime.Day).toSoql());
        System.assertEquals('LAST_N_DAYS:1',new DateFormula().last(1,UnitOfTime.Day).toSoql());
        System.assertEquals('LAST_N_DAYS:2',new DateFormula().last(2,UnitOfTime.Day).toSoql());
    }
    
    private static testmethod void test_LAST_N_WEEKS(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().last(2,UnitOfTime.Week);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }
    
    private static testmethod void test_LAST_N_MONTHS(){
        Boolean exceptionCaught = false;
        try{
            new DateFormula().last(2,UnitOfTime.Month);
        }catch(IllegalArgumentException e){
            exceptionCaught = true;
        }
        System.assert(exceptionCaught == true,'IllegalArgumentException not thrown');
    }
    
    private static testmethod void test_LAST_N_QUARTERS(){
        System.assertEquals('LAST_N_QUARTERS:2',new DateFormula().last(2,UnitOfTime.Quarter).toSoql());
    }
    
    private static testmethod void test_LAST_N_YEARS(){
        System.assertEquals('LAST_N_YEARS:2',new DateFormula().last(2,UnitOfTime.Year).toSoql());
    }
    
    private static testmethod void test_LAST_N_FISCAL_QUARTERS(){
        System.assertEquals('LAST_N_FISCAL_QUARTERS:2',new DateFormula().last(2,UnitOfTime.FiscalQuarter).toSoql());
    }
    
    private static testmethod void test_LAST_N_FISCAL_YEARS(){
        System.assertEquals('LAST_N_FISCAL_YEARS:2',new DateFormula().last(2,UnitOfTime.FiscalYear).toSoql());
    }

    
/*
 
 
+----------------+-----+----------------+
+ TYPE           + N   + THIS|NEXT|LAST +
+----------------+----------------------+
+ DAYS           + YES + NO             +
+ WEEK           + NO  + YES            +
+ MONTH          + NO  + YES            +
+ QUARTER        + YES + YES            +
+ YEAR           + YES + YES            +
+ FISCAL_QUARTER + YES + YES            +
+ FISCAL_YEAR    + YES + YES            +
+----------------------+----------------+

NEXT_WEEK 
NEXT_MONTH 
NEXT_QUARTER 
NEXT_YEAR 
NEXT_FISCAL_QUARTER 
NEXT_FISCAL_YEAR 

LAST_WEEK 
LAST_MONTH 
LAST_QUARTER 
LAST_YEAR 
LAST_FISCAL_QUARTER 
LAST_FISCAL_YEAR 

THIS_WEEK 
THIS_MONTH 
THIS_QUERTER 
THIS_YEAR 
THIS_FISCAL_QUARTER 
THIS_FISCAL_YEAR 

NEXT_N_DAYS ':' INTEGER 
NEXT_N_QUARTERS ':'INTEGER 
NEXT_N_YEARS ':' INTEGER 
NEXT_N_FISCAL_QUARTERS ':' INTEGER 
NEXT_N_FISCAL_YEARS ':' INTEGER 

LAST_N_DAYS ':' INTEGER 
LAST_N_QUARTERS ':' INTEGER 
LAST_N_YEARS ':' INTEGER 
LAST_N_FISCAL_QUARTERS ':' INTEGER 
LAST_N_FISCAL_YEARS ':' INTEGER
*/    
}