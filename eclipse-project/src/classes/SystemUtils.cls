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
global class SystemUtils {

	global static void debugLimits(){
		System.debug(
			  '\n##################################################################'
			+ '\nLimits:'
			+ '\n##################################################################'
			+ '\nAggregateQueries: ' + Limits.getAggregateQueries() + ' of ' + Limits.getLimitAggregateQueries()
			+ '\nCallouts: ' + Limits.getCallouts() + ' of ' + Limits.getLimitCallouts()
			+ '\nDMLRows: ' + Limits.getDMLRows() + ' of ' + Limits.getLimitDMLRows()
			+ '\nDMLStatements: ' + Limits.getDMLStatements() + ' of ' + Limits.getLimitDMLStatements()
			+ '\nEmailInvocations: ' + Limits.getEmailInvocations() + ' of ' + Limits.getLimitEmailInvocations()
			+ '\nFieldsDescribes: ' + Limits.getFieldsDescribes() + ' of ' + Limits.getLimitFieldsDescribes()
			+ '\nFindSimilarCalls: ' + Limits.getFindSimilarCalls() + ' of ' + Limits.getLimitFindSimilarCalls()
			+ '\nFutureCalls: ' + Limits.getFutureCalls() + ' of ' + Limits.getLimitFutureCalls()
			+ '\nHeapSize: ' + Limits.getHeapSize() + ' of ' + Limits.getLimitHeapSize()
			+ '\nQueries: ' + Limits.getQueries() + ' of ' + Limits.getLimitQueries()
			+ '\nPicklistDescribes: ' + Limits.getPicklistDescribes() + ' of ' + Limits.getLimitPicklistDescribes()
			+ '\nQueryRows: ' + Limits.getQueryRows() + ' of ' + Limits.getLimitQueryRows()
			+ '\nRunAs: ' + Limits.getRunAs() + ' of ' + Limits.getLimitRunAs()
			+ '\nSavepointRollbacks: ' + Limits.getSavepointRollbacks() + ' of ' + Limits.getLimitSavepointRollbacks()
			+ '\nSavepoints: ' + Limits.getSavepoints() + ' of ' + Limits.getLimitSavepoints()
			+ '\nScriptStatements: ' + Limits.getScriptStatements() + ' of ' + Limits.getLimitScriptStatements()
			+ '\nSoslQueries: ' + Limits.getSoslQueries() + ' of ' + Limits.getLimitSoslQueries()
			);
	}
}