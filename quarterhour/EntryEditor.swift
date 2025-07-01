//
//  EntryEditor.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import SwiftUI

struct EntryEditor: View {
    
    let slots: [Date]
    var onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 16) {
                Text("Filling \(slots.count) slots")
                    .font(.headline)
                TextEditor(text: $text)
                    .border(Color.secondary)
                    .frame(minHeight: 150)
                Spacer()
            }
            .padding()
            .navigationTitle(Text("What did you do?"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        onSave(text.trimmingCharacters(in: .whitespacesAndNewlines))
                        dismiss()
                    }.disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
            }
        }
    }
}
