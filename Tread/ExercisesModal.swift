import SwiftUI
import Apollo

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
                print("GraphQL Data: \(String(describing: graphQLResult.data))")
                
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
    guard let workoutId = workoutId, !workoutId.isEmpty else {
        print("Workout ID is missing or empty")
        return
    }
    
    print("Sending workoutID: \(workoutId) with exerciseIDs: \(exerciseIds)")

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
//                        self?.handleError(errorMessage)
                    } else if let addedExercises = graphQLResult.data?.addExercisesToWorkout {

                        if let newWorkoutId = graphQLResult.data?
                            .addExercisesToWorkout?
                            .compactMap({ $0 })
                            .first?
                            .id {
                            self.workoutId = newWorkoutId
                        }
                        // Handle successful mutation with data
                        print("Successfully added \(addedExercises.count) exercises to workout")
                        showModal = false
    //                    self?.handleSuccess(addedExercises)
                    } else {
                        // Handle case where neither errors nor data is present
                        print("Mutation completed but no data returned")
//                        self?.handleError("No data returned from server")
                    }
                    
                case .failure(let error):
                    // Handle network or other errors
                    print("Mutation failed: \(error.localizedDescription)")
//                    self?.handleError(error.localizedDescription)
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
