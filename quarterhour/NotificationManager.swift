//
//  NotificationManager.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import Foundation
import UserNotifications

final class NotificationManager{
    static let shared = NotificationManager()
    private init(){}
    
    func requestAuthoirization() async -> Bool{
        do {
            return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print("Error requesting authorization: \(error)")
            return false
        }
    }
    
    func schedulePing(){
        UNUserNotificationCenter.current()
                    .removePendingNotificationRequests(withIdentifiers: ["ping"])

        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60*15, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Checking in!"
        content.body = "What did you do in the last 15 minutes?"
        
        let req = UNNotificationRequest(identifier: "ping", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req)
    }
}


