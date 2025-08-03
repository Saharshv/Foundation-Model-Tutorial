//
//  ChatApp.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import SwiftUI

@main
struct ChatApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                repository: ChatRepository()
            )
        }
    }
}
