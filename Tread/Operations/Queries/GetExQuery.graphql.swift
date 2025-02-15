// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class GetExQuery: GraphQLQuery {
    static let operationName: String = "getEx"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query getEx { getExercises { __typename id title } }"#
      ))

    public init() {}

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getExercises", [GetExercise?]?.self),
      ] }

      var getExercises: [GetExercise?]? { __data["getExercises"] }

      /// GetExercise
      ///
      /// Parent Type: `Exercise`
      struct GetExercise: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.Exercise }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Tread.ID.self),
          .field("title", String.self),
        ] }

        var id: Tread.ID { __data["id"] }
        var title: String { __data["title"] }
      }
    }
  }

}