//
//  CreateEventTool.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation
import FoundationModels

struct CreateEventTool: Tool {
    let name = "createEvent"
    let description = "Creates a calendar event using EventKit"

    @Generable
    struct Arguments {
        @Guide(description: "The title of the event")
        var title: String

        @Guide(description: "The start date and time of the event in yyyy-MM-ddTHH:mm:ss format")
        var startDate: String

        @Guide(description: "The end date and time of the event in yyyy-MM-ddTHH:mm:ss format")
        var endDate: String
    }

    let eventsManager: EventsManager

    func call(arguments: Arguments) async throws -> String {
        // Parse date strings into Date objects
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let start = formatter.date(from: arguments.startDate),
              let end = formatter.date(from: arguments.endDate) else {
            return "Failed to parse the event start or end time."
        }

        let success = eventsManager.createEvent(title: arguments.title, startDate: start, endDate: end)
        if success {
            return "Successfully created the event '\(arguments.title)' from \(arguments.startDate) to \(arguments.endDate)."
        } else {
            return "Failed to create the event '\(arguments.title)'."
        }
    }
}
