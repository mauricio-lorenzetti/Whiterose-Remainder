//
//  Scheduler.swift
//  Whiterose-Remainder
//
//  Created by Mauricio Lorenzetti on 25/11/17.
//  Copyright © 2017 Mauricio Lorenzetti. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class Scheduler {
    
    let nc:UNUserNotificationCenter
    let options:UNAuthorizationOptions = [.sound]
    
    init(){
        nc = UNUserNotificationCenter.current()
        nc.requestAuthorization(options: options) { (granted, error) in
            print("autorizou? \(granted)")
            if let e = error {
                print(e.localizedDescription)
            }
        }
    }
    
    func scheduleWith(timeInterval: TimeInterval){
        let content = UNMutableNotificationContent()
        
        content.sound = UNNotificationSound(named: "beep.mp4")
        
        if options.contains(.alert) {
            content.title = "Hey!"
            content.body = "\(timeInterval) seconds more passed by..."
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
        let request = UNNotificationRequest(identifier: "whiterose", content: content, trigger: trigger)
        
        nc.add(request, withCompletionHandler: { (error: Error?) in
            if let e = error {
                print(e.localizedDescription)
                print("não registrou");
            } else {
                UserDefaults.standard.set(true, forKey: "status")
                print("registrou");
            }
        })
    }
    
    func removeAllNotifications() {
        nc.getPendingNotificationRequests() { (l) in
            for n in l {
                print(String(describing: n.trigger))
            }
        }
        nc.removeAllPendingNotificationRequests()
    }
    
}
