import {hello} from "./hello";
import {stockInfo} from "./stockInfo";

export const resolvers = {
    Query: {
        hello,
        stockInfo,
    },
};
