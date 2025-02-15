//
//  WorkoutsView.swift
//  Tread
//
//  Created by Jorde Guevara on 2/9/25.
//
// WorkoutsView.swift
import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    Text("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workoutId: workout.id)) {
                        Text(workout.name)
                    }
                    }
                }
            }
            .navigationTitle("Workouts")
            .onAppear {
                viewModel.fetchWorkouts()
            }
        }
        .navigationBarHidden(true)
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
