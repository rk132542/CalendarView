//
//  Event.swift
//  CalendarView
//
//  Created by Riku on 2024/09/01.
//

import Foundation
import SwiftData

@Model
final class Event {
    var id: UUID = UUID()
    var className: String
    var startDate: Date
    var endDate: Date
    var classLocation: String = ""
    
    init(className: String, startDate: Date, endDate: Date, classLocation: String) {
        self.className = className
        self.startDate = startDate
        self.endDate = endDate
        self.classLocation = classLocation
    }
    
    func stringStartTime() -> String {
        return startDate.formatted(date: .omitted, time: .shortened)
    }
    
    func stringEndTime() -> String {
        return endDate.formatted(date: .omitted, time: .shortened)
    }
    
    static func parseICS(_ icsString: String) -> [Event] {
        var events: [Event] = []

        print("\(icsString.split(whereSeparator: \.isNewline).count) lines found")
        
        let lines = icsString.split(whereSeparator: \.isNewline)
        
        var content: [String:String] = [:]
        
        for line in lines {
            if line.contains("END:VEVENT") {
                
                if let className = content["SUMMARY"],
                let startDateString = content["DTSTART"],
                let endDateString = content["DTEND"],
                   let location = content["LOCATION"] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    
                    if let startDate = dateFormatter.date(from: startDateString),
                       let endDate = dateFormatter.date(from: endDateString) {
                        
                        let event = Event(className: className, startDate: startDate, endDate: endDate, classLocation: location)
                        
                        events.append(event)
                        
                    }
                    content = [:]
                }
            }
            else {
                let key: String = String(line.split(separator: ":")[0])
                let value: String = String(line.split(separator: ":")[1])
                
                content[key] = value
            }
        }

        return events
    }
    
    static func getEventToDisplay(dataEvents: [Event], dateTime: Date) -> [Event] {
        var events: [Event] = []
        let calendar = Calendar.current
        print(dataEvents.count)
        // The rest of the day
        events = dataEvents.filter { event in
            return event.endDate > dateTime && calendar.isDate(event.startDate, inSameDayAs: dateTime)
        }
        
        return events
    }
}
