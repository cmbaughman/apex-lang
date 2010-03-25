global abstract class ConditionGroup implements Condition{
    
    global List<Condition> conditions {get;private set;}
    
    private String separator {get;set;} 
    
    public ConditionGroup(String separator){
        this.separator = separator;
        this.conditions = new List<Condition>();
    }
    
    global Condition add(Condition c){
        if(c != null){
            this.conditions.add(c);
        }
        return this;
    }
    
    global String toSoql(){
        String soql = '';
        if(conditions.size() == 1){
            return conditions.get(0).toSoql();
        } else if(conditions.size() > 1){
            for(Integer i = 0; i < conditions.size(); i++){
                if(i <= 0){
                    soql = '(';
                } else {
                    soql += ' ' + separator + ' ';
                }
                soql += conditions.get(i).toSoql();
            }
            soql += ')';
        }
        return soql;
    }
    
}