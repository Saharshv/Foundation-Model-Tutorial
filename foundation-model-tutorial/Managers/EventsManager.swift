//
//  EventsManager.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation
import EventKit

class EventsManager {
    private let eventStore = EKEventStore()
    
    init() {
        requestAccessIfNeeded()
    }
    
    private func requestAccessIfNeeded() {
        Task {
            do {
                let success = try await eventStore.requestFullAccessToEvents()
                if !success {
                    print("Access to calendar events was not granted.")
                }
            } catch {
                print("Error requesting full access to events: \(error)")
            }
        }
    }
    
    func createEvent(title: String, startDate: Date, endDate: Date) -> Bool {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("✅ Event created: \(title)")
            return true
        } catch {
            print("❌ Failed to save event: \(error)")
            return false
        }
    }
}

