// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol Tread_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Tread.SchemaMetadata {}

protocol Tread_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Tread.SchemaMetadata {}

protocol Tread_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Tread.SchemaMetadata {}

protocol Tread_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Tread.SchemaMetadata {}

extension Tread {
  typealias ID = String

  typealias SelectionSet = Tread_SelectionSet

  typealias InlineFragment = Tread_InlineFragment

  typealias MutableSelectionSet = Tread_MutableSelectionSet

  typealias MutableInlineFragment = Tread_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Query": return Tread.Objects.Query
      case "WorkoutSpecifics": return Tread.Objects.WorkoutSpecifics
      case "ExerciseInfo": return Tread.Objects.ExerciseInfo
      case "SetInfo": return Tread.Objects.SetInfo
      case "Mutation": return Tread.Objects.Mutation
      case "Exercise": return Tread.Objects.Exercise
      case "Workout": return Tread.Objects.Workout
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}