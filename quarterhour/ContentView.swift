//
//  ContentView.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var store = EntryStore()
    @State private var dayStarted = false
    
    var body: some View {
         
        if dayStarted{
            LogView()
                .environmentObject(store)
        } else {
            VStack(spacing: 24) {
                Text("15 Minute Log")
                    .font(.largeTitle).bold()
                Button("Start Day"){
                    store.load()
                    dayStarted = true
                    NotificationManager.shared
                        .schedulePing()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}

