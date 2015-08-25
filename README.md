# apex-lang

A collection of convinience utility classes and others to make developing in Salesforce easier and more fun! apex-lang is an open-source library of helper classes written purely in apex whose goal is to address shortcomings in the core apex classes. (If you're not familiar with apex, apex is the programming language provided by salesforce.com's development platform and is essentially a trimmed down version of java with added syntax for exploiting the force.com platform.)

apex-lang was inspired by the Apache Commons Lang (http://commons.apache.org/lang/) project whose creators had a similar goal of addressing gaps in java's core API. Apex is fairly feature rich; however, let's face it, functionality in its core API is sorely lacking. And why shouldn't it? salesforce.com is in the "on-demand platform" business, not the API building business. On the other hand, apex-lang is very much in the API building (not for profit) business. So, its the intent of apex-lang to fill in the gaps in the core apex classes. And to fill them more quickly than salesforce can. Salesforce only has 3-4 releases a year; in contrast, apex-lang can be released as many times as needed during a single year.

This project was forked from the now defunct Google Code https://code.google.com/p/apex-lang/ and has not been updated since 2012. I plan on maintaining for as long as I can and making adjustments, changes, and adding functionality where possible, and where it makes sense.

Original Authors:
	Richard.Vanhook (Salesforce)
	Bluewolf Group
	ggladkivska
  djime...@iofficecorp.com
  edistein.zhang
  jdietz
  okarzan

Originally donated by EDL Consulting.

List of Classes:
---------------

- AndCondition.cls
- AndConditionTest.cls
- ArrayUtils.cls
- ArrayUtilsTest.cls
- BooleanUtils.cls
- BooleanUtilsTest.cls
- Character.cls
- CharacterTest.cls
- Condition.cls
- ConditionGroup.cls
- ConditionGroupTest.cls
- DatabaseUtils.cls
- DatabaseUtilsTest.cls
- DateFormula.cls
- DateFormulaTest.cls
- DecimalRange.cls
- DecimalRangeComparator.cls
- DecimalRangeComparatorTest.cls
- DecimalRangeTest.cls
- DoubleRange.cls
- DoubleRangeTest.cls
- EmailUtils.cls
- EmailUtilsTest.cls
- Field.cls
- FieldCondition.cls
- FieldConditionTest.cls
- FieldTest.cls
- GlobalVariable.cls
- GlobalVariableTest.cls
- HttpUtils.cls
- HttpUtilsTest.cls
- ISObjectComparator.cls
- IllegalArgumentException.cls
- IllegalStateException.cls
- IndexOutOfBoundsException.cls
- IntegerRange.cls
- IntegerRangeTest.cls
- InvalidCharacterStringException.cls
- JSONUtils.cls
- JSONUtilsTest.cls
- LanguageUtils.cls
- LanguageUtilsTest.cls
- LongRange.cls
- LongRangeTest.cls
- MapUtils.cls
- MapUtilsTest.cls
- NestableCondition.cls
- NotCondition.cls
- NotConditionTest.cls
- NumberFormatException.cls
- NumberUtils.cls
- NumberUtilsTest.cls
- ObjectComparator.cls
- ObjectPaginator.cls
- ObjectPaginatorListener.cls
- ObjectPaginatorListenerForTesting.cls
- ObjectPaginatorTest.cls
- Operator.cls
- OrCondition.cls
- OrConditionTest.cls
- OrderBy.cls
- OrderByTest.cls
- PageUtils.cls
- PageUtilsTest.cls
- PrimitiveComparator.cls
- PrimitiveComparatorTest.cls
- RandomStringUtils.cls
- RandomStringUtilsTest.cls
- RandomUtils.cls
- RandomUtilsTest.cls
- SObjectComparator.cls
- SObjectPaginator.cls
- SObjectPaginatorListener.cls
- SObjectPaginatorListenerForTesting.cls
- SObjectPaginatorTest.cls
- SObjectSortByFieldComparator.cls
- SObjectSortByFieldComparatorTest.cls
- SObjectSortByNameComparator.cls
- SObjectSortByNameComparatorTest.cls
- SObjectUtils.cls
- SObjectUtilsTest.cls
- SelectOptionComparator.cls
- SelectOptionComparatorTest.cls
- SelectOptionWrapper.cls
- SetCondition.cls
- SetConditionTest.cls
- SetUtils.cls
- SetUtilsTest.cls
- SoqlBuilder.cls
- SoqlBuilderTest.cls
- SoqlOptions.cls
- SoqlOptionsTest.cls
- SoqlUtils.cls
- SoqlUtilsTest.cls
- Soqlable.cls
- StickyParametersController.cls
- StickyParametersControllerTest.cls
- StopWatch.cls
- StopWatchTest.cls
- StringBuffer.cls
- StringBufferTest.cls
- StringUtils.cls
- StringUtils2Test.cls
- StringUtilsTest.cls
- SystemUtils.cls
- SystemUtilsTest.cls
- TestUtils.cls
- TestUtilsTest.cls
- TouchRecords.cls
- UnitOfTime.cls
- UrlUtils.cls
- UrlUtilsTest.cls
- UserUtils.cls
- UserUtilsTest.cls
- WordUtils.cls
- WordUtilsTest.cls
