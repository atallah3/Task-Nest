//
//  NotificationManager.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 15/07/2024.
//

import SwiftUI
import UserNotifications


class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestAuthurization() {
        let option : UNAuthorizationOptions = [.alert,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { isGranted, error in
            if isGranted {
                print("succes")
            }
        }
    }
    
    func schduleNotification(id: String, title : String, date : Date) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Today`s challenge is waiting for you"
        
        var dateComponent = DateComponents()
        dateComponent.hour = Calendar.current.component(.hour, from: date)
        dateComponent.minute = Calendar.current.component(.minute, from: date)
        
        let trigger : UNNotificationTrigger? = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let req = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(req)
    }
    
    func cancelNotification(withId id : String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}
