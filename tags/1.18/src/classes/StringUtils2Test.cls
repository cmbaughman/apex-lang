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
private class StringUtils2Test {

    private static testmethod void testLeft(){
        //test: global static String left(String str, Integer len) {
        assertLeft(null, -1, null);
        assertLeft(null, 0, null);
        assertLeft('xyz', -1, '');
        assertLeft('', -1, '');
        assertLeft('', 0, '');
        assertLeft('abc', 0, '');
        assertLeft('abc', 2, 'ab');
        assertLeft('abc', 4, 'abc');
    }
    
    private static void assertLeft(String str, Integer len, String expected){
        String actual = StringUtils.left(str,len);
        System.assert(actual==expected, 'StringUtils.left(\'' + str + '\',' 
            + len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRepeat(){
        //test: global static String repeat(String str, Integer repeat) 
        assertRepeat(null, 2, null);
        assertRepeat('', 0, '');
        assertRepeat('', 2, '');
        assertRepeat('a', 3, 'aaa');
        assertRepeat('ab', 2, 'abab');
        assertRepeat('a', -2, '');
    }
    
    private static void assertRepeat(String str, Integer repeat, String expected){
        String actual = StringUtils.repeat(str,repeat);
        System.assert(actual==expected, 'StringUtils.repeat(\'' + str + '\',\'' 
            + repeat + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }


    private static testmethod void testMid(){
        //test: global static String mid(String str, Integer pos, Integer len) {
        assertMid(null, 0, 0, null);
        assertMid('', 0, -1, '');
        assertMid('', 0, 0, '');
        assertMid('abc', 0, 2, 'ab');
        assertMid('abc', 0, 4, 'abc');
        assertMid('abc', 2, 4, 'c');
        assertMid('abc', 4, 2, '');
        assertMid('abc', -2, 2, 'ab');
        
    }

    private static void assertMid(String str, Integer pos, Integer len, String expected){
        String actual = StringUtils.mid(str,pos,len);
        System.assert(actual==expected, 'StringUtils.mid(\'' + str + '\',' + pos 
            + ',' + len + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testOverlay(){
        //test: global static String overlay(String str, String overlay, Integer startIndex, Integer endIndex) {
        assertOverlay(null, null, 0, 0, null);
        assertOverlay('', 'abc', 0, 0, 'abc');
        assertOverlay('abcdef', null, 2, 4, 'abef');
        assertOverlay('abcdef', '', 2, 4, 'abef');
        assertOverlay('abcdef', '', 4, 2, 'abef');
        assertOverlay('abcdef', 'zzzz', 2, 4, 'abzzzzef');
        assertOverlay('abcdef', 'zzzz', 4, 2, 'abzzzzef');
        assertOverlay('abcdef', 'zzzz', -1, 4, 'zzzzef');
        assertOverlay('abcdef', 'zzzz', 2, 8, 'abzzzz');
        assertOverlay('abcdef', 'zzzz', -2, -3, 'zzzzabcdef');
        assertOverlay('abcdef', 'zzzz', 8, 10, 'abcdefzzzz');
        
    }

    private static void assertOverlay(String str, String overlay, Integer startIndex, Integer endIndex, String expected){
        String actual = StringUtils.overlay(str,overlay,startIndex,endIndex);
        System.assert(actual==expected, 'StringUtils.overlay(\'' + str + '\',\'' + overlay 
            + '\',' + startIndex + ',' + endIndex + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRemove(){
        //test: global static String remove(String str, String remove) {
        assertRemove(null, null, null);
        assertRemove('', null, '');
        assertRemove('xyz', null, 'xyz');
        assertRemove('xyz', '', 'xyz');
        assertRemove('queued', 'ue', 'qd');
        assertRemove('queued', 'zz', 'queued');
        
    }

    private static void assertRemove(String str, String remove, String expected) {
        String actual = StringUtils.remove(str,remove);
        System.assert(actual==expected, 'StringUtils.remove(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStart(){
        //test: global static String removeStart(String str, String remove) {
        assertRemoveStart(null, null, null);
        assertRemoveStart('', null, '');
        assertRemoveStart('xyz', null, 'xyz');
        assertRemoveStart('/', '/', '');
        assertRemoveStart('www.domain.com', 'www.', 'domain.com');
        assertRemoveStart('domain.com', 'www.', 'domain.com');
        assertRemoveStart('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveStart('abc', '', 'abc');
    }

    private static void assertRemoveStart(String str, String remove, String expected) {
        String actual = StringUtils.removeStart(str,remove);
        System.assert(actual==expected, 'StringUtils.removeStart(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveStartIgnoreCase(){
        //test: global static String removeStartIgnoreCase(String str, String remove) {
        assertRemoveStartIgnoreCase(null, null, null);
        assertRemoveStartIgnoreCase('', null, '');
        assertRemoveStartIgnoreCase('xyz', null, 'xyz');
        assertRemoveStartIgnoreCase('www.domain.com', 'www.', 'domain.com');
        assertRemoveStartIgnoreCase('www.domain.com', 'WWW.', 'domain.com');
        assertRemoveStartIgnoreCase('domain.com', 'www.', 'domain.com');
        assertRemoveStartIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveStartIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveStartIgnoreCase(String str, String remove, String expected) {
        String actual = StringUtils.removeStartIgnoreCase(str,remove);
        System.assert(actual==expected, 'StringUtils.removeStartIgnoreCase(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEnd(){
        //test: global static String removeEnd(String str, String remove) {
        assertRemoveEnd(null, null, null);
        assertRemoveEnd('', null, '');
        assertRemoveEnd('xyz', null, 'xyz');
        assertRemoveEnd('www.domain.com', '.com.', 'www.domain.com');
        assertRemoveEnd('www.domain.com', '.com', 'www.domain');
        assertRemoveEnd('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveEnd('abc', '', 'abc');
    }

    private static void assertRemoveEnd(String str, String remove, String expected) {
        String actual = StringUtils.removeEnd(str,remove);
        System.assert(actual==expected, 'StringUtils.removeEnd(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRemoveEndIgnoreCase(){
        //test: global static String removeEndIgnoreCase(String str, String remove) {
        assertRemoveEndIgnoreCase(null, null, null);
        assertRemoveEndIgnoreCase('', null, '');
        assertRemoveEndIgnoreCase('xyz', null, 'xyz');
        assertRemoveEndIgnoreCase('www.domain.com', '.com.', 'www.domain.com');
        assertRemoveEndIgnoreCase('www.domain.com', '.com', 'www.domain');
        assertRemoveEndIgnoreCase('www.domain.com', 'domain', 'www.domain.com');
        assertRemoveEndIgnoreCase('abc', '', 'abc');
    }

    private static void assertRemoveEndIgnoreCase(String str, String remove, String expected) {
        String actual = StringUtils.removeEndIgnoreCase(str,remove);
        System.assert(actual==expected, 'StringUtils.removeEndIgnoreCase(\'' + str + '\',\'' + remove 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testRegionMatchesCaseSensitive(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatchesCaseSensitive(null, 0, null, 0, 0, true);
        assertRegionMatchesCaseSensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatchesCaseSensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, false);
    }

    private static void assertRegionMatchesCaseSensitive(String str, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = StringUtils.regionMatches(str,toffset,other,ooffset,len);
        System.assert(actual==expected, 'StringUtils.regionMatches(\'' 
            + str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatchesCaseInsensitive(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatchesCaseInsensitive(null, 0, null, 0, 0, true);
        assertRegionMatchesCaseInsensitive('aaaxyzaaa', 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatchesCaseInsensitive('aaaXYZaaa', 3, 'aaaaxyzaa', 4, 3, true);
    }

    private static void assertRegionMatchesCaseInsensitive(String str, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = StringUtils.regionMatchesIgnoreCase(str,toffset,other,ooffset,len);
        System.assert(actual==expected, 'StringUtils.regionMatchesIgnoreCase(\'' 
            + str + '\',' + toffset + ',\'' + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testRegionMatches(){
        //test: global static boolean regionMatches(String str, boolean ignoreCase,
        //            Integer toffset, String other, Integer ooffset, Integer len){
        assertRegionMatches(null, false, 0, null, 0, 0, true);
        assertRegionMatches('aaaxyzaaa', false, 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatches('aaaXYZaaa', false, 3, 'aaaaxyzaa', 4, 3, false);
        assertRegionMatches('aaaXYZaaa', true, 3, 'aaaaxyzaa', 4, 3, true);
        assertRegionMatches(
            'Java is a wonderful language',
          // 0    5    10   15   20   25   
            false, 20, 
            'It is an object-oriented language', 25, 6, true);
          // 0    5    10   15   20   25   30
    }

    private static void assertRegionMatches(String str, boolean ignoreCase, Integer toffset, 
        String other, Integer ooffset, Integer len, Boolean expected) {
        Boolean actual = StringUtils.regionMatches(str,ignoreCase,toffset,other,ooffset,len);
        System.assert(actual==expected, 'StringUtils.regionMatches(\'' 
            + str + '\',' + ignoreCase + ',' + toffset + ',\'' 
            + other + '\',' + ooffset + ',' + len 
            + ') returned ' + actual + '; expected ' + expected );
    }

    private static testmethod void testReplaceThreeArgs(){
        //test: global static String replace(String text, String searchString, String replacement) {

        assertReplaceThreeArgs(null, null, null, null);
        assertReplaceThreeArgs('', null, null, '');
        assertReplaceThreeArgs('any', null, null, 'any');
        assertReplaceThreeArgs('any', null, null, 'any');
        assertReplaceThreeArgs('any', '', null, 'any');
        assertReplaceThreeArgs('aba', 'a', null, 'aba');
        assertReplaceThreeArgs('aba', 'a', '', 'b');
        assertReplaceThreeArgs('aba', 'a', 'z', 'zbz');
    }

    private static void assertReplaceThreeArgs(String text, String searchString, String replacement, String expected){
        String actual = StringUtils.replace(text,searchString,replacement);
        System.assert(actual==expected, 'StringUtils.replace(\'' + text + '\',\'' 
            + searchString + '\',\'' + replacement + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceFourArgs(){
        //test: global static String replace(String text, String searchString, String replacement, Integer max) {
        assertReplaceFourArgs(null, null, null, -1, null);
        assertReplaceFourArgs('', null, null, -1, '');
        assertReplaceFourArgs('any', null, null, -1, 'any');
        assertReplaceFourArgs('any', null, null, -1, 'any');
        assertReplaceFourArgs('any', '', null, -1, 'any');
        assertReplaceFourArgs('any', null, null, 0, 'any');
        assertReplaceFourArgs('abaa', 'a', null, -1, 'abaa');
        assertReplaceFourArgs('abaa', 'a', '', -1, 'b');
        assertReplaceFourArgs('abaa', 'a', 'z', 0, 'abaa');
        assertReplaceFourArgs('abaa', 'a', 'z', 1, 'zbaa');
        assertReplaceFourArgs('abaa', 'a', 'z', 2, 'zbza');
        assertReplaceFourArgs('abaa', 'a', 'z', -1, 'zbzz');
    }

    private static void assertReplaceFourArgs(String text, String searchString, String replacement, Integer max, String expected){
        String actual = StringUtils.replace(text,searchString,replacement,max);
        System.assert(actual==expected, 'StringUtils.replace(\'' + text + '\',\'' 
            + searchString + '\',\'' + replacement + '\',' + max + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceEachThreeArgs(){
        //test: global static String replaceEach(String text, String[] searchList, String[] replacementList) {
        assertReplaceEachThreeArgs(null, null, null, null);
        assertReplaceEachThreeArgs('', null, null, '');
        assertReplaceEachThreeArgs('aba', null, null, 'aba');
        assertReplaceEachThreeArgs('aba', new String[0], null, 'aba');
        assertReplaceEachThreeArgs('aba', null, new String[0], 'aba');
        assertReplaceEachThreeArgs('aba', new String[]{'a'}, null, 'aba');
        assertReplaceEachThreeArgs('aba', new String[]{'a'}, new String[]{''}, 'b');
        assertReplaceEachThreeArgs('aba', new String[]{null}, new String[]{'a'}, 'aba');
        assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, 'wcte');
        assertReplaceEachThreeArgs('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, 'dcte');
    }

    private static void assertReplaceEachThreeArgs(String text, String[] searchList, String[] replacementList, String expected){
        String actual = StringUtils.replaceEach(text,searchList,replacementList);
        System.assert(actual==expected, 'StringUtils.replaceEach(\'' + text + '\',' 
            + ArrayUtils.toString(searchList) + ',' + ArrayUtils.toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceEachRepeatedly(){
        //test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
        assertReplaceEachRepeatedly(null, null, null, false,null);
        assertReplaceEachRepeatedly('', null, null, false,'');
        assertReplaceEachRepeatedly('aba', null, null, false,'aba');
        assertReplaceEachRepeatedly('aba', new String[0], null, false,'aba');
        assertReplaceEachRepeatedly('aba', null, new String[0], false,'aba');
        assertReplaceEachRepeatedly('aba', new String[]{'a'}, null, false,'aba');
        assertReplaceEachRepeatedly('aba', new String[]{'a'}, new String[]{''}, false,'b');
        assertReplaceEachRepeatedly('aba', new String[]{null}, new String[]{'a'}, false,'aba');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'w', 't'}, false,'wcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, false,'dcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 't'}, true,'tcte');
        assertReplaceEachRepeatedly('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,'dcabe');
    }

    private static void assertReplaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat, String expected){
        String actual = StringUtils.replaceEachRepeatedly(text,searchList,replacementList,repeat);
        System.assert(actual==expected, 'StringUtils.replaceEachRepeatedly(\'' + text + '\',' 
            + ArrayUtils.toString(searchList) + ',' + ArrayUtils.toString(replacementList) + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    } 
 
    private static testmethod void testReplaceEachFiveArgExceptions(){
        //test: global static String replaceEachRepeatedly(String text, String[] searchList, String[] replacementList, Boolean repeat) {
        IllegalStateException illegalState = null;
        try{
            StringUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'d', 'ab'}, false,-1);
        }catch(IllegalStateException e){
            illegalState = e;
        }
        System.assertNotEquals(null,illegalState);

        IllegalArgumentException illegalArgument = null;
        try{
            StringUtils.replaceEach('abcde', new String[]{'ab', 'd'}, new String[]{'ab'}, false,0);
        }catch(IllegalArgumentException e){
            illegalArgument = e;
        }
        System.assertNotEquals(null,illegalArgument);
    }

    private static testmethod void testStartsWith(){
        //test:global static boolean startsWith(String str, String prefix) 
        assertStartsWith(null, null, true);
        assertStartsWith(null, 'abcdef', false);
        assertStartsWith('abc', null, false);
        assertStartsWith('abc', 'abcdef', false);
        assertStartsWith('abcdef', 'abc', true);
        assertStartsWith('ABCDEF', 'abc', false);
    }

    private static void assertStartsWith(String str, String prefix, Boolean expected) {
        Boolean actual = StringUtils.startsWith(str,prefix);
        System.assert(actual==expected, 'StringUtils.startsWith(\'' + str + '\',\'' + prefix 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testStartsWithIgnoreCase(){
        //test:global static boolean startsWithIgnoreCase(String str, String prefix) 
        assertStartsWithIgnoreCase(null, null, true);
        assertStartsWithIgnoreCase(null, 'abcdef', false);        assertStartsWithIgnoreCase('abc', null, false);
        assertStartsWithIgnoreCase('abcdef', 'abc', true);
        assertStartsWithIgnoreCase('ABCDEF', 'abc', true); 
    }

    private static void assertStartsWithIgnoreCase(String str, String prefix, Boolean expected) {
        Boolean actual = StringUtils.startsWithIgnoreCase(str,prefix);
        System.assert(actual==expected, 'StringUtils.startsWithIgnoreCase(\'' + str + '\',\'' + prefix 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testReplaceOnce(){
        //test: global static String replaceOnce(String text, String searchString, String replacement)
        assertReplaceOnce(null, null, null, null);
        assertReplaceOnce('', null, null, '');
        assertReplaceOnce('any', null, null, 'any');
        assertReplaceOnce('any', null, null, 'any');
        assertReplaceOnce('any', '', null, 'any');
        assertReplaceOnce('aba', 'a', null, 'aba');
        assertReplaceOnce('aba', 'a', '', 'ba');
        assertReplaceOnce('aba', 'a', 'z', 'zba');
    }

    private static void assertReplaceOnce(String text, String searchString, String replacement, String expected) {
        String actual = StringUtils.replaceOnce(text, searchString, replacement);
        System.assert(actual==expected, 'StringUtils.replaceOnce(\'' + text + '\',\'' + searchString 
            + '\',\'' + replacement + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testReverse(){
        //test: global static String reverse(String str)
        assertReverse(null, null);
        assertReverse('', '');
        assertReverse('bat', 'tab');
    }

    private static void assertReverse(String str, String expected) {
        String actual = StringUtils.reverse(str); 
        System.assert(actual==expected, 'StringUtils.reverse(\'' + str 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testReverseDelimited(){
        //test: global static String reverseDelimited(String str, String separatorChar) 
        assertReverseDelimited(null, null, null);
        assertReverseDelimited('', null, '');
        assertReverseDelimited('a.b.c', 'x', 'a.b.c');
        assertReverseDelimited('a.b.c', '.', 'c.b.a');
    }

    private static void assertReverseDelimited(String str, String separatorChar, String expected) {
        String actual = StringUtils.reverseDelimited(str, separatorChar);
        System.assert(actual==expected, 'StringUtils.reverseDelimited(\'' + str + '\',\'' + separatorChar 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testRight(){
        //test: global static String right(String str, Integer len) 
        assertRight(null, 0, null);
        assertRight('abcdefg', -1, '');
        assertRight('', -1, '');
        assertRight('abc', 0, '');
        assertRight('abc', 2, 'bc');
        assertRight('abc', 4, 'abc');
    }

    private static void assertRight(String str, Integer len, String expected) {
        String actual = StringUtils.right(str, len);
        System.assert(actual==expected, 'StringUtils.right(\'' + str + '\',' + len 
            + ') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }
    
    private static testmethod void testSplitByCharacterTypeCamelCase(){
        //test: global static String[] splitByCharacterTypeCamelCase(String str)
        assertSplitByCharacterTypeCamelCase(null,             null);
        assertSplitByCharacterTypeCamelCase('',             new String[]{});
        assertSplitByCharacterTypeCamelCase('ab de fg',     new String[]{'ab', ' ', 'de', ' ', 'fg'});
        assertSplitByCharacterTypeCamelCase('ab   de fg',     new String[]{'ab', '   ', 'de', ' ', 'fg'});
        assertSplitByCharacterTypeCamelCase('ab:cd:ef',     new String[]{'ab', ':', 'cd', ':', 'ef'});
        assertSplitByCharacterTypeCamelCase('number5',         new String[]{'number', '5'});
        assertSplitByCharacterTypeCamelCase('fooBar',         new String[]{'foo', 'Bar'});
        assertSplitByCharacterTypeCamelCase('foo200Bar',     new String[]{'foo', '200', 'Bar'});
        assertSplitByCharacterTypeCamelCase('ASFRules',     new String[]{'ASF', 'Rules'});
    }

    private static void assertSplitByCharacterTypeCamelCase(String str, Object[] expected) {
        ArrayUtils.AssertArraysAreEqual(expected,StringUtils.splitByCharacterTypeCamelCase(str));
    }
    
    private static testmethod void testSplitByCharacterType(){
        //test:  global static String[] splitByCharacterType(String str)
        assertSplitByCharacterType(null,             null);
        assertSplitByCharacterType('',                 new String[]{});
        assertSplitByCharacterType('ab de fg',         new String[]{'ab', ' ', 'de', ' ', 'fg'});
        assertSplitByCharacterType('ab   de fg',     new String[]{'ab', '   ', 'de', ' ', 'fg'});
        assertSplitByCharacterType('ab:cd:ef',         new String[]{'ab', ':', 'cd', ':', 'ef'});
        assertSplitByCharacterType('number5',         new String[]{'number', '5'});
        assertSplitByCharacterType('fooBar',         new String[]{'foo', 'B', 'ar'});
        assertSplitByCharacterType('foo200Bar',     new String[]{'foo', '200', 'B', 'ar'});
        assertSplitByCharacterType('ASFRules',         new String[]{'ASFR', 'ules'});
    }

    private static void assertSplitByCharacterType(String str, Object[] expected) {
        ArrayUtils.AssertArraysAreEqual(expected,StringUtils.splitByCharacterType(str));
    }
     
    private static testmethod void testTrimToEmpty(){
        //test: global static String trimToEmpty(String str) {
        assertTrimToEmpty(null, '');
        assertTrimToEmpty('', '');
        assertTrimToEmpty('     ', '');
        assertTrimToEmpty('abc', 'abc');
        assertTrimToEmpty('    abc    ', 'abc');
    }

    private static void assertTrimToEmpty(String str, String expected) {
        String actual = StringUtils.trimToEmpty(str);
        System.assert(actual==expected, 'StringUtils.trimToEmpty(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }

    private static testmethod void testTrimToNull(){
        //test:  global static String trimToNull(String str) {
        assertTrimToNull(null, null);
        assertTrimToNull('', null);
        assertTrimToNull('     ', null);
        assertTrimToNull('abc', 'abc');
        assertTrimToNull('    abc    ', 'abc');
    }

    private static void assertTrimToNull(String str, String expected) {
        String actual = StringUtils.trimToNull(str);
        System.assert(actual==expected, 'StringUtils.trimToNull(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripOneArg(){
        //test: global static String strip(String str)
        assertStripOneArg(null, null);
        assertStripOneArg('', '');
        assertStripOneArg('   ', '');
        assertStripOneArg('abc', 'abc');
        assertStripOneArg('  abc', 'abc');
        assertStripOneArg('abc  ', 'abc');
        assertStripOneArg(' abc ', 'abc');
        assertStripOneArg(' ab c ', 'ab c');
    }

    private static void assertStripOneArg(String str, String expected) {
        String actual = StringUtils.strip(str);
        System.assert(actual==expected, 'StringUtils.strip(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripToNull(){
        //test: global static String stripToNull(String str) {
        assertStripToNull(null,null);
        assertStripToNull('',null);
        assertStripToNull('   ',null);
        assertStripToNull('abc','abc');
        assertStripToNull('  abc','abc');
        assertStripToNull('abc  ','abc');
        assertStripToNull(' abc ','abc');
        assertStripToNull(' ab c ','ab c');
    }

    private static void assertStripToNull(String str, String expected) {
        String actual = StringUtils.stripToNull(str);
        System.assert(actual==expected, 'StringUtils.stripToNull(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    
    
    private static testmethod void testStripToEmpty(){
        //test: global static String stripToEmpty(String str) {
        assertStripToEmpty(null, '');
        assertStripToEmpty('', '');
        assertStripToEmpty('   ', '');
        assertStripToEmpty('abc', 'abc');
        assertStripToEmpty('  abc', 'abc');
        assertStripToEmpty('abc  ', 'abc');
        assertStripToEmpty(' abc ', 'abc');
        assertStripToEmpty(' ab c ', 'ab c');
    }

    private static void assertStripToEmpty(String str, String expected) {
        String actual = StringUtils.stripToEmpty(str);
        System.assert(actual==expected, 'StringUtils.stripToEmpty(\'' + str + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }    

    private static testmethod void testStripTwoArgs(){
        //test: global static String strip(String str, String stripChars)
        assertStripTwoArgs(null, null, null);
        assertStripTwoArgs('', null, '');
        assertStripTwoArgs('abc', null, 'abc');
        assertStripTwoArgs('  abc', null, 'abc');
        assertStripTwoArgs('abc  ', null, 'abc');
        assertStripTwoArgs(' abc ', null, 'abc');
        assertStripTwoArgs('  abcyx', 'xyz', '  abc');
    }

    private static void assertStripTwoArgs(String str, String stripChars, String expected) {
        String actual = StringUtils.strip(str,stripChars);
        System.assert(actual==expected, 'StringUtils.strip(\'' + str + '\',\'' + stripChars + '\') returned \'' 
            + actual + '\'; expected \'' + expected + '\'');
    }   

    private static testmethod void testStripStart(){
        //test:  global static String stripStart(String str, String stripChars)
        assertStripStart(null, null, null);
        assertStripStart('', null, '');
        assertStripStart('abc', '', 'abc');
        assertStripStart('abc', null, 'abc');
        assertStripStart('  abc', null, 'abc');
        assertStripStart('abc  ', null, 'abc  ');
        assertStripStart(' abc ', null, 'abc ');
        assertStripStart('yxabc  ', 'xyz', 'abc  ');
    }

    private static void assertStripStart(String str, String stripChars, String expected) {
        String actual = StringUtils.stripStart(str,stripChars);
        System.assert(actual==expected, 'StringUtils.stripStart(\'' + str + '\',\'' + stripChars 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }              

    private static testmethod void testStripEnd(){
        //test: global static String stripEnd(String str, String stripChars)
        assertStripEnd(null, null, null);
        assertStripEnd('', null, '');
        assertStripEnd('abc', '', 'abc');
        assertStripEnd('abc', null, 'abc');
        assertStripEnd('  abc', null, '  abc');
        assertStripEnd('abc  ', null, 'abc');
        assertStripEnd(' abc ', null, ' abc');
        assertStripEnd('  abcyx', 'xyz', '  abc');
    }

    private static void assertStripEnd(String str, String stripChars, String expected) {
        String actual = StringUtils.stripEnd(str,stripChars);
        System.assert(actual==expected, 'StringUtils.stripEnd(\'' + str + '\', \'' + stripChars 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testStripAllOneArg(){
        //test: global static String[] stripAll(String[] strs)
        assertStripAllOneArg(null, null);
        assertStripAllOneArg(new String[]{}, new String[]{});
        assertStripAllOneArg(new String[]{'abc', '  abc'}, new String[]{'abc', 'abc'});
        assertStripAllOneArg(new String[]{'abc  ', null}, new String[]{'abc', null});
    }

    private static void assertStripAllOneArg(String[] strs, String[] expected) {
        ArrayUtils.assertArraysAreEqual(expected,StringUtils.stripAll(strs));
    } 
     
    private static testmethod void testStripAllTwoArgs(){
        //test: global static String[] stripAll(String[] strs, String stripChars)
        assertStripAllTwoArgs(null, null, null);
        assertStripAllTwoArgs(new String[]{}, null, new String[]{});
        assertStripAllTwoArgs(new String[]{'abc', '  abc'}, null, new String[]{'abc', 'abc'});
        assertStripAllTwoArgs(new String[]{'abc  ', null}, null, new String[]{'abc', null});
        assertStripAllTwoArgs(new String[]{'abc  ', null}, 'yz', new String[]{'abc  ', null});
        assertStripAllTwoArgs(new String[]{'yabcz', null}, 'yz', new String[]{'abc', null});
    }

    private static void assertStripAllTwoArgs(String[] strs, String stripChars, String[] expected) {
        ArrayUtils.assertArraysAreEqual(expected,StringUtils.stripAll(strs,stripChars));
    }
    
    private static testmethod void testSubstringBefore(){
        //test: global static String substringBefore(String str, String separator)
        assertSubstringBefore(null, null, null);
        assertSubstringBefore('', null, '');
        assertSubstringBefore('abc', 'a', '');
        assertSubstringBefore('abcba', 'b', 'a');
        assertSubstringBefore('abc', 'c', 'ab');
        assertSubstringBefore('abc', 'd', 'abc');
        assertSubstringBefore('abc', '', '');
        assertSubstringBefore('abc', null, 'abc');
    }

    private static void assertSubstringBefore(String str, String separator, String expected) {
        String actual = StringUtils.substringBefore(str,separator);
        System.assert(actual==expected, 'StringUtils.substringBefore(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringAfter(){
        //test: global static String substringAfter(String str, String separator)
        assertSubstringAfter(null, null, null);
        assertSubstringAfter('', null, '');
        assertSubstringAfter('asdf', null, '');
        assertSubstringAfter(null, null, null);
        assertSubstringAfter('abc', 'a', 'bc');
        assertSubstringAfter('abcba', 'b', 'cba');
        assertSubstringAfter('abc', 'c', '');
        assertSubstringAfter('abc', 'd', '');
        assertSubstringAfter('abc', '', 'abc');
    }

    private static void assertSubstringAfter(String str, String separator, String expected) {
        String actual = StringUtils.substringAfter(str,separator);
        System.assert(actual==expected, 'StringUtils.substringAfter(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBeforeLast(){
        //test: global static String substringBeforeLast(String str, String separator)
        assertSubstringBeforeLast(null, null, null);
        assertSubstringBeforeLast('', null, '');
        assertSubstringBeforeLast('abcba', 'b', 'abc');
        assertSubstringBeforeLast('abc', 'c', 'ab');
        assertSubstringBeforeLast('a', 'a', '');
        assertSubstringBeforeLast('a', 'z', 'a');
        assertSubstringBeforeLast('a', null, 'a');
        assertSubstringBeforeLast('a', '', 'a');
    }

    private static void assertSubstringBeforeLast(String str, String separator, String expected) {
        String actual = StringUtils.substringBeforeLast(str,separator);
        System.assert(actual==expected, 'StringUtils.substringBeforeLast(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringAfterLast(){
        //test: global static String substringAfterLast(String str, String separator)
        assertSubstringAfterLast(null, null, null);
        assertSubstringAfterLast('', null, '');
        assertSubstringAfterLast('adsfa', null, '');
        assertSubstringAfterLast(null, '', null);
        assertSubstringAfterLast('abc', 'a', 'bc');
        assertSubstringAfterLast('abcba', 'b', 'a');
        assertSubstringAfterLast('abc', 'c', '');
        assertSubstringAfterLast('a', 'a', '');
        assertSubstringAfterLast('a', 'z', '');
    }

    private static void assertSubstringAfterLast(String str, String separator, String expected) {
        String actual = StringUtils.substringAfterLast(str,separator);
        System.assert(actual==expected, 'StringUtils.substringAfterLast(\'' + str + '\', \'' + separator 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBetweenTwoArgs(){
        //test: global static String substringBetween(String str, String tag)
        assertSubstringBetweenTwoArgs(null, null, null);
        assertSubstringBetweenTwoArgs('', '', '');
        assertSubstringBetweenTwoArgs('', 'tag', null);
        assertSubstringBetweenTwoArgs('tagabctag', null, null);
        assertSubstringBetweenTwoArgs('tagabctag', '', '');
        assertSubstringBetweenTwoArgs('tagabctag', 'tag', 'abc');
    }

    private static void assertSubstringBetweenTwoArgs(String str, String tag, String expected) {
        String actual = StringUtils.substringBetween(str,tag);
        System.assert(actual==expected, 'StringUtils.substringBetween(\'' + str + '\', \'' + tag 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringBetweenThreeArgs(){
        //test: global static String substringBetween(String str, String open, String close)
        assertSubstringBetweenThreeArgs('wx[b]yz', '[', ']', 'b');
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs(null, null, null, null);
        assertSubstringBetweenThreeArgs('', '', '', '');
        assertSubstringBetweenThreeArgs('', '', ']', null);
        assertSubstringBetweenThreeArgs('', '[', ']', null);
        assertSubstringBetweenThreeArgs('yabcz', '', '', '');
        assertSubstringBetweenThreeArgs('yabcz', 'y', 'z', 'abc');
        assertSubstringBetweenThreeArgs('yabczyabcz', 'y', 'z', 'abc');
    } 

    private static void assertSubstringBetweenThreeArgs(String str, String open, String close, String expected) {
        String actual = StringUtils.substringBetween(str,open,close);
        System.assert(actual==expected, 'StringUtils.substringBetween(\'' + str + '\',\'' + open + '\', \'' + close 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testSubstringsBetween(){
        //test: global static String[] substringsBetween(String str, String open, String close)
        assertSubstringsBetween('[a][b][c]', '[', ']', new String[]{'a','b','c'});
        assertSubstringsBetween(null, null, null, null);
        assertSubstringsBetween('asdf', '[', ']', null);
        assertSubstringsBetween('a[df', '[', ']', null);
        assertSubstringsBetween('', '[', ']', new String[]{});
    }

    private static void assertSubstringsBetween(String str, String open, String close, String[] expected) {
        ArrayUtils.assertArraysAreEqual(expected, StringUtils.substringsBetween(str,open,close));
    }  

    private static testmethod void testEnsureStringStartsEndsWithChar(){
        //test: global static String ensureStringStartsEndsWithChar(String str, String charc){
        assertEnsureStringStartsEndsWithChar(null, null, null);
        assertEnsureStringStartsEndsWithChar(null, 'abc', null);
        assertEnsureStringStartsEndsWithChar('', 'abc', 'abcabc');
        assertEnsureStringStartsEndsWithChar('test123', null, 'test123');
        assertEnsureStringStartsEndsWithChar('test123', 'abc', 'abctest123abc');
    }

    private static void assertEnsureStringStartsEndsWithChar(String str, String charc, String expected) {
        String actual = StringUtils.ensureStringStartsEndsWithChar(str,charc);
        System.assert(actual==expected, 'StringUtils.ensureStringStartsEndsWithChar(\'' + str + '\', \'' + charc 
            + '\') returned \'' + actual + '\'; expected \'' + expected + '\'');
    }  

    private static testmethod void testToCharArray(){
        //test: global static String[] toCharArray(String str){
        ArrayUtils.assertArraysAreEqual(new String[]{},StringUtils.toCharArray(null));
        ArrayUtils.assertArraysAreEqual(new String[]{},StringUtils.toCharArray(''));
        ArrayUtils.assertArraysAreEqual(new String[]{' '},StringUtils.toCharArray(' '));
        ArrayUtils.assertArraysAreEqual(new String[]{' ',' '},StringUtils.toCharArray('  '));
        ArrayUtils.assertArraysAreEqual(new String[]{'a','b','c'},StringUtils.toCharArray('abc'));
    }

    private static testmethod void testTrimAll_Set(){
        Set<String> NULL_SET = null;
        System.assertEquals(null,StringUtils.trimAll(NULL_SET));
        SetUtils.assertEquals(new Set<String>{'a','b'},StringUtils.trimAll(new Set<String>{' a ',' b '}));
    }

    private static testmethod void testTrimAll_List(){
        List<String> NULL_LIST = null;
        System.assertEquals(null,StringUtils.trimAll(NULL_LIST));
        ArrayUtils.assertArraysAreEqual(new List<String>{'a','b'},StringUtils.trimAll(new List<String>{' a ',' b '}));
    }

    private static testmethod void test_trimLower(){
    	//test: global static String trimLower(String str)
        System.assertEquals(null,StringUtils.trimLower(null));
        System.assertEquals('',StringUtils.trimLower(''));
        System.assertEquals('abc',StringUtils.trimLower('  abc  '));
        System.assertEquals('abc',StringUtils.trimLower('  ABC  '));
    }
    
    private static testmethod void test_stripMarkup(){
        //test: global static String trimLower(String str)
        System.assertEquals(null, StringUtils.stripMarkup(null)); 
        System.assertEquals('', StringUtils.stripMarkup(''));
        System.assertEquals('Title! ABC 123', StringUtils.stripMarkup('  Title!   ABC 123  '));
        System.assertEquals('Title! ABC 123', StringUtils.stripMarkup('<html><body><h1>Title!</h1><p>ABC 123</p></html>')); 
    }

}