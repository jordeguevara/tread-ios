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
                            selectedExercises.forEach(addExercise)
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
            print("Received result: \(result)")
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
