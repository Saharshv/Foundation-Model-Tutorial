//
//  Message.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import Foundation

struct Message: Equatable, Identifiable {
    let id: UUID = UUID()
    let content: String
    let isFromUser: Bool
    let timestamp: Date
} 
