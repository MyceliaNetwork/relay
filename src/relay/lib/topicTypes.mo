import T "types";

module {
    public type Subscription = {
        principal : Principal;
        callback : T.NotifiableFunction;
    };

    public type PublishError = {
        #TopicNotFound;
        #NotAuthorized;
    };

    public type TopicState = {
        #DirectPublish : [Subscription];
        #Sharded : [T.NotifiableFunction];
    };

    public type Topic = {
        name : Text;
        owners : [Principal];
        isPublic : Bool;
    };
}