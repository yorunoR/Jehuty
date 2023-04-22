/* eslint-disable */
import type { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /**
   * The `DateTime` scalar type represents a date and time in the UTC
   * timezone. The DateTime appears in a JSON response as an ISO8601 formatted
   * string, including UTC timezone ("Z"). The parsed date and time string will
   * be converted to UTC if there is an offset.
   */
  DateTime: string;
};

export type Answer = {
  __typename?: 'Answer';
  answer?: Maybe<Scalars['String']>;
};

export type History = {
  __typename?: 'History';
  answer: Scalars['String'];
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  question: Scalars['String'];
  updatedAt: Scalars['DateTime'];
};

export type InputHistory = {
  answer: Scalars['String'];
  question: Scalars['String'];
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  saveHistory: History;
  sendQuestion: Answer;
  signinUser?: Maybe<User>;
};


export type RootMutationTypeSaveHistoryArgs = {
  history: InputHistory;
};


export type RootMutationTypeSendQuestionArgs = {
  question: Scalars['String'];
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  currentUser: User;
  ping: Status;
};

export type RootSubscriptionType = {
  __typename?: 'RootSubscriptionType';
  newUser: User;
};

export type Status = {
  __typename?: 'Status';
  status?: Maybe<Scalars['Boolean']>;
};

export type User = {
  __typename?: 'User';
  activated: Scalars['Boolean'];
  email: Scalars['String'];
  histories: Array<History>;
  id: Scalars['ID'];
  insertedAt: Scalars['DateTime'];
  name: Scalars['String'];
  profileImage?: Maybe<Scalars['String']>;
  role: Scalars['Int'];
  uid?: Maybe<Scalars['String']>;
  updatedAt: Scalars['DateTime'];
};

export type SaveHistoryMutationVariables = Exact<{
  history: InputHistory;
}>;


export type SaveHistoryMutation = { __typename?: 'RootMutationType', saveHistory: { __typename?: 'History', id: string } };

export type SendQuestionMutationVariables = Exact<{
  question: Scalars['String'];
}>;


export type SendQuestionMutation = { __typename?: 'RootMutationType', sendQuestion: { __typename?: 'Answer', answer?: string | null } };

export type SigninUserMutationVariables = Exact<{ [key: string]: never; }>;


export type SigninUserMutation = { __typename?: 'RootMutationType', signinUser?: { __typename?: 'User', uid?: string | null } | null };

export type CurrentUserQueryVariables = Exact<{ [key: string]: never; }>;


export type CurrentUserQuery = { __typename?: 'RootQueryType', currentUser: { __typename?: 'User', id: string, name: string, email: string, histories: Array<{ __typename?: 'History', id: string, question: string, answer: string, insertedAt: string }> } };

export type PingQueryVariables = Exact<{ [key: string]: never; }>;


export type PingQuery = { __typename?: 'RootQueryType', ping: { __typename?: 'Status', status?: boolean | null } };

export type NewUserSubscriptionVariables = Exact<{ [key: string]: never; }>;


export type NewUserSubscription = { __typename?: 'RootSubscriptionType', newUser: { __typename?: 'User', id: string, name: string } };


export const SaveHistoryDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"SaveHistory"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"history"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"InputHistory"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"saveHistory"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"history"},"value":{"kind":"Variable","name":{"kind":"Name","value":"history"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}}]}}]}}]} as unknown as DocumentNode<SaveHistoryMutation, SaveHistoryMutationVariables>;
export const SendQuestionDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"SendQuestion"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"question"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"sendQuestion"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"question"},"value":{"kind":"Variable","name":{"kind":"Name","value":"question"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"answer"}}]}}]}}]} as unknown as DocumentNode<SendQuestionMutation, SendQuestionMutationVariables>;
export const SigninUserDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"mutation","name":{"kind":"Name","value":"SigninUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"signinUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"uid"}}]}}]}}]} as unknown as DocumentNode<SigninUserMutation, SigninUserMutationVariables>;
export const CurrentUserDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"CurrentUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"currentUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"email"}},{"kind":"Field","name":{"kind":"Name","value":"histories"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"question"}},{"kind":"Field","name":{"kind":"Name","value":"answer"}},{"kind":"Field","name":{"kind":"Name","value":"insertedAt"}}]}}]}}]}}]} as unknown as DocumentNode<CurrentUserQuery, CurrentUserQueryVariables>;
export const PingDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"Ping"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"ping"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"status"}}]}}]}}]} as unknown as DocumentNode<PingQuery, PingQueryVariables>;
export const NewUserDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"subscription","name":{"kind":"Name","value":"NewUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"newUser"},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"id"}},{"kind":"Field","name":{"kind":"Name","value":"name"}}]}}]}}]} as unknown as DocumentNode<NewUserSubscription, NewUserSubscriptionVariables>;