// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension Tread {
  class WorkoutSpecificsQuery: GraphQLQuery {
    static let operationName: String = "WorkoutSpecifics"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query WorkoutSpecifics($workoutID: ID!) { workout(id: $workoutID) { __typename id name exercises { __typename id name } sets { __typename id exerciseID numOfReps weight } } }"#
      ))

    public var workoutID: ID

    public init(workoutID: ID) {
      self.workoutID = workoutID
    }

    public var __variables: Variables? { ["workoutID": workoutID] }

    struct Data: Tread.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { Tread.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("workout", Workout?.self, arguments: ["id": .variable("workoutID")]),
      ] }

      var workout: Workout? { __data["workout"] }

      /// Workout
      ///
      /// Parent Type: `WorkoutSpecifics`
      struct Workout: Tread.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { Tread.Objects.WorkoutSpecifics }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Tread.ID?.self),
          .field("name", String?.self),
          .field("exercises", [Exercise?]?.self),
          .field("sets", [Set?]?.self),
        ] }

        var id: Tread.ID? { __data["id"] }
        var name: String? { __data["name"] }
        var exercises: [Exercise?]? { __data["exercises"] }
        var sets: [Set?]? { __data["sets"] }

        /// Workout.Exercise
        ///
        /// Parent Type: `ExerciseInfo`
        struct Exercise: Tread.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { Tread.Objects.ExerciseInfo }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Tread.ID?.self),
            .field("name", String?.self),
          ] }

          var id: Tread.ID? { __data["id"] }
          var name: String? { __data["name"] }
        }

        /// Workout.Set
        ///
        /// Parent Type: `SetInfo`
        struct Set: Tread.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { Tread.Objects.SetInfo }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Tread.ID?.self),
            .field("exerciseID", Tread.ID?.self),
            .field("numOfReps", Int?.self),
            .field("weight", Int?.self),
          ] }

          var id: Tread.ID? { __data["id"] }
          var exerciseID: Tread.ID? { __data["exerciseID"] }
          var numOfReps: Int? { __data["numOfReps"] }
          var weight: Int? { __data["weight"] }
        }
      }
    }
  }

}