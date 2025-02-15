// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class AddExerciseMutation: GraphQLMutation {
    static let operationName: String = "AddExercise"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation AddExercise($addExerciseInput: AddExerciseInput) { addExerciseToWorkout(input: $addExerciseInput) { __typename title } }"#
      ))

    public var addExerciseInput: GraphQLNullable<AddExerciseInput>

    public init(addExerciseInput: GraphQLNullable<AddExerciseInput>) {
      self.addExerciseInput = addExerciseInput
    }

    public var __variables: Variables? { ["addExerciseInput": addExerciseInput] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("addExerciseToWorkout", AddExerciseToWorkout?.self, arguments: ["input": .variable("addExerciseInput")]),
      ] }

      var addExerciseToWorkout: AddExerciseToWorkout? { __data["addExerciseToWorkout"] }

      /// AddExerciseToWorkout
      ///
      /// Parent Type: `Exercise`
      struct AddExerciseToWorkout: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.Exercise }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("title", String.self),
        ] }

        var title: String { __data["title"] }
      }
    }
  }

}