global class Field implements Soqlable{

    private String name;
    private Boolean toLabelx;
    
    global Field(String name){
        this.name = name;
        this.toLabelx = false;
    }

    global Field toLabelx(){
        this.toLabelx = true;
        return this;
    }

    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
    	return (toLabelx ? 'toLabel(' : '') + name + (toLabelx ? ')' : '');
    }
    
}