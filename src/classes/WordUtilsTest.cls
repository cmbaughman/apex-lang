/* ============================================================
 * This code is part of the 'apex-lang' open source project avaiable at:
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
private class WordUtilsTest{

    private static testmethod void testWrap_StringInt() {
        System.System.assertEquals(null, WordUtils.wrap(null, 20));
        System.System.assertEquals(null, WordUtils.wrap(null, -1));
        
        System.System.assertEquals('', WordUtils.wrap('', 20));
        System.System.assertEquals('', WordUtils.wrap('', -1));
        
        // normal
        final String systemNewLine = SystemUtils.LINE_SEPARATOR;
        String input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        String expected = 'Here is one line of' + systemNewLine + 'text that is going' 
            + systemNewLine + 'to be wrapped after' + systemNewLine + '20 columns.';
        System.System.assertEquals(expected, WordUtils.wrap(input, 20));
        
        // long word at end
        input = 'Click here to jump to the jakarta website - http://jakarta.apache.org';
        expected = 'Click here to jump' + systemNewLine + 'to the jakarta' + systemNewLine 
            + 'website -' + systemNewLine + 'http://jakarta.apache.org';
        System.System.assertEquals(expected, WordUtils.wrap(input, 20));
        
        // long word in middle
        input = 'Click here, http://jakarta.apache.org, to jump to the jakarta website';
        expected = 'Click here,' + systemNewLine + 'http://jakarta.apache.org,' + systemNewLine 
            + 'to jump to the' + systemNewLine + 'jakarta website';
        System.System.assertEquals(expected, WordUtils.wrap(input, 20));
    }
    
    private static testmethod void testWrap_StringIntStringBoolean() {
        System.assertEquals(null, WordUtils.wrap(null, 20, '\n', false));
        System.assertEquals(null, WordUtils.wrap(null, 20, '\n', true));
        System.assertEquals(null, WordUtils.wrap(null, 20, null, true));
        System.assertEquals(null, WordUtils.wrap(null, 20, null, false));
        System.assertEquals(null, WordUtils.wrap(null, -1, null, true));
        System.assertEquals(null, WordUtils.wrap(null, -1, null, false));
        
        System.assertEquals('', WordUtils.wrap('', 20, '\n', false));
        System.assertEquals('', WordUtils.wrap('', 20, '\n', true));
        System.assertEquals('', WordUtils.wrap('', 20, null, false));
        System.assertEquals('', WordUtils.wrap('', 20, null, true));
        System.assertEquals('', WordUtils.wrap('', -1, null, false));
        System.assertEquals('', WordUtils.wrap('', -1, null, true));
        
        // normal
        String input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        String expected = 'Here is one line of\ntext that is going\nto be wrapped after\n20 columns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));

        // unusual newline String
        input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is one line of<br />text that is going<br />to be wrapped after<br />20 columns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '<br />', false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, '<br />', true));

        // short line length
        input = 'Here is one line';
        expected = 'Here\nis one\nline';
        System.assertEquals(expected, WordUtils.wrap(input, 6, '\n', false));
        expected = 'Here\nis\none\nline';
        System.assertEquals(expected, WordUtils.wrap(input, 2, '\n', false));
        System.assertEquals(expected, WordUtils.wrap(input, -1, '\n', false));

        // system newline String
        String systemNewLine = '\n';
        input = 'Here is one line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is one line of' + systemNewLine + 'text that is going' + systemNewLine 
            + 'to be wrapped after' + systemNewLine + '20 columns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, null, false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, null, true));

        // with extra spaces
        input = ' Here:  is  one  line  of  text  that  is  going  to  be  wrapped  after  20  columns.';
        expected = 'Here:  is  one  line\nof  text  that  is \ngoing  to  be \nwrapped  after  20 \ncolumns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));
        
        // with tab
        input = 'Here is\tone line of text that is going to be wrapped after 20 columns.';
        expected = 'Here is\tone line of\ntext that is going\nto be wrapped after\n20 columns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));
        
        // with tab at wrapColumn
        input = 'Here is one line of\ttext that is going to be wrapped after 20 columns.';
        expected = 'Here is one line\nof\ttext that is\ngoing to be wrapped\nafter 20 columns.';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));
        
        // difference because of long word
        input = 'Click here to jump to the jakarta website - http://jakarta.apache.org';
        expected = 'Click here to jump\nto the jakarta\nwebsite -\nhttp://jakarta.apache.org';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        expected = 'Click here to jump\nto the jakarta\nwebsite -\nhttp://jakarta.apach\ne.org';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));
        
        // difference because of long word in middle
        input = 'Click here, http://jakarta.apache.org, to jump to the jakarta website';
        expected = 'Click here,\nhttp://jakarta.apache.org,\nto jump to the\njakarta website';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', false));
        expected = 'Click here,\nhttp://jakarta.apach\ne.org, to jump to\nthe jakarta website';
        System.assertEquals(expected, WordUtils.wrap(input, 20, '\n', true));
//        System.err.println(expected);
//        System.err.println(WordUtils.wrap(input, 20, '\n', false));
    }
    
    private static testmethod void testCapitalize_String() {
        System.assertEquals(null, WordUtils.capitalize(null));
        System.assertEquals('', WordUtils.capitalize(''));
        System.assertEquals('  ', WordUtils.capitalize('  '));
        
        System.assertEquals('I', WordUtils.capitalize('I') );
        System.assertEquals('I', WordUtils.capitalize('i') );
        System.assertEquals('I Am Here 123', WordUtils.capitalize('i am here 123') );
        System.assertEquals('I Am Here 123', WordUtils.capitalize('I Am Here 123') );
        System.assertEquals('I Am HERE 123', WordUtils.capitalize('i am HERE 123') );
        System.assertEquals('I AM HERE 123', WordUtils.capitalize('I AM HERE 123') );
    }
    
    private static testmethod void testCapitalizeWithDelimiters_String() {
        System.assertEquals(null, WordUtils.capitalize(null, null));
        System.assertEquals('', WordUtils.capitalize('', new String[0]));
        System.assertEquals('  ', WordUtils.capitalize('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('I', ''+WordUtils.capitalize('I', chars) );
        System.assertEquals('I', WordUtils.capitalize('i', chars) );
        System.assertEquals('I-Am Here+123', WordUtils.capitalize('i-am here+123', chars) );
        System.assertEquals('I Am+Here-123', WordUtils.capitalize('I Am+Here-123', chars) );
        System.assertEquals('I+Am-HERE 123', WordUtils.capitalize('i+am-HERE 123', chars) );
        System.assertEquals('I-AM HERE+123', WordUtils.capitalize('I-AM HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('I aM.Fine', WordUtils.capitalize('i aM.fine', chars) );
        System.assertEquals('I Am.fine', WordUtils.capitalize('i am.fine', null) );
    }

    private static testmethod void testCapitalizeFully_String() {
        System.assertEquals(null, WordUtils.capitalizeFully(null));
        System.assertEquals('', WordUtils.capitalizeFully(''));
        System.assertEquals('  ', WordUtils.capitalizeFully('  '));
        
        System.assertEquals('I', WordUtils.capitalizeFully('I') );
        System.assertEquals('I', WordUtils.capitalizeFully('i') );
        System.assertEquals('I Am Here 123', WordUtils.capitalizeFully('i am here 123') );
        System.assertEquals('I Am Here 123', WordUtils.capitalizeFully('I Am Here 123') );
        System.assertEquals('I Am Here 123', WordUtils.capitalizeFully('i am HERE 123') );
        System.assertEquals('I Am Here 123', WordUtils.capitalizeFully('I AM HERE 123') );
    }
    
    private static testmethod void testCapitalizeFullyWithDelimiters_String() {
        System.assertEquals(null, WordUtils.capitalizeFully(null, null));
        System.assertEquals('', WordUtils.capitalizeFully('', new String[0]));
        System.assertEquals('  ', WordUtils.capitalizeFully('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('I', WordUtils.capitalizeFully('I', chars) );
        System.assertEquals('I', WordUtils.capitalizeFully('i', chars) );
        System.assertEquals('I-Am Here+123', WordUtils.capitalizeFully('i-am here+123', chars) );
        System.assertEquals('I Am+Here-123', WordUtils.capitalizeFully('I Am+Here-123', chars) );
        System.assertEquals('I+Am-Here 123', WordUtils.capitalizeFully('i+am-HERE 123', chars) );
        System.assertEquals('I-Am Here+123', WordUtils.capitalizeFully('I-AM HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('I am.Fine', WordUtils.capitalizeFully('i aM.fine', chars) );
        System.assertEquals('I Am.fine', WordUtils.capitalizeFully('i am.fine', null) );
    }

    private static testmethod void testUncapitalize_String() {
        System.assertEquals(null, WordUtils.uncapitalize(null));
        System.assertEquals('', WordUtils.uncapitalize(''));
        System.assertEquals('  ', WordUtils.uncapitalize('  '));
        
        System.assertEquals('i', WordUtils.uncapitalize('I') );
        System.assertEquals('i', WordUtils.uncapitalize('i') );
        System.assertEquals('i am here 123', WordUtils.uncapitalize('i am here 123') );
        System.assertEquals('i am here 123', WordUtils.uncapitalize('I Am Here 123') );
        System.assertEquals('i am hERE 123', WordUtils.uncapitalize('i am HERE 123') );
        System.assertEquals('i aM hERE 123', WordUtils.uncapitalize('I AM HERE 123') );
    }
    
    private static testmethod void testUncapitalizeWithDelimiters_String() {
        System.assertEquals(null, WordUtils.uncapitalize(null, null));
        System.assertEquals('', WordUtils.uncapitalize('', new String[0]));
        System.assertEquals('  ', WordUtils.uncapitalize('  ', new String[0]));
        
        String[] chars = new String[] { '-', '+', ' ', '@' };
        System.assertEquals('i', WordUtils.uncapitalize('I', chars) );
        System.assertEquals('i', WordUtils.uncapitalize('i', chars) );
        System.assertEquals('i am-here+123', WordUtils.uncapitalize('i am-here+123', chars) );
        System.assertEquals('i+am here-123', WordUtils.uncapitalize('I+Am Here-123', chars) );
        System.assertEquals('i-am+hERE 123', WordUtils.uncapitalize('i-am+HERE 123', chars) );
        System.assertEquals('i aM-hERE+123', WordUtils.uncapitalize('I AM-HERE+123', chars) );
        chars = new String[] {'.'};
        System.assertEquals('i AM.fINE', WordUtils.uncapitalize('I AM.FINE', chars) );
        System.assertEquals('i aM.FINE', WordUtils.uncapitalize('I AM.FINE', null) );
    }

    private static testmethod void testInitials_String() {
        System.assertEquals(null, WordUtils.initials(null));
        System.assertEquals('', WordUtils.initials(''));
        System.assertEquals('', WordUtils.initials('  '));

        System.assertEquals('I', WordUtils.initials('I'));
        System.assertEquals('i', WordUtils.initials('i'));
        System.assertEquals('BJL', WordUtils.initials('Ben John Lee'));
        System.assertEquals('BJ', WordUtils.initials('Ben J.Lee'));
        System.assertEquals('BJ.L', WordUtils.initials(' Ben   John  . Lee'));
        System.assertEquals('iah1', WordUtils.initials('i am here 123'));
    }

    private static testmethod void testInitials_String_charArray() {
        String[] anArray = null;
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals('', WordUtils.initials('  ', anArray));
        System.assertEquals('I', WordUtils.initials('I', anArray));
        System.assertEquals('i', WordUtils.initials('i', anArray));
        System.assertEquals('S', WordUtils.initials('SJC', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJ', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJ.L', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', WordUtils.initials('i am here 123', anArray));
        
        anArray = new String[0];
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals('', WordUtils.initials('  ', anArray));
        System.assertEquals('', WordUtils.initials('I', anArray));
        System.assertEquals('', WordUtils.initials('i', anArray));
        System.assertEquals('', WordUtils.initials('SJC', anArray));
        System.assertEquals('', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('', WordUtils.initials('i am here 123', anArray));
        
        anArray = StringUtils.toCharArray(' ');
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals('', WordUtils.initials('  ', anArray));
        System.assertEquals('I', WordUtils.initials('I', anArray));
        System.assertEquals('i', WordUtils.initials('i', anArray));
        System.assertEquals('S', WordUtils.initials('SJC', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJ', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJ.L', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', WordUtils.initials('i am here 123', anArray));
        
        anArray = StringUtils.toCharArray(' .');
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals('', WordUtils.initials('  ', anArray));
        System.assertEquals('I', WordUtils.initials('I', anArray));
        System.assertEquals('i', WordUtils.initials('i', anArray));
        System.assertEquals('S', WordUtils.initials('SJC', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJL', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KO', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', WordUtils.initials('i am here 123', anArray));
        
        anArray = StringUtils.toCharArray(' .\'');
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals('', WordUtils.initials('  ', anArray));
        System.assertEquals('I', WordUtils.initials('I', anArray));
        System.assertEquals('i', WordUtils.initials('i', anArray));
        System.assertEquals('S', WordUtils.initials('SJC', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('BJL', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals('BJL', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('KOM', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('iah1', WordUtils.initials('i am here 123', anArray));
        
        anArray = StringUtils.toCharArray('SIJo1');
        System.assertEquals(null, WordUtils.initials(null, anArray));
        System.assertEquals('', WordUtils.initials('', anArray));
        System.assertEquals(' ', WordUtils.initials('  ', anArray));
        System.assertEquals('', WordUtils.initials('I', anArray));
        System.assertEquals('i', WordUtils.initials('i', anArray));
        System.assertEquals('C', WordUtils.initials('SJC', anArray));
        System.assertEquals('Bh', WordUtils.initials('Ben John Lee', anArray));
        System.assertEquals('B.', WordUtils.initials('Ben J.Lee', anArray));
        System.assertEquals(' h', WordUtils.initials(' Ben   John  . Lee', anArray));
        System.assertEquals('K', WordUtils.initials('Kay O\'Murphy', anArray));
        System.assertEquals('i2', WordUtils.initials('i am here 123', anArray));
    }

    private static testmethod void testSwapCase_String() {
        System.assertEquals(null, WordUtils.swapCase(null));
        System.assertEquals('', WordUtils.swapCase(''));
        System.assertEquals('  ', WordUtils.swapCase('  '));
        
        System.assertEquals('i', WordUtils.swapCase('I') );
        System.assertEquals('I', WordUtils.swapCase('i') );
        System.assertEquals('I AM HERE 123', WordUtils.swapCase('i am here 123') );
        System.assertEquals('i aM hERE 123', WordUtils.swapCase('I Am Here 123') );
        System.assertEquals('I AM here 123', WordUtils.swapCase('i am HERE 123') );
        System.assertEquals('i am here 123', WordUtils.swapCase('I AM HERE 123') );

        String test = 'This String contains a TitleCase character: ';
        String expect = 'tHIS sTRING CONTAINS A tITLEcASE CHARACTER: ';
        System.assertEquals(expect, WordUtils.swapCase(test));
    }

    private static testmethod void testAbbreviate() {
        // check null and empty are returned respectively
        System.assertEquals(null,WordUtils.abbreviate(null, 1,-1,''));
        System.assertEquals(StringUtils.EMPTY, WordUtils.abbreviate('', 1,-1,''));

        // test upper limit
        System.assertEquals('01234', WordUtils.abbreviate('0123456789', 0,5,''));
        System.assertEquals('01234', WordUtils.abbreviate('0123456789', 5, 2,''));
        System.assertEquals('012', WordUtils.abbreviate('012 3456789', 2, 5,''));
        System.assertEquals('012 3', WordUtils.abbreviate('012 3456789', 5, 2,''));
        System.assertEquals('0123456789', WordUtils.abbreviate('0123456789', 0,-1,''));

        // test upper limit + append string
        System.assertEquals('01234-', WordUtils.abbreviate('0123456789', 0,5,'-'));
        System.assertEquals('01234-', WordUtils.abbreviate('0123456789', 5, 2,'-'));
        System.assertEquals('012', WordUtils.abbreviate('012 3456789', 2, 5, null));
        System.assertEquals('012 3', WordUtils.abbreviate('012 3456789', 5, 2,''));
        System.assertEquals('0123456789', WordUtils.abbreviate('0123456789', 0,-1,''));

        // test lower value
        System.assertEquals('012', WordUtils.abbreviate('012 3456789', 0,5, null));
        System.assertEquals('01234', WordUtils.abbreviate('01234 56789', 5, 10, null));
        System.assertEquals('01 23 45 67', WordUtils.abbreviate('01 23 45 67 89', 9, -1, null));
        System.assertEquals('01 23 45 6', WordUtils.abbreviate('01 23 45 67 89', 9, 10, null));

        // test lower value + append
        System.assertEquals('012', WordUtils.abbreviate('012 3456789', 0,5, null));
        System.assertEquals('01234-', WordUtils.abbreviate('01234 56789', 5, 10, '-'));
        System.assertEquals('01 23 45 67abc', WordUtils.abbreviate('01 23 45 67 89', 9, -1, 'abc'));
        System.assertEquals('01 23 45 6', WordUtils.abbreviate('01 23 45 67 89', 9, 10, ''));

        // others
        System.assertEquals('', WordUtils.abbreviate('0123456790', 0,0,''));
        System.assertEquals('', WordUtils.abbreviate(' 0123456790', 0,-1,''));
    }

}