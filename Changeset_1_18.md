# apex-lang 1.18 released #

Version 1.18 of the apex-lang library is a maintenance release.  It's mostly under-the-hood improvements, with one major new feature.

## Links for apex-lang version 1.18 ##

  * [Install Managed Package (Production)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t80000000jN1q)
  * [Install Unmanaged Package (Production)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t80000000jN1v)
  * [Install Managed Package (Sandbox)](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t80000000jN1q)
  * [Install Unmanaged Package (Sandbox)](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t80000000jN1v)
  * [Download the source](http://apex-lang.googlecode.com/files/apex-lang-1.18.zip)
  * [Browse the code](http://code.google.com/p/apex-lang/source/browse/#svn/tags/1.18/src/classes)

## Changes since 1.17 ##

### `GlobalVariable` ###

Introduces a generalized String storage mechanism for setting org-wide variables in a custom setting.  The class has a simple `get`/`put` interface.  The storage uses a custom setting, so to use the put operation, the logged-in user must have the `"Customize Application"` user permission.

Note that this is a low-level utility: it performs no caching or synchronization.

```
final String GLOBAL_KEY = 'MyApplicationVariable';
final String GLOBAL_VALUE = 'Some important string';

GlobalVariable.put( GLOBAL_KEY, GLOBAL_VALUE );

final String systemValue = GlobalVariable.get( GLOBAL_KEY );
System.assertEquals( GLOBAL_VALUE, systemValue );

final String priorValue = GlobalVariable.put( GLOBAL_KEY, 'A new value' );
final String newValue = GlobalVariable.get( GLOBAL_KEY );

System.assertEquals( GLOBAL_VALUE, priorValue );
System.assertNotEquals( GLOBAL_VALUE, newValue );
```

### `Foo__c` ###

The Foo custom object provides a test fixture for the dynamic aspects of the library.  This allows these dynamic tests to be written without a concern of interference with customizations in a client org.

Many of the library test classes were updated to take advantage of this test object.

### `SoqlBuilder` Bug Fixes ###

  * The order of parentheses on `NotCondition`s has been corrected to produce proper SOQL.
  * Newlines are no longer inserted into the generated queries to support the use of `Database.getQueryLocator()`.  Use `SoqlOptions.breakLinesBetweenClauses()` for the previous behavior, e.g., for debugging generated SOQL.