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

}