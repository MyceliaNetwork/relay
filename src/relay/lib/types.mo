module {
    public type NotifiableFunction = shared (Value) -> async Value;

    public type Value = {
        #Nat : Nat;
        #Int : Int;
        #Float : Float;

        #Text : Text;
        #Bool : Bool;

        #Blob : Blob;

        #Principal  : Principal;

        #Object : [(Text, Value)];
        #Array : [Value];

        #Optional : ?Value;

        #Call : NotifiableFunction;
    };

    public type P = (Expression, Expression);

    // Statements produce side effects
    public type Statement = {

    };

    // Expressions produce values
    public type Expression = {
        #Or : P;
        #And : P;
        #Equal : {Not : P; Is : P;};
        #Comp : {
            #Gt : P;
            #Gte : P;
            #Lt : P;
            #Lte : P;
        };
        #Term : {#Add : P; #Subtract : P};
        #Factor : {#Multiply : P; #Divide : P};
        #Unary : {#Bang : Expression; #Minus : Expression};
    };
}