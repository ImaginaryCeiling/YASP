//
//  EntryStore.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import Foundation

@MainActor
final class EntryStore:ObservableObject {
    @Published private(set) var entries: [Entry] = []
    
    private var fileURL:URL{
        let dateString = DateFormatter
            .localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
            .replacingOccurrences(of: "/", with: "-")
        
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(dateString).json")
    }
    
    func load() {
        if let data = try? Data(contentsOf: fileURL) {
            let decoded = try? JSONDecoder().decode([Entry].self, from: data)
            entries = decoded ?? []
        }
    }
    
    func add(_ text: String, for slots: [Date]){
        for slotStart in slots {
            entries.removeAll { Calendar.current.isDate($0.timestamp, equalTo: slotStart, toGranularity: .minute)}
            entries.append(.init(timestamp: slotStart, text: text))
        }
        save()
    }
    
    private func save(){
        if let data = try? JSONEncoder().encode(entries.sorted { $0.timestamp < $1.timestamp}){
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
