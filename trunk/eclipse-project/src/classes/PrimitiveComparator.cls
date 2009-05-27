global class PrimitiveComparator implements ObjectComparator{
	
	global Integer compare(Object object1, Object object2){
		if(object1==null){
			System.debug('###### null');
			return -1;
		} else if(object2==null){
			System.debug('###### null');
			return 1;
		} else if(object1 instanceof Boolean && object2 instanceof Boolean){ 
			System.debug('###### Boolean');
			return compare((Boolean)object1, (Boolean)object2); 
		} else if(object1 instanceof Date && object2 instanceof Date){ 
			System.debug('###### Date');
			return compare((Date)object1, (Date)object2); 
		} else if(object1 instanceof Datetime && object2 instanceof Datetime){ 
			System.debug('###### Datetime');
			return compare((Datetime)object1, (Datetime)object2); 
		} else if(object1 instanceof Integer && object2 instanceof Integer){ 
			System.debug('###### Integer');
			return compare((Integer)object1, (Integer)object2); 
		} else if(object1 instanceof Long && object2 instanceof Long){ 
			System.debug('###### Long');
			return compare((Long)object1, (Long)object2); 
//		} else if(object1 instanceof Decimal && object2 instanceof Decimal){ 
//			System.debug('###### Decimal');
//			return compare((Decimal)object1, (Decimal)object2); 
		} else if(object1 instanceof Double && object2 instanceof Double){ 
			System.debug('###### Double');
			return compare((Double)object1, (Double)object2); 
		} else if(object1 instanceof Time && object2 instanceof Time){ 
			System.debug('###### Time');
			return compare((Time)object1, (Time)object2); 
		} else if(object1 instanceof String && object2 instanceof String){ 
			System.debug('###### String');
			return compare((String)object1, (String)object2); 
		} else {
			System.debug('###### unsupport');
			throw new IllegalArgumentException(
				'Both arguments must be type Boolean, Date, Datetime, Decimal, Double, ID, Integer, Long, Time, or String');
		}
		
	}
	
	private Integer compare(Boolean b1, Boolean b2){ 
		if(!b1 && b2){ 
			return -1; 
		} else if(b1 == b2){ 
			return 0; 
		} else {
			return 1;
		}
	}
	
	private Integer compare(Date d1, Date d2){ if(d1 < d2){ return -1; } else if(d1 == d2){ return 0; } else { return 1; } }
	private Integer compare(Datetime d1, Datetime d2){ if(d1 < d2){ return -1; } else if(d1 == d2){ return 0; } else { return 1; } }
//	private Integer compare(Decimal d1, Decimal d2){ if(d1 < d2){ return -1; } else if(d1 == d2){ return 0; } else { return 1; } }
	private Integer compare(Double d1, Double d2){ if(d1 < d2){ return -1; } else if(d1 == d2){ return 0; } else { return 1; } }
//	private Integer compare(ID i1, ID i2){ if(i1 < i2){ return -1; } else if(i1 == i2){ return 0; } else { return 1; } }
	private Integer compare(Integer i1, Integer i2){ if(i1 < i2){ return -1; } else if(i1 == i2){ return 0; } else { return 1; } }
	private Integer compare(Long l1, Long l2){ if(l1 < l2){ return -1; } else if(l1 == l2){ return 0; } else { return 1; } }
	private Integer compare(Time t1, Time t2){ return compare(''+t1,''+t2); }
	private Integer compare(String s1, String s2){ if(s1 < s2){ return -1; } else if(s1 == s2){ return 0; } else { return 1; } }

}