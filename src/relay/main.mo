import T "/lib/types";
import Node "/node/main";

// Hub
actor {
    
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };
};
