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
global class SetUtils {

    global static Set<Blob> objectToBlob(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Blob> blobSet = new Set<Blob>();
        for(Object anObject : objectSet){
            if(anObject instanceof Blob){
                blobSet.add((Blob)anObject);
            }
        }
        return blobSet;
    }

    global static Set<Boolean> objectToBoolean(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Boolean> booleanSet = new Set<Boolean>();
        for(Object anObject : objectSet){
            if(anObject instanceof Boolean){
                booleanSet.add((Boolean)anObject);
            }
        }
        return booleanSet;
    }

    global static Set<Date> objectToDate(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Date> dateSet = new Set<Date>();
        for(Object anObject : objectSet){
            if(anObject instanceof Date){
                dateSet.add((Date)anObject);
            }
        }return dateSet;
    }

    global static Set<Datetime> objectToDatetime(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Datetime> datetimeSet = new Set<Datetime>();
        for(Object anObject : objectSet){
            if(anObject instanceof Datetime){
                datetimeSet.add((Datetime)anObject);
            }
        }
        return datetimeSet;
    }

    global static Set<Decimal> objectToDecimal(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Decimal> decimalSet = new Set<Decimal>();
        for(Object anObject : objectSet){
            if(anObject instanceof Decimal){
                decimalSet.add((Decimal)anObject);
            }
        }
        return decimalSet;
    }

    global static Set<Double> objectToDouble(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Double> doubleSet = new Set<Double>();
        for(Object anObject : objectSet){
            if(anObject instanceof Double){
                doubleSet.add((Double)anObject);
            }
        }return doubleSet;
    }

    global static Set<ID> objectToID(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<ID> idSet = new Set<ID>();
        for(Object anObject : objectSet){
            if(anObject instanceof ID){
                idSet.add((ID)anObject);
            }
        }
        return idSet;
    }

    global static Set<Integer> objectToInteger(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Integer> integerSet = new Set<Integer>();
        for(Object anObject : objectSet){
            if(anObject instanceof Integer){
                integerSet.add((Integer)anObject);
            }
        }
        return integerSet;
    }

    global static Set<Long> objectToLong(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Long> longSet = new Set<Long>();
        for(Object anObject : objectSet){
            if(anObject instanceof Long){
                longSet.add((Long)anObject);
            }
        }
        return longSet;
    }

    global static Set<Time> objectToTime(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<Time> timeSet = new Set<Time>();
        for(Object anObject : objectSet){
            if(anObject instanceof Time){
                timeSet.add((Time)anObject);
            }
        }
        return timeSet;
    }

    global static Set<String> objectToString(Set<Object> objectSet){
        if(objectSet == null){
            return null;    
        }
        Set<String> stringSet = new Set<String>();
        for(Object anObject : objectSet){
            if(anObject instanceof String){
                stringSet.add((String)anObject);
            }
        }
        return stringSet;
    }

    global static Set<Object> blobToObject(Set<Blob> blobSet){
        if(blobSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Blob aBlob : blobSet){
            objectSet.add(aBlob);
        }
        return objectSet;
    }
    
    global static Set<Object> booleanToObject(Set<Boolean> booleanSet){
        if(booleanSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Boolean aBoolean : booleanSet){
            objectSet.add(aBoolean);
        }
        return objectSet;
    }
        
    global static Set<Object> dateToObject(Set<Date> dateSet){
        if(dateSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Date aDate : dateSet){
            objectSet.add(aDate);
        }
        return objectSet;
    }
    
    global static Set<Object> datetimeToObject(Set<Datetime> datetimeSet){
        if(datetimeSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Datetime aDatetime : datetimeSet){
            objectSet.add(aDatetime);
        }
        return objectSet;
    }
    
    global static Set<Object> decimalToObject(Set<Decimal> decimalSet){
        if(decimalSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Decimal aDecimal : decimalSet){
            objectSet.add(aDecimal);
        }
        return objectSet;
    }
    
    global static Set<Object> doubleToObject(Set<Double> doubleSet){
        if(doubleSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Double aDouble : doubleSet){
            objectSet.add(aDouble);
        }
        return objectSet;
    }
    
    global static Set<Object> idToObject(Set<ID> idSet){
        if(idSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(ID aID : idSet){
            objectSet.add(aID);
        }
        return objectSet;
    }
    
    global static Set<Object> integerToObject(Set<Integer> integerSet){
        if(integerSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Integer aInteger : integerSet){
            objectSet.add(aInteger);
        }
        return objectSet;
    }
    
    global static Set<Object> longToObject(Set<Long> longSet){
        if(longSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Long aLong : longSet){
            objectSet.add(aLong);
        }
        return objectSet;
    }
    
    global static Set<Object> timeToObject(Set<Time> timeSet){
        if(timeSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(Time aTime : timeSet){
            objectSet.add(aTime);
        }
        return objectSet;
    }
    
    global static Set<Object> stringToObject(Set<String> stringSet){
        if(stringSet == null){
            return null;    
        }
        Set<Object> objectSet = new Set<Object>();
        for(String aString : stringSet){
            objectSet.add(aString);
        }
        return objectSet;
    }

    global static String toString(Set<Blob> blobSet){ return toString(blobToObject(blobSet)); }
    global static String toString(Set<Boolean> booleanSet){ return toString(booleanToObject(booleanSet)); }
    global static String toString(Set<Date> dateSet){ return toString(dateToObject(dateSet)); }
    global static String toString(Set<Datetime> datetimeSet){ return toString(datetimeToObject(datetimeSet)); }
    global static String toString(Set<Decimal> decimalSet){ return toString(decimalToObject(decimalSet)); }
    global static String toString(Set<Double> doubleSet){ return toString(doubleToObject(doubleSet)); }
    global static String toString(Set<ID> idSet){ return toString(idToObject(idSet)); }
    global static String toString(Set<Integer> integerSet){ return toString(integerToObject(integerSet)); }
    global static String toString(Set<Long> longSet){ return toString(longToObject(longSet)); }
    global static String toString(Set<Time> timeSet){ return toString(timeToObject(timeSet)); }
    global static String toString(Set<String> stringSet){ return toString(stringToObject(stringSet)); }

    global static String toString(Set<Object> objectSet){
        if(objectSet == null){
            return 'null';
        }
        if(objectSet.size() <= 0){
            return '{}';
        }
        String returnValue = '';
        Boolean isFirst = true;
        for(Object anObject : objectSet){
            if(isFirst){
                isFirst = false;    
            } else {
                returnValue += ',';
            }
            if(anObject instanceof Blob){ returnValue += '\'' + ((Blob)anObject).toString() + '\'';
            } else if(anObject instanceof Boolean){ returnValue += ((Boolean)anObject);
            } else if(anObject instanceof Date){ returnValue += '\'' + ((Date)anObject) + '\'';
            } else if(anObject instanceof Datetime){ returnValue += '\'' + ((Datetime)anObject) + '\'';
            } else if(anObject instanceof Integer){ returnValue += ((Integer)anObject);
            } else if(anObject instanceof Long){ returnValue += ((Long)anObject);
            } else if(anObject instanceof Decimal){ returnValue += ((Decimal)anObject);
            //} else if(anObject instanceof Double){ returnValue += ((Double)anObject);
            } else if(anObject instanceof String){ returnValue += '\'' + ((String)anObject) + '\'';
            //} else if(anObject instanceof ID){ returnValue += '\'' + ((ID)anObject) + '\'';
            } else if(anObject instanceof Time){ returnValue += '\'' + ((Time)anObject) + '\'';}
        }
        return '{' + returnValue + '}';
    }
    

    global static void assertEquals(Set<Blob> b1,Set<Blob> b2){ assertEquals(blobToObject(b1),blobToObject(b2)); }
    global static void assertEquals(Set<Boolean> b1,Set<Boolean> b2){ assertEquals(booleanToObject(b1),booleanToObject(b2)); }
    global static void assertEquals(Set<Date> d1,Set<Date> d2){ assertEquals(dateToObject(d1),dateToObject(d2)); }
    global static void assertEquals(Set<Datetime> d1,Set<Datetime> d2){ assertEquals(datetimeToObject(d1),datetimeToObject(d2)); }
    global static void assertEquals(Set<Decimal> d1,Set<Decimal> d2){ assertEquals(decimalToObject(d1),decimalToObject(d2)); }
    global static void assertEquals(Set<Double> d1,Set<Double> d2){ assertEquals(doubleToObject(d1),doubleToObject(d2)); }
    global static void assertEquals(Set<Integer> i1,Set<Integer> i2){ assertEquals(integerToObject(i1),integerToObject(i2)); }
    global static void assertEquals(Set<Long> l1,Set<Long> l2){ assertEquals(longToObject(l1),longToObject(l2)); }
    global static void assertEquals(Set<String> s1,Set<String> s2){ assertEquals(stringToObject(s1),stringToObject(s2)); }
    global static void assertEquals(Set<Time> t1,Set<Time> t2){ assertEquals(timeToObject(t1),timeToObject(t2)); }

    global static void assertEquals(Set<Object> expected, Set<Object> actual){
    	System.assert(
            equals(expected,actual),
    	    'Assertion failed, the following two arrays are not equal.  Expected: ' 
                + toString(expected) 
                + ', Actual: ' 
                + toString(actual));
    }

    global static Boolean equals(Set<Blob> b1,Set<Blob> b2){ return equals(blobToObject(b1),blobToObject(b2)); }
    global static Boolean equals(Set<Boolean> b1,Set<Boolean> b2){ return equals(booleanToObject(b1),booleanToObject(b2)); }
    global static Boolean equals(Set<Date> d1,Set<Date> d2){ return equals(dateToObject(d1),dateToObject(d2)); }
    global static Boolean equals(Set<Datetime> d1,Set<Datetime> d2){ return equals(datetimeToObject(d1),datetimeToObject(d2)); }
    global static Boolean equals(Set<Decimal> d1,Set<Decimal> d2){ return equals(decimalToObject(d1),decimalToObject(d2)); }
    global static Boolean equals(Set<Double> d1,Set<Double> d2){ return equals(doubleToObject(d1),doubleToObject(d2)); }
    global static Boolean equals(Set<Integer> i1,Set<Integer> i2){ return equals(integerToObject(i1),integerToObject(i2)); }
    global static Boolean equals(Set<Long> l1,Set<Long> l2){ return equals(longToObject(l1),longToObject(l2)); }
    global static Boolean equals(Set<String> s1,Set<String> s2){ return equals(stringToObject(s1),stringToObject(s2)); }
    global static Boolean equals(Set<Time> t1,Set<Time> t2){ return equals(timeToObject(t1),timeToObject(t2)); }
	
    global static Boolean equals(Set<Object> expected, Set<Object> actual){
        if(expected == null && actual == null){
            return true;
        }
        if((expected == null && actual != null) || (expected != null && actual == null)){
            return false;
        }
        if(expected.size() != actual.size()){
        	return false;
        }
        for(Object obj : expected){
            if(!actual.contains(obj)){
                return false;
            }
        }
        return true;
    }

    global static Set<Object> pluck(List<SObject> records, String fieldName){
        return pluck(listToSet(records),fieldName);
    }   
     
    global static Set<Object> pluck(Set<SObject> records, String fieldName){
    	Set<Object> returnValue = null;
    	if(records != null){
    		returnValue = new Set<Object>();
    		if(records.size() > 0 && StringUtils.isNotBlank(fieldName)){
	            for(SObject record : records){
	                returnValue.add(record.get(fieldName));
	            }
    		}
    	}
        return returnValue;
    }
    
    global static Set<String> pluckString(List<SObject> records, String fieldName){
        return pluckString(listToSet(records),fieldName);
    }

    global static Set<String> pluckString(Set<SObject> records, String fieldName){
        return objectToString(pluck(records,fieldName));
    }

    global static List<String> setToList(Set<String> aSet){
        List<String> returnValue = null;
        if(aSet != null){
            returnValue = new List<String>();
            if(aSet.size() > 0){
                for(String value : aSet){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }

    global static List<Object> setToList(Set<Object> records){
        List<Object> returnValue = null;
        if(records != null){
            returnValue = new List<Object>();
            if(records.size() > 0){
                for(Object record : records){
                    returnValue.add(record);
                }
            }
        }
        return returnValue;
    }

    global static List<SObject> setToList(Set<SObject> records){
        List<SObject> returnValue = null;
        if(records != null){
            returnValue = new List<SObject>();
            if(records.size() > 0){
                for(SObject record : records){
                    returnValue.add(record);
                }
            }
        }
        return returnValue;
    }

    global static Set<String> listToSet(List<String> aList){
        Set<String> returnValue = null;
        if(aList != null){
            returnValue = new Set<String>();
            if(aList.size() > 0){
                for(String value : aList){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }

    global static Set<Object> listToSet(List<Object> aList){
        Set<Object> returnValue = null;
        if(aList != null){
            returnValue = new Set<Object>();
            if(aList.size() > 0){
                for(Object value : aList){
                    returnValue.add(value);
                }
            }
        }
        return returnValue;
    }

    global static Set<SObject> listToSet(List<SObject> records){
        Set<SObject> returnValue = null;
        if(records != null){
            returnValue = new Set<SObject>();
            if(records.size() > 0){
                for(SObject record : records){
                    returnValue.add(record);
                }
            }
        }
        return returnValue;
    }
    
    global static Set<String> lowerCase(Set<String> strs){
        Set<String> returnValue = null;
        if(strs != null){
            returnValue = new Set<String>();
            if(strs.size() > 0){
                for(String str : strs){
                    returnValue.add(str == null ? null : str.toLowerCase());
                }
            }
        }
        return returnValue;
    }
    
    global static Set<String> upperCase(Set<String> strs){
        Set<String> returnValue = null;
        if(strs != null){
            returnValue = new Set<String>();
            if(strs.size() > 0){
                for(String str : strs){
                    returnValue.add(str == null ? null : str.toUpperCase());
                }
            }
        }
        return returnValue;
    }
    
    global static Set<String> trim(Set<String> strs){
        Set<String> returnValue = null;
        if(strs != null){
            returnValue = new Set<String>();
            if(strs.size() > 0){
                for(String str : strs){
                    returnValue.add(str == null ? null : str.trim());
                }
            }
        }
        return returnValue;
    }
    
    

}