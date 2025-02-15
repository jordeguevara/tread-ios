// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  /// Directs the executor to defer this fragment when the `if` argument is true or undefined.
  struct AddExerciseInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      workoutID: GraphQLNullable<ID> = nil,
      exerciseID: ID
    ) {
      __data = InputDict([
        "workoutID": workoutID,
        "exerciseID": exerciseID
      ])
    }

    var workoutID: GraphQLNullable<ID> {
      get { __data["workoutID"] }
      set { __data["workoutID"] = newValue }
    }

    var exerciseID: ID {
      get { __data["exerciseID"] }
      set { __data["exerciseID"] = newValue }
    }
  }

}