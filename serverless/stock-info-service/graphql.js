require('dotenv').config();
import { ApolloServer, gql } from 'apollo-server-lambda';
import {hello} from './graphql/resolvers/hello';

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
  type Query {
    hello: String
  }
`;

// Provide resolver functions for your schema fields
const resolvers = {
    Query: {
        hello,
    },
};

const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: ({ event, context }) => ({
        headers: event.headers,
        functionName: context.functionName,
        event,
        context,
    }),
    playground: {
        settings: {
            'general.betaUpdates': false,
            'editor.cursorShape': 'line', // possible values: 'line', 'block', 'underline'
            'editor.fontSize': 16,
            'editor.fontFamily': `'Source Code Pro', 'Consolas', 'Inconsolata', 'Droid Sans Mono', 'Monaco', monospace`,
            'editor.theme': 'light', // possible values: 'dark', 'light'
            'editor.reuseHeaders': true,
            'request.credentials': 'omit', // possible values: 'omit', 'include', 'same-origin'
            'tracing.hideTracingResponse': true,
        },
    },
    cors: {
        origin: true,
        credentials: true,
    },
});

const handler = server.createHandler();

export {handler};