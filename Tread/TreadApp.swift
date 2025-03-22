//
//  TreadApp.swift
//  Tread
//
//  Created by Jorde Guevara on 2/9/25.
//

import SwiftUI

@main
struct TreadApp: App {
    @State private var showModal = true  // Dummy state to control modal visibility

    var body: some Scene {
        WindowGroup {
            WorkoutsView()
//            ExerciseModalView(
//                showModal: $showModal, // ✅ Binding to toggle modal
//                addExercise: { exercise in
//                    print("Dummy addExercise called with: \(exercise)")
//                },
//                existingExercises: []
//            )
        }
    }
}
