//
//  WorkoutStore.swift
//  Tread
//
//  Created by Jorde Guevara on 2/10/25.
//

import Foundation
import SwiftUI
import Apollo
import Tread
class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var exercises: [Exercise] = []
    @Published var sets: [Set] = []
    
    @Published var fetchError: String?
    
    private var apolloClient: ApolloClient
    
    init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient

    }
    

    
    func addExercise(_ exercise: Exercise) {
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
        } else {
            exercises.append(exercise)
        }

        upsertExercise(exercise)
    }
    
    private func upsertExercise(_ exercise: Exercise) {

    }
}
