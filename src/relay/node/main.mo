import Result "mo:base/Result";
import T "../lib/types";
import TopicTypes "../lib/topicTypes";

import Trie "mo:base/Trie";

shared actor class Node() = this {
    stable var topics : Trie.Trie<Text, Text> = Trie.empty();

    public shared func publish(topicName : Text, value : T.Value) : async Result.Result<(), TopicTypes.PublishError> {
        #ok();
    };

    let B = 1_000_000_000;

    var XNET_COST_PER_BYTE = 1_000;
    var CALL_COST = 260_000;
    var MAX_PER_MESSAGE = 5 * B;

    private func callsPerIteration(payloadCost : Nat ) : Nat {
        var oneCall = payloadCost + CALL_COST;
        return MAX_PER_MESSAGE / 4 / oneCall; // Use 1/4 of our cycles per round to emit messages
    };

    private func payloadCost(size : Nat) : Nat {
        return XNET_COST_PER_BYTE * size;
    };

    // Value in Bytes;
    private func sizeOf(value : T.Value) : Nat {
        var size = 0;

        switch (value) {
            case (#Array(v)) {
                for (x in v.vals()) {
                    size += sizeOf(x);
                };
            };
            case (#Blob(v)) {
                size += v.size();
            };
            case (#Text(v)) {
                size += (v.size() * 4)
            };
            case (#Bool(_)) {
                size += 1;
            };
            case (#Call(_)) {
                size += 30;
            };
            case (#Float(v)) {
                size += 16; // This is incorrec
            };
            case (#Nat(v)) {
                size += 16; // This is incorrect
            };
            case (#Int(v)) {
                size += 16; // This is incorrect
            };
            case (#Optional(v)) {
                switch(v) {
                    case null {};
                    case (?v1) {size += sizeOf(v1)};
                };
            };
            case (#Object(v)) {
                for ((key, value) in v.vals()) {
                    size += sizeOf(#Text(key));
                    size += sizeOf(value);
                };
            };
            case (#Principal(v)) {
                size += 29;
            };
        };

        return size;
    };
};