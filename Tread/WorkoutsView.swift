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
          .refreshable {
            await refreshWorkouts()
          }
        }
        NavigationLink(
          destination: WorkoutDetailView(workoutId: ""), isActive: $isShowingWorkoutDetail
        ) {
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

  private func refreshWorkouts() async {
    // Wrap the non-async function in an async context
    return await withCheckedContinuation { continuation in
      viewModel.fetchWorkouts()
      // This is a simplification - ideally the viewModel would have an async function
      // or would use a completion handler
      continuation.resume()
    }
  }
}

struct WorkoutsView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutsView()
  }
}
