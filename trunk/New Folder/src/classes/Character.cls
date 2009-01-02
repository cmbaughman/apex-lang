global class Character {

	global static final Integer CONTROL 			= 0;
	global static final Integer UPPERCASE_LETTER  	= 1;
	global static final Integer LOWERCASE_LETTER  	= 2;
	global static final Integer MATH_SYMBOL  		= 3;
	global static final Integer OTHER 				= 4;
	
	private static final List<TypeAndCorrespondingCharacters> TYPES = new List<TypeAndCorrespondingCharacters>();
	
	static{
		TYPES.add(new TypeAndCorrespondingCharacters(CONTROL,'\n'));
		TYPES.add(new TypeAndCorrespondingCharacters(UPPERCASE_LETTER,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
		TYPES.add(new TypeAndCorrespondingCharacters(LOWERCASE_LETTER,'abcdefghijklmnopqrstuvwxyz'));
		TYPES.add(new TypeAndCorrespondingCharacters(MATH_SYMBOL,'+=-/^&*'));
	}
	
	private class TypeAndCorrespondingCharacters{
		private Integer typeId;
		private String characters;
		public TypeAndCorrespondingCharacters(Integer typeId,String characters){
			this.typeId = typeId;	
			this.characters = characters;	
		}
		public Integer getTypeId(){return this.typeId;}
		public Boolean matches(String character){
			validateChar(character);
			return StringUtils.contains(characters,character);
		}
	}
	
	global static Integer getType(String character){
		validateChar(character);
		for(TypeAndCorrespondingCharacters aType : TYPES){
			if(aType.matches(character)){
				return aType.getTypeId();
			}
		}
		return OTHER;
	}
	
	global static Boolean isUpperCase(String character){
		validateChar(character);
		return getType(character) == UPPERCASE_LETTER;
	}
	
	
	global static Boolean isLowerCase(String character){
		validateChar(character);
		return getType(character) == LOWERCASE_LETTER;
	}
	
	
	global static void validateChar(String character){
		if(character == null || character.length() != 1){
			throw new InvalidCharacterStringException('Invalid charcter string: ' + character);
		}
	}
}