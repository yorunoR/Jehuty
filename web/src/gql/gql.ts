/* eslint-disable */
import * as types from './graphql';
import type { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';

/**
 * Map of all GraphQL operations in the project.
 *
 * This map has several performance disadvantages:
 * 1. It is not tree-shakeable, so it will include all operations in the project.
 * 2. It is not minifiable, so the string of a GraphQL query will be multiple times inside the bundle.
 * 3. It does not support dead code elimination, so it will add unused operations.
 *
 * Therefore it is highly recommended to use the babel or swc plugin for production.
 */
const documents = {
    "\n  mutation ParseHtml($url: String!, $selector: String!) {\n    parseHtml(url: $url, selector: $selector) {\n      document\n    }\n  }\n": types.ParseHtmlDocument,
    "\n  mutation SaveDocument($url: String!, $document: String!) {\n    saveDocument(url: $url, document: $document) {\n      id\n    }\n  }\n": types.SaveDocumentDocument,
    "\n  mutation SaveHistory($history: InputHistory!) {\n    saveHistory(history: $history) {\n      id\n    }\n  }\n": types.SaveHistoryDocument,
    "\n  mutation SearchDocument($question: String!, $storyId: ID!) {\n    searchDocument(question: $question, storyId: $storyId) {\n      answer\n    }\n  }\n": types.SearchDocumentDocument,
    "\n  mutation SendQuestion($question: String!) {\n    sendQuestion(question: $question) {\n      answer\n    }\n  }\n": types.SendQuestionDocument,
    "\n  mutation SigninUser {\n    signinUser {\n      uid\n    }\n  }\n": types.SigninUserDocument,
    "\n  query Ping {\n    ping {\n      status\n    }\n  }\n": types.PingDocument,
    "\n  query UserHistories {\n    currentUser {\n      id\n      name\n      email\n      histories {\n        id\n        question\n        answer\n        insertedAt\n      }\n    }\n  }\n": types.UserHistoriesDocument,
    "\n  query UserStories {\n    currentUser {\n      id\n      name\n      email\n      stories {\n        id\n        status\n        title\n        chunkSize\n        insertedAt\n      }\n    }\n  }\n": types.UserStoriesDocument,
    "\n  subscription NewUser {\n    newUser {\n      id\n      name\n    }\n  }\n": types.NewUserDocument,
};

/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 *
 *
 * @example
 * ```ts
 * const query = graphql(`query GetUser($id: ID!) { user(id: $id) { name } }`);
 * ```
 *
 * The query argument is unknown!
 * Please regenerate the types.
 */
export function graphql(source: string): unknown;

/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation ParseHtml($url: String!, $selector: String!) {\n    parseHtml(url: $url, selector: $selector) {\n      document\n    }\n  }\n"): (typeof documents)["\n  mutation ParseHtml($url: String!, $selector: String!) {\n    parseHtml(url: $url, selector: $selector) {\n      document\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SaveDocument($url: String!, $document: String!) {\n    saveDocument(url: $url, document: $document) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation SaveDocument($url: String!, $document: String!) {\n    saveDocument(url: $url, document: $document) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SaveHistory($history: InputHistory!) {\n    saveHistory(history: $history) {\n      id\n    }\n  }\n"): (typeof documents)["\n  mutation SaveHistory($history: InputHistory!) {\n    saveHistory(history: $history) {\n      id\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SearchDocument($question: String!, $storyId: ID!) {\n    searchDocument(question: $question, storyId: $storyId) {\n      answer\n    }\n  }\n"): (typeof documents)["\n  mutation SearchDocument($question: String!, $storyId: ID!) {\n    searchDocument(question: $question, storyId: $storyId) {\n      answer\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SendQuestion($question: String!) {\n    sendQuestion(question: $question) {\n      answer\n    }\n  }\n"): (typeof documents)["\n  mutation SendQuestion($question: String!) {\n    sendQuestion(question: $question) {\n      answer\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  mutation SigninUser {\n    signinUser {\n      uid\n    }\n  }\n"): (typeof documents)["\n  mutation SigninUser {\n    signinUser {\n      uid\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query Ping {\n    ping {\n      status\n    }\n  }\n"): (typeof documents)["\n  query Ping {\n    ping {\n      status\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query UserHistories {\n    currentUser {\n      id\n      name\n      email\n      histories {\n        id\n        question\n        answer\n        insertedAt\n      }\n    }\n  }\n"): (typeof documents)["\n  query UserHistories {\n    currentUser {\n      id\n      name\n      email\n      histories {\n        id\n        question\n        answer\n        insertedAt\n      }\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  query UserStories {\n    currentUser {\n      id\n      name\n      email\n      stories {\n        id\n        status\n        title\n        chunkSize\n        insertedAt\n      }\n    }\n  }\n"): (typeof documents)["\n  query UserStories {\n    currentUser {\n      id\n      name\n      email\n      stories {\n        id\n        status\n        title\n        chunkSize\n        insertedAt\n      }\n    }\n  }\n"];
/**
 * The graphql function is used to parse GraphQL queries into a document that can be used by GraphQL clients.
 */
export function graphql(source: "\n  subscription NewUser {\n    newUser {\n      id\n      name\n    }\n  }\n"): (typeof documents)["\n  subscription NewUser {\n    newUser {\n      id\n      name\n    }\n  }\n"];

export function graphql(source: string) {
  return (documents as any)[source] ?? {};
}

export type DocumentType<TDocumentNode extends DocumentNode<any, any>> = TDocumentNode extends DocumentNode<  infer TType,  any>  ? TType  : never;