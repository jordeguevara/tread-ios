import SwiftUI

struct WorkoutsView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var isShowingWorkoutDetail = false
    
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
                NavigationLink(destination: WorkoutDetailView(workoutId: ""), isActive: $isShowingWorkoutDetail) {
                    Button(action: {
                        isShowingWorkoutDetail = true
                    }) {
                        Text("New workout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Workouts")
            .onAppear {
                viewModel.fetchWorkouts()
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}