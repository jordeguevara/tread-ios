// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class AddSetsMutation: GraphQLMutation {
    static let operationName: String = "AddSets"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation AddSets($input: SetsInput!) { addSets(input: $input) { __typename id numberOfReps weight workoutExerciseID } }"#
      ))

    public var input: SetsInput

    public init(input: SetsInput) {
      self.input = input
    }

    public var __variables: Variables? { ["input": input] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("addSets", [AddSet].self, arguments: ["input": .variable("input")]),
      ] }

      var addSets: [AddSet] { __data["addSets"] }

      /// AddSet
      ///
      /// Parent Type: `Set`
      struct AddSet: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.Set }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Tread.ID.self),
          .field("numberOfReps", Int.self),
          .field("weight", Int?.self),
          .field("workoutExerciseID", Tread.ID.self),
        ] }

        var id: Tread.ID { __data["id"] }
        var numberOfReps: Int { __data["numberOfReps"] }
        var weight: Int? { __data["weight"] }
        var workoutExerciseID: Tread.ID { __data["workoutExerciseID"] }
      }
    }
  }

}