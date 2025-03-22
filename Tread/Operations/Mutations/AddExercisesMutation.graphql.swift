// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class AddExercisesMutation: GraphQLMutation {
    static let operationName: String = "AddExercises"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation AddExercises($addExercisesInput: AddExercisesInput) { addExercisesToWorkout(input: $addExercisesInput) { __typename title id } }"#
      ))

    public var addExercisesInput: GraphQLNullable<AddExercisesInput>

    public init(addExercisesInput: GraphQLNullable<AddExercisesInput>) {
      self.addExercisesInput = addExercisesInput
    }

    public var __variables: Variables? { ["addExercisesInput": addExercisesInput] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("addExercisesToWorkout", [AddExercisesToWorkout?]?.self, arguments: ["input": .variable("addExercisesInput")]),
      ] }

      var addExercisesToWorkout: [AddExercisesToWorkout?]? { __data["addExercisesToWorkout"] }

      /// AddExercisesToWorkout
      ///
      /// Parent Type: `Exercise`
      struct AddExercisesToWorkout: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.Exercise }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("title", String.self),
          .field("id", Tread.ID.self),
        ] }

        var title: String { __data["title"] }
        var id: Tread.ID { __data["id"] }
      }
    }
  }

}