//
//  SetDetail.swift
//  Tread
//
//  Created by Jorde Guevara on 2/10/25.
//

import ApolloAPI
import Foundation
import SwiftUI
import Tread

struct SetDetailView: View {
  @State var exercise: Exercise
  @FocusState private var focusedField: Int?
  var workoutID: String
  @State private var isSaving = false
  @State private var showSaveSuccess = false
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack {
      Text(exercise.name)
        .font(.largeTitle)
        .padding()
      List($exercise.sets.indices, id: \.self) { index in
        Text("Set \(index + 1)")
          .font(.headline)
          .padding(.bottom, 5)

        VStack(alignment: .leading) {
          HStack {
            VStack(alignment: .leading) {
              Text("Reps:")
              TextField(
                "Reps",
                text: Binding(
                  get: {
                    exercise.sets[index].reps == 0 ? "" : String(exercise.sets[index].reps)
                  },
                  set: {
                    let newValue = Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                    exercise.sets[index].reps = newValue
                  }
                )
              )
              .keyboardType(.numberPad)
              .onTapGesture {
                DispatchQueue.main.async {
                  if let textField = UIResponder.currentFirstResponder as? UITextField {
                    textField.selectAll(nil)
                  }
                }
              }
            }
            VStack(alignment: .leading) {
              Text("Weight:")
              TextField(
                "Weight",
                text: Binding(
                  get: {
                    exercise.sets[index].weight == 0 ? "" : String(exercise.sets[index].weight)
                  },
                  set: {
                    let newValue = Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                    exercise.sets[index].weight = newValue
                  }
                )
              )
              .keyboardType(.numberPad)
              .focused($focusedField, equals: index)
              .onTapGesture {
                DispatchQueue.main.async {
                  if let textField = UIResponder.currentFirstResponder as? UITextField {
                    textField.selectAll(nil)
                  }
                }
              }
            }
          }
        }
        .padding(.vertical, 5)
      }

      Button(action: {
        addSet()
      }) {
        Label("Add Set", systemImage: "plus.circle.fill")
          .font(.headline)
          .foregroundColor(.blue)
      }
      .padding()

      HStack {
        Button(action: {
          // Optionally add a confirmation dialog
          presentationMode.wrappedValue.dismiss()
        }) {
          Text("Cancel")
            .foregroundColor(.red)
        }
        .padding()

        Spacer()

        Button(action: {
          saveAndGoBack()
        }) {
          if isSaving {
            ProgressView()
          } else {
            Text("Save")
              .bold()
              .foregroundColor(.white)
          }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(8)
        .disabled(isSaving)
      }
      .padding()

    }
    .alert("Changes Saved", isPresented: $showSaveSuccess) {
      Button("OK") {
        presentationMode.wrappedValue.dismiss()
      }
    }

  }

  func addSet() {
    let lastSet = exercise.sets.last
    let newSet = Set(
      id: UUID().uuidString,
      reps: lastSet?.reps ?? 0,
      weight: lastSet?.weight ?? 0
    )
    exercise.sets.append(newSet)
    focusedField = exercise.sets.count - 1
  }

  // func addSetsToWorkout() {
  //     let setsInput = Tread.SetsInput(
  //         exerciseID: .some(exercise.id),  // Wrap String in GraphQLNullable
  //         workoutID: .some(workoutID),     // Wrap String in GraphQLNullable
  //         sets: exercise.sets.map { set in
  //             Tread.SetInput(
  //                 numberOfReps: set.reps,
  //                 restsInSeconds: nil,
  //                 weight: .some(set.weight)  // Wrap Int in GraphQLNullable if needed
  //             )
  //         }
  //     )

  //     let mutation = Tread.AddSetsMutation(input: setsInput)

  //     apolloClient.perform(mutation: mutation) { result in
  //         switch result {
  //         case .success(let graphQLResult):
  //             if let sets = graphQLResult.data?.addSets {
  //                 print("Successfully added sets: \(sets)")
  //             } else if let errors = graphQLResult.errors {
  //                 print("GraphQL errors: \(errors)")
  //             }
  //         case .failure(let error):
  //             print("Network error: \(error)")
  //         }
  //     }
  // }
  // Find the saveAndGoBack() function and update it:

    func saveAndGoBack() {
      isSaving = true

      let setsInput = Tread.SetsInput(
        exerciseID: .some(exercise.id),
        workoutID: .some(workoutID),
        sets: exercise.sets.map { set in
          // For sets with UUID-formatted IDs (new sets created on client),
          // don't send the ID so backend can generate one
          let isNewSet = UUID(uuidString: set.id) != nil
          
          // If the SetInput type has an id field, use it for existing sets
          return Tread.SetInput(
            id: isNewSet ? nil : .some(set.id),  // Only include ID for existing sets
            numberOfReps: set.reps,
            restsInSeconds: nil,
            weight: .some(set.weight)
          )
        }
      )

      let mutation = Tread.AddSetsMutation(input: setsInput)

      apolloClient.perform(mutation: mutation) { result in
        DispatchQueue.main.async {
          isSaving = false
          switch result {
          case .success(let graphQLResult):
            if let addedSets = graphQLResult.data?.addSets {
              print("Successfully saved \(addedSets.count) sets")
              
              // Update local set IDs with server-generated IDs if needed
              if !addedSets.isEmpty {
                updateExerciseSets(with: addedSets)
              }
              
              showSaveSuccess = true
              // Post notification with workout ID
              NotificationCenter.default.post(
                name: NSNotification.Name("WorkoutDataChanged"),
                object: nil,
                userInfo: ["workoutID": workoutID]
              )
            } else if let errors = graphQLResult.errors {
              print("GraphQL errors: \(errors)")
            }
          case .failure(let error):
            print("Network error: \(error)")
          }
        }
      }
    }
    private func updateExerciseSets(with serverSets: [Tread.AddSetsMutation.Data.AddSet]) {
      // Update local exercise sets with server-generated IDs
      // This is especially important for newly created sets
      if serverSets.count == exercise.sets.count {
        // Straightforward case - same number of sets
        for i in 0..<serverSets.count {
          exercise.sets[i].id = serverSets[i].id
        }
      } else {
        // Handle case where counts don't match by doing best-effort matching
        // This might happen if there are partial updates
        print("Warning: Server returned different number of sets than expected")
      }
    }
}

extension UIResponder {
  private static weak var _currentFirstResponder: UIResponder?

  static var currentFirstResponder: UIResponder? {
    _currentFirstResponder = nil
    UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
    return _currentFirstResponder
  }

  @objc private func findFirstResponder(_ sender: Any) {
    UIResponder._currentFirstResponder = self
  }
}

struct SetDetailView_Previews: PreviewProvider {
  static var previews: some View {
    SetDetailView(
      exercise: Exercise(
        id: "1", name: "Sample Exercise", sets: [Set(id: "1", reps: 10, weight: 50)]),
      workoutID: "workout123"  // Pass a sample WorkoutID here
    )
  }
}
