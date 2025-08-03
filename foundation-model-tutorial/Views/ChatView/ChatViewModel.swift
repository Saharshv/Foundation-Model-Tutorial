//
//  ChatViewModel.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [Message]
    @Published var input = ""
    @Published var isResponding = false
    
    private let repository: ChatRepository
    private let onDeviceLLMManager: OnDeviceLLMManager
    
    init(repository: ChatRepository, onDeviceLLMManager: OnDeviceLLMManager) {
        self.repository = repository
        self.onDeviceLLMManager = onDeviceLLMManager
        self.messages = repository.messages
        
        self.subscribeToMessages()
        self.subscribeToResponding()
    }
    
    func onSendTap() {
        let content = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard content.isEmpty == false else { return }
        Task {
            repository.sendMessage(content)
            input.removeAll()
        }
    }
}

// MARK: Subscriptions
extension ChatViewModel {
    private func subscribeToMessages() {
        repository.$messages
            .receive(on: DispatchQueue.main)
            .assign(to: &$messages)
    }
    
    private func subscribeToResponding() {
        onDeviceLLMManager.$isResponding
            .receive(on: DispatchQueue.main)
            .assign(to: &$isResponding)
    }
}
