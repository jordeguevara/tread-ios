//
//  WorkoutDetails.swift
//  Tread
//
//  Created by Jorde Guevara on 2/10/25.
//

import SwiftUI
import Apollo

struct Exercise: Identifiable {
    var id: String
    var name: String
    var sets: [Set]
}

struct Set: Identifiable {
    var id: String
    var reps: Int
    var weight: Int
}

struct WorkoutSpecifics: Identifiable {
    let id: String
    let name: String
    var exercises: [Exercise]
}

struct WorkoutDetailView: View {
    let workoutId: String
    @State private var workout: WorkoutSpecifics?
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let workout = workout {
                Text(workout.name)
                    .font(.largeTitle)
                    .padding()
                List(workout.exercises) { exercise in
     ForEach(workout.exercises) { exercise in
                        NavigationLink(destination: SetDetailView(exercise: exercise)) {
                            Text(exercise.name)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchWorkoutDetails()
        }
    }

    private func fetchWorkoutDetails() {
        let query = Tread.WorkoutSpecificsQuery(workoutID: workoutId)
        apolloClient.fetch(query: query) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let graphQLResult):
                    if let workoutData = graphQLResult.data?.workout {
                        workout = WorkoutSpecifics(
                            id: workoutData.id ?? "",
                            name: workoutData.name ?? "",
                            exercises: workoutData.exercises?.compactMap { exercise in
                                guard let exercise = exercise else { return nil }
                                return Exercise(
                                    id: exercise.id ?? "",
                                    name: exercise.name ?? "",
                                    sets: workoutData.sets?.filter { $0?.exerciseID == exercise.id }.compactMap { set in
                                        guard let set = set else { return nil }
                                        return Set(id: set.id ?? "", reps: set.numOfReps ?? 0, weight: set.weight ?? 0)
                                    } ?? []
                                )
                            } ?? []
                        )
                    } else if let errors = graphQLResult.errors {
                        errorMessage = errors.map { $0.localizedDescription }.joined(separator: "\n")
                    }
                case .failure(let error):
                    errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workoutId: "1")
    }
}
