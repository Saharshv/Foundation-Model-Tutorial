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
    @Published var isResponseLoading = false
    
    private let repository: ChatRepository
    
    init(repository: ChatRepository) {
        self.repository = repository
        self.messages = repository.messages
        
        self.subscribeToMessages()
    }
    
    func onSendTap() {
        let content = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard content.isEmpty == false else { return }
        Task {
            await repository.sendMessage(content)
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
}
