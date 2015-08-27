#SoqlBuilder

##Examples

```apex
new SoqlBuilder()
  .selectx('name')
  .fromx('Opportunity')
  .wherex(new FieldCondition('employees').lessThan(10))
  .toSoql();
```
