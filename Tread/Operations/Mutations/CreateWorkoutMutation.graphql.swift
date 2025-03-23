// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class CreateWorkoutMutation: GraphQLMutation {
    static let operationName: String = "createWorkout"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation createWorkout($createWorkoutInput: CreateWorkoutInput!) { createWorkout(input: $createWorkoutInput) { __typename name id } }"#
      ))

    public var createWorkoutInput: CreateWorkoutInput

    public init(createWorkoutInput: CreateWorkoutInput) {
      self.createWorkoutInput = createWorkoutInput
    }

    public var __variables: Variables? { ["createWorkoutInput": createWorkoutInput] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("createWorkout", CreateWorkout?.self, arguments: ["input": .variable("createWorkoutInput")]),
      ] }

      var createWorkout: CreateWorkout? { __data["createWorkout"] }

      /// CreateWorkout
      ///
      /// Parent Type: `Workout`
      struct CreateWorkout: Tread.SelectionSet {
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