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
    
    init() {}
    
    // MARK: - Public Methods
    
    /// Send a message to the chat
    func sendMessage(_ content: String, isFromUser: Bool = true) {
        let message = Message(content: content, isFromUser: true, timestamp: Date())
        messages.append(message)
    }
}
