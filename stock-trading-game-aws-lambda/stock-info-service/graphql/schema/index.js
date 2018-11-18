import {gql} from 'apollo-server-lambda';

const typeDefs = gql`
  type Stock {
    symbol: String!
    companyName: String!
  }

  type Query {
    hello: String
    stockInfo(symbol: String!): Stock
  }
`;

export {typeDefs};
