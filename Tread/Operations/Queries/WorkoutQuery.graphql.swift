// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class WorkoutQuery: GraphQLQuery {
    static let operationName: String = "Workout"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Workout($userID: ID!) { workouts(userId: $userID) { __typename name id } }"#
      ))

    public var userID: ID

    public init(userID: ID) {
      self.userID = userID
    }

    public var __variables: Variables? { ["userID": userID] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("workouts", [Workout?]?.self, arguments: ["userId": .variable("userID")]),
      ] }

      var workouts: [Workout?]? { __data["workouts"] }

      /// Workout
      ///
      /// Parent Type: `Workout`
      struct Workout: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.Workout }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
          .field("id", Tread.ID?.self),
        ] }

        var name: String? { __data["name"] }
        var id: Tread.ID? { __data["id"] }
      }
    }
  }

}