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
 
/*
 * NOTE: created this class as a workaround to issue in Winter with casting Object to SelectOption.
 * See http://community.salesforce.com/sforce/board/message?board.id=apex&thread.id=24143
 */
global class SelectOptionWrapper{
	global SelectOption selectOption{get;set;}
	global SelectOptionWrapper(SelectOption selectOption){
		this.selectOption = selectOption;
	}
}