//
//  LogView.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import SwiftUI

struct LogView: View {
    @EnvironmentObject private var store: EntryStore
    @State private var showingEditor = false
    @State private var selectedSlots: Set<Date> = []
    
    private var allSlots: [Date] {
        let cal = Calendar.current
        let startOfDay = cal.startOfDay(for: Date())
        return (0..<96).map { cal.date(byAdding: .minute, value: $0 * 15, to: startOfDay)! }
    }
    
    var body: some View {
        NavigationStack {
            List(allSlots, id: \.self) { slot in
                let hasEntry = store.entries.first { Calendar.current.isDate($0.timestamp, equalTo: $0.timestamp, toGranularity: .minute)}
                HStack{
                    Text(Self.timeFormatter.string(from:slot))
                        .frame(width: 70, alignment: .leading)
                    if let entry = hasEntry {
                        Text(entry.text)
                    } else {
                        Text("-").foregroundColor(.secondary)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if hasEntry == nil {
                        toggle(slot)
                    }
                }
                .background(selectedSlots.contains(slot) ? Color.blue.opacity(0.15) : .clear)
            }
            .navigationTitle("Today")
            .toolbar {
                if !selectedSlots.isEmpty {
                    Button("Fill \(selectedSlots.count) slots"){
                        showingEditor = true
                    }
                }
            }
            .sheet(isPresented: $showingEditor) {
                EntryEditor(slots: Array(selectedSlots)) {
                    text in store.add(text, for: Array(selectedSlots))
                    selectedSlots.removeAll()
                }
            }
        }
    }
    
    private func toggle(_ slot: Date) {
        if selectedSlots.contains(slot){
            selectedSlots.remove(slot)
        } else {
            selectedSlots.insert(slot)
        }
    }
    
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
}
