import Apollo
import Combine
//
//  WorkoutViewModel.swift
//  Tread
//
//  Created by Jorde Guevara on 2/9/25.
//
// WorkoutViewModel.swift
import Foundation
import Tread

struct Workout: Identifiable {
  let id: String
  let name: String
}

class WorkoutViewModel: ObservableObject {
  @Published var workouts: [Workout] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?

  func fetchWorkouts() {
    isLoading = true
    errorMessage = nil

    let query = Tread.WorkoutQuery(userID: "34359738368")

    apolloClient.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
      }
      switch result {
      case .success(let graphQLResult):
        if let workoutsData = graphQLResult.data?.workouts?.compactMap({ $0 }) {
          DispatchQueue.main.async {
            self?.workouts = workoutsData.map { Workout(id: $0.id ?? "", name: $0.name ?? "") }
          }
        } else if let errors = graphQLResult.errors {
          DispatchQueue.main.async {
            self?.errorMessage = errors.map { $0.localizedDescription }.joined(separator: "\n")
          }
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self?.errorMessage = "Error: \(error.localizedDescription)"
        }
      }
    }
  }
}
