//
//  OnDeviceLLMManager.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation
import FoundationModels
import Combine

class OnDeviceLLMManager {
    @Published var isResponding: Bool = false
    
    private var isModelAvailable: Bool { model.availability == .available }
    private var session: LanguageModelSession?
    
    private let model = SystemLanguageModel.default
    private let eventsManager: EventsManager
    
    init(eventsManager: EventsManager) {
        self.eventsManager = eventsManager
    }
    
    func checkModelAvailability() -> (Bool, String) {
        switch model.availability {
        case .available:
            return (true, "On-device model is available.")
        case .unavailable(.deviceNotEligible):
            return (false, "On-device model is not available: Device not eligible.")
        case .unavailable(.appleIntelligenceNotEnabled):
            return (false, "On-device model is not available: Apple Intelligence not enabled.")
        case .unavailable(.modelNotReady):
            return (false, "On-device model is not available: Model not ready.")
        case .unavailable(let other):
            return (false, "On-device model is not available: \(other)")
        }
    }
    
    func generateResponse(for prompt: String) async throws -> String {
        guard isModelAvailable else {
            throw OnDeviceLLMManagerError.modelNotAvailable
        }
        let currentSession: LanguageModelSession
        if let session {
            if session.isResponding {
                throw OnDeviceLLMManagerError.sessionStillResponding
            } else {
                currentSession = session
            }
        } else {
            currentSession = LanguageModelSession(tools: [CreateEventTool(eventsManager: eventsManager)])
            self.session = currentSession
        }
           
        self.isResponding = true
        let response = try await currentSession.respond(to: prompt)
        self.isResponding = false
        return response.content
    }
}

enum OnDeviceLLMManagerError: Error, LocalizedError {
    case modelNotAvailable
    case sessionStillResponding
    
    var errorDescription: String? {
        switch self {
        case .modelNotAvailable:
            return "On-device model is not available."
        case .sessionStillResponding:
            return "Session is still responding. Please wait for the current response to finish."
        }
    }
}

    
