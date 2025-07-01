//
//  quarterhourApp.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import SwiftUI

@main
struct quarterhourApp: App {
    @State private var permissionGranted = false
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    permissionGranted = await NotificationManager.shared.requestAuthoirization()
                }
        }
    }
}
