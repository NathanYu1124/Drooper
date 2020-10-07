//
//  EventModel.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/28.
//

import Foundation

class EventModel {
    
    var eventName = ""
    var eventType = (type:"", image:"")
    var eventMusic = (type:"", image:"")
    var eventTime = (hour:"", minute:"", second:"")
    var seconds = 0
    var creatDate = ""
    
    init(name: String, type: (String, String), music: (String, String), time: (String, String, String)) {
        self.eventName = name
        self.eventType = type
        self.eventMusic = music
        self.eventTime = time
        
        let hToS = Int(eventTime.hour)! * 3600
        let mToS = Int(eventTime.minute)! * 60
        self.seconds = hToS + mToS + Int(eventTime.second)!
    }
    
}
