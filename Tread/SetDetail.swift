//
//  SetDetail.swift
//  Tread
//
//  Created by Jorde Guevara on 2/10/25.
//

import Foundation
import SwiftUI


struct SetDetailView: View {
    @State var exercise: Exercise
    @FocusState private var focusedField: Int?

    var body: some View {
        VStack {
            Text(exercise.name)
                .font(.largeTitle)
                .padding()
            List($exercise.sets.indices, id: \.self) { index in
                Text("Set \(index + 1)")
                    .font(.headline)
                    .padding(.bottom, 5)

                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Reps:")
                            TextField(
                                "Reps",
                                text: Binding(
                                    get: { 
                                        exercise.sets[index].reps == 0 ? "" : String(exercise.sets[index].reps) 
                                    },
                                    set: { 
                                        let newValue = Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                                        exercise.sets[index].reps = newValue
                                    }
                                )
                            )
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    if let textField = UIResponder.currentFirstResponder as? UITextField {
                                        textField.selectAll(nil)
                                    }
                                }
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Weight:")
                            TextField(
                                "Weight",
                                text: Binding(
                                    get: { 
                                        exercise.sets[index].weight == 0 ? "" : String(exercise.sets[index].weight) 
                                    },
                                    set: { 
                                        let newValue = Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                                        exercise.sets[index].weight = newValue
                                    }
                                )
                            )
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: index)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    if let textField = UIResponder.currentFirstResponder as? UITextField {
                                        textField.selectAll(nil)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 5)
            }
            Button(action: addSet) {
                Label("Add Set", systemImage: "plus")
            }
            .padding()
        }
    }

    func addSet() {
        let lastSet = exercise.sets.last
        let newSet = Set(
            id: UUID().uuidString,
            reps: lastSet?.reps ?? 0,
            weight: lastSet?.weight ?? 0
        )
        exercise.sets.append(newSet)
        focusedField = exercise.sets.count - 1
    }
}

extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder?

    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}

struct SetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SetDetailView(exercise: Exercise(id: "1", name: "Sample Exercise", sets: [Set(id: "1", reps: 10, weight: 50)]))
    }
}
