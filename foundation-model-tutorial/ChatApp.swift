//
//  ChatApp.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import SwiftUI

@main
struct ChatApp: App {
    private let onDeviceLLMManager: OnDeviceLLMManager
    
    init() {
        let eventsManager = EventsManager()
        let onDeviceLLMManager = OnDeviceLLMManager(eventsManager: eventsManager)
        self.onDeviceLLMManager = onDeviceLLMManager
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                repository: ChatRepository(onDeviceLLMManager: onDeviceLLMManager),
                onDeviceLLMManager: onDeviceLLMManager
            )
        }
    }
}
