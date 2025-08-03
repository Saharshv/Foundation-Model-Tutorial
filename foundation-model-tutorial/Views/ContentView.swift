//
//  ContentView.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import SwiftUI

struct ContentView: View {
    let repository: ChatRepository
    let onDeviceLLMManager: OnDeviceLLMManager
    
    var body: some View {
        ChatView(repository: repository, onDeviceLLMManager: onDeviceLLMManager)
    }
}
