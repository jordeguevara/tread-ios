// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  struct AddExercisesInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      workoutID: GraphQLNullable<ID> = nil,
      exerciseIDs: [ID]
    ) {
      __data = InputDict([
        "workoutID": workoutID,
        "exerciseIDs": exerciseIDs
      ])
    }

    var workoutID: GraphQLNullable<ID> {
      get { __data["workoutID"] }
      set { __data["workoutID"] = newValue }
    }

    var exerciseIDs: [ID] {
      get { __data["exerciseIDs"] }
      set { __data["exerciseIDs"] = newValue }
    }
  }

}