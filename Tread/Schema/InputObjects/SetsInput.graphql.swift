// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  struct SetsInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      exerciseID: GraphQLNullable<ID> = nil,
      workoutID: GraphQLNullable<ID> = nil,
      sets: [SetInput]
    ) {
      __data = InputDict([
        "exerciseID": exerciseID,
        "WorkoutID": workoutID,
        "sets": sets
      ])
    }

    var exerciseID: GraphQLNullable<ID> {
      get { __data["exerciseID"] }
      set { __data["exerciseID"] = newValue }
    }

    var workoutID: GraphQLNullable<ID> {
      get { __data["WorkoutID"] }
      set { __data["WorkoutID"] = newValue }
    }

    var sets: [SetInput] {
      get { __data["sets"] }
      set { __data["sets"] = newValue }
    }
  }

}