import Apollo
import SwiftUI

struct ExerciseModal: Hashable, Identifiable {
  var id: String
  var title: String
}

struct ExerciseModalView: View {
  @Binding var showModal: Bool
  var addExercise: (ExerciseModal) -> Void
  var existingExercises: [ExerciseModal]
  @Binding var workoutId: String?
  @State private var availableExercises: [ExerciseModal] = []
  @State private var selectedExercises: [ExerciseModal] = []
  @State private var fetchError: String?

  var body: some View {
    NavigationView {
      VStack {
        if let errorMessage = fetchError {
          Text("Error: \(errorMessage)")
            .foregroundColor(.red)
            .padding(.bottom, 8)
        }

        List(availableExercises) { exercise in
          ExerciseRow(
            exercise: exercise,
            isSelected: selectedExercises.contains(where: { $0.id == exercise.id })
          )
          .onTapGesture {
            toggleSelection(exercise)
          }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Add Exercises", displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Dismiss") {
              showModal = false
              selectedExercises.removeAll()
            }
          }

          ToolbarItem(placement: .confirmationAction) {
            Button("Add (\(selectedExercises.count))") {
              let ids = selectedExercises.map { $0.id }
              addExercises(ids)
              // selectedExercises.forEach(addExercise)
              showModal = false
              selectedExercises.removeAll()
            }
          }
        }
      }
    }
    .onAppear {
      loadExercises()
    }
  }

  func loadExercises() {
    let query = Tread.GetExQuery()
    print("Starting fetch with query: \(query)")

    apolloClient.fetch(query: query) { result in
      //            print("Received result: \(result)")
      switch result {
      case .success(let graphQLResult):
        // print("GraphQL Data: \(String(describing: graphQLResult.data))")

        if let exercisesData = graphQLResult.data?.getExercises?.compactMap({ $0 }) {
          let existingIds = existingExercises.map { $0.id }
          let filtered = exercisesData.filter { !existingIds.contains($0.id) }

          DispatchQueue.main.async {
            self.availableExercises = filtered.map {
              ExerciseModal(id: $0.id, title: $0.title)
            }
            print("Available exercises updated: \(self.availableExercises)")
          }
        } else if let errors = graphQLResult.errors {
          let err = errors.map { $0.localizedDescription }.joined(separator: "\n")
          print("GraphQL errors: \(err)")
          DispatchQueue.main.async {
            self.fetchError = err
          }
        }

      case .failure(let error):
        print("Fetch failed with error: \(error)")
        DispatchQueue.main.async {
          self.fetchError = error.localizedDescription
        }
      }
    }
  }

  func toggleSelection(_ exercise: ExerciseModal) {
    if let index = selectedExercises.firstIndex(where: { $0.id == exercise.id }) {
      selectedExercises.remove(at: index)
    } else {
      selectedExercises.append(exercise)
    }
  }

  func addExercises(_ exerciseIds: [String]) {
    if let workoutId = workoutId, !workoutId.isEmpty {
      // Existing workout - add exercises directly
      addExercisesToWorkout(workoutId: workoutId, exerciseIds: exerciseIds)
    } else {
      // No workout ID - create a new workout first
      createWorkoutAndAddExercises(exerciseIds: exerciseIds)
    }
  }

  private func createWorkoutAndAddExercises(exerciseIds: [String]) {
    // Default name for new workout

    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"  // Format: "Monday, Mar 23, 2025 at 2:30 PM"
    let formattedDate = dateFormatter.string(from: currentDate)
    let workoutName = "Workout - \(formattedDate)"

    // Hard code user ID as requested
    let hardcodedUserId = "34359738368"  // Replace with an actual valid user ID from your system

    // Map exercise IDs to ExerciseInput objects
    let exerciseInputs = exerciseIds.map { exerciseId -> Tread.ExerciseInput in
      // Just pass the actual exerciseId instead of nil
      return Tread.ExerciseInput(id: exerciseId, name: nil)
    }

    let input = Tread.CreateWorkoutInput(
      name: workoutName,
      userId: hardcodedUserId,
      percentageCompleted: nil,
      userFeeling: nil,
      dateTimeWorkoutStart: nil,
      dateTimeWorkoutEnd: nil,
      createdAt: nil,
      updatedAt: nil,
      exercises: .some(exerciseInputs)
    )

    // Use correct parameter name 'createWorkoutInput' to match your GraphQL schema
    let mutation = Tread.CreateWorkoutMutation(createWorkoutInput: input)

    apolloClient.perform(mutation: mutation) { [self] result in

      DispatchQueue.main.async {
        switch result {
        case .success(let graphQLResult):
          if let errors = graphQLResult.errors {
            let errorMessage = errors.map { $0.localizedDescription }.joined(separator: "\n")
            print("GraphQL errors creating workout: \(errorMessage)")
            return
          }

          if let newWorkoutId = graphQLResult.data?.createWorkout?.id {
            print("Created new workout with ID: \(newWorkoutId)")

            // Update the workoutId binding
            self.workoutId = newWorkoutId

            // No need to add exercises separately - already added in creation
            print("Workout created and exercises added successfully")

            // Close the modal
            self.showModal = false

            // Send notification to refresh parent view if needed
            NotificationCenter.default.post(
              name: NSNotification.Name("WorkoutCreated"), object: nil)
          } else {
            print("Failed to get new workout ID")
          }

        case .failure(let error):
          print("Workout creation failed: \(error.localizedDescription)")
        }
      }
    }
  }

  private func addExercisesToWorkout(workoutId: String, exerciseIds: [String]) {
    print("Adding exercises to workoutID: \(workoutId) with exerciseIDs: \(exerciseIds)")

    let input = Tread.AddExercisesInput(
      workoutID: .some(workoutId),
      exerciseIDs: exerciseIds
    )

    // Create the mutation
    let mutation = Tread.AddExercisesMutation(addExercisesInput: .some(input))

    // Perform the mutation
    apolloClient.perform(mutation: mutation) { [self] result in

      // Switch to main thread for UI updates
      DispatchQueue.main.async {
        switch result {
        case .success(let graphQLResult):
          if let errors = graphQLResult.errors {
            // Handle GraphQL errors
            let errorMessage = errors.map { $0.localizedDescription }.joined(separator: "\n")
            print("GraphQL errors: \(errorMessage)")
          } else if let addedExercises = graphQLResult.data?.addExercisesToWorkout {
            // Handle successful mutation with data
            print("Successfully added \(addedExercises.count) exercises to workout")
            self.showModal = false
          } else {
            // Handle case where neither errors nor data is present
            print("Mutation completed but no data returned")
          }

        case .failure(let error):
          // Handle network or other errors
          print("Mutation failed: \(error.localizedDescription)")
        }
      }
    }
  }

  // Add these helper methods to handle success and error cases
  //private func handleSuccess(_ exercises: [Tread.AddExerciseMutation.Data.AddExercise]) {
  //    // Handle the successful addition of exercises
  //    // You might want to update UI, show a success message, etc.
  //}

  //private func handleError(_ message: String) {
  //    // Handle error cases
  //    // You might want to show an alert, update UI state, etc.
  //}
}

struct ExerciseRow: View {
  let exercise: ExerciseModal
  let isSelected: Bool

  var body: some View {
    HStack {
      Text(exercise.title)
      Spacer()
      if isSelected {
        Image(systemName: "checkmark")
      }
    }
    .padding()
    .background(isSelected ? Color.yellow.opacity(0.3) : Color.clear)
    .cornerRadius(6)
  }
}
