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
global enum Operator {

    //===============================
    // FIELD OPERATORS
    //===============================
    EQUALS,                   // =
    NOT_EQUALS,               // !=
    LESS_THAN,                // <
    LESS_THAN_OR_EQUAL_TO,    // <=
    GREATER_THAN,             // >
    GREATER_THAN_OR_EQUAL_TO, // >=
    LIKEX,                    // like
    
    //===============================
    // SET OPERATORS
    //===============================
    INCLUDES,                 // includes
    EXCLUDES,                 // excludes
    INX,                      // in
    NOT_IN                    // not in 

}