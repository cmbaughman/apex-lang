#Global Variables

##Description

**GlobalVariable** is a generalized String storage mechanism for setting org-wide variables in a custom setting.  
The class has a simple `get`/`put` interface. 
The storage uses a custom setting, so to use the put operation, the logged-in user must have the *Customize Application* user permission.

##Examples
```apex
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

#Foo__c

The Foo custom object provides a test fixture for the dynamic aspects of the library.  This allows these dynamic tests to be written without a concern of interference with customizations in a client org.

Many of the library test classes take advantage of this test object.
