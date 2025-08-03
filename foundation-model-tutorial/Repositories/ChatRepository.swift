//
//  ChatRepository.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation
import Combine

final class ChatRepository {
    @Published private(set) var messages: [Message] = []
    
    private let onDeviceLLMManager: OnDeviceLLMManager
    
    init(onDeviceLLMManager: OnDeviceLLMManager) {
        self.onDeviceLLMManager = onDeviceLLMManager
        checkModelAvailabilityAndTellUser()
    }
    
    // MARK: - Public Methods
    
    /// Send a message to the chat
    func sendMessage(_ content: String, isFromUser: Bool = true) {
        let message = Message(content: content, isFromUser: isFromUser, timestamp: Date())
        messages.append(message)
        
        if isFromUser {
            Task {
                let llmReply = try await onDeviceLLMManager.generateResponse(for: content)
                sendMessage(llmReply, isFromUser: false)
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Check if on device model is available and send a message about the availability
    private func checkModelAvailabilityAndTellUser() {
        let (_, content) = onDeviceLLMManager.checkModelAvailability()
        sendMessage(content, isFromUser: false)
    }
}
