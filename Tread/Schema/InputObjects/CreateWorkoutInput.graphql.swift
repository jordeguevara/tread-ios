// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  struct CreateWorkoutInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      name: String,
      userId: ID,
      percentageCompleted: GraphQLNullable<Double> = nil,
      userFeeling: GraphQLNullable<String> = nil,
      dateTimeWorkoutStart: GraphQLNullable<Time> = nil,
      dateTimeWorkoutEnd: GraphQLNullable<Time> = nil,
      createdAt: GraphQLNullable<Time> = nil,
      updatedAt: GraphQLNullable<Time> = nil,
      exercises: GraphQLNullable<[ExerciseInput]> = nil
    ) {
      __data = InputDict([
        "name": name,
        "userId": userId,
        "percentageCompleted": percentageCompleted,
        "userFeeling": userFeeling,
        "dateTimeWorkoutStart": dateTimeWorkoutStart,
        "dateTimeWorkoutEnd": dateTimeWorkoutEnd,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "exercises": exercises
      ])
    }

    var name: String {
      get { __data["name"] }
      set { __data["name"] = newValue }
    }

    var userId: ID {
      get { __data["userId"] }
      set { __data["userId"] = newValue }
    }

    var percentageCompleted: GraphQLNullable<Double> {
      get { __data["percentageCompleted"] }
      set { __data["percentageCompleted"] = newValue }
    }

    var userFeeling: GraphQLNullable<String> {
      get { __data["userFeeling"] }
      set { __data["userFeeling"] = newValue }
    }

    var dateTimeWorkoutStart: GraphQLNullable<Time> {
      get { __data["dateTimeWorkoutStart"] }
      set { __data["dateTimeWorkoutStart"] = newValue }
    }

    var dateTimeWorkoutEnd: GraphQLNullable<Time> {
      get { __data["dateTimeWorkoutEnd"] }
      set { __data["dateTimeWorkoutEnd"] = newValue }
    }

    var createdAt: GraphQLNullable<Time> {
      get { __data["createdAt"] }
      set { __data["createdAt"] = newValue }
    }

    var updatedAt: GraphQLNullable<Time> {
      get { __data["updatedAt"] }
      set { __data["updatedAt"] = newValue }
    }

    var exercises: GraphQLNullable<[ExerciseInput]> {
      get { __data["exercises"] }
      set { __data["exercises"] = newValue }
    }
  }

}