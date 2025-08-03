# Foundation Models Chat App Tutorial

A comprehensive iOS chat application demonstrating the new **FoundationModels** framework introduced in iOS 26. This tutorial app showcases how to integrate on-device large language models (LLMs) with custom tools and real-time chat functionality.

## 🎯 Overview

This chat application serves as a practical example of Apple's FoundationModels framework, featuring:

- **On-device LLM integration** using `FoundationModels`
- **Custom tool implementation** for calendar event creation
- **Real-time chat interface** with SwiftUI
- **MVVM architecture** for clean code organization
- **Tool calling capabilities** that allow the AI to interact with system APIs

## 🔧 Features

### Core Functionality
- Interactive chat interface with on-device AI responses
- Real-time typing indicators and message timestamps
- Automatic model availability detection and user feedback
- Calendar event creation through natural language commands

### Technical Highlights
- **FoundationModels Framework**: Leverages Apple's new on-device LLM capabilities
- **Tool Integration**: Custom `CreateEventTool` that allows the AI to create calendar events
- **EventKit Integration**: Seamless calendar access with proper permission handling
- **Reactive Programming**: Uses Combine for state management and UI updates

## 📱 Requirements

- **iOS 26.0+**
- **Xcode 26+** (Required for FoundationModels framework)
- **Apple Intelligence enabled** on the device
- **Calendar access permissions**


## 🔑 Key Components

### OnDeviceLLMManager
The heart of the LLM integration, handling:
- Model availability checking across different states
- Session management with tool integration
- Response generation with error handling
- Publishing loading states for UI updates

### CreateEventTool
A custom tool implementation that:
- Conforms to the `Tool` protocol from FoundationModels
- Uses `@Generable` and `@Guide` for parameter definition
- Integrates with EventKit for calendar operations
- Provides structured responses back to the LLM

### ChatRepository
Manages chat data flow:
- Message storage and publishing
- Coordination between user input and LLM responses
- Model availability status communication

## 📚 Learning Resources

This tutorial demonstrates key concepts from:
- [Apple's FoundationModels Documentation](https://developer.apple.com/documentation/foundationmodels)
- [EventKit Framework Guide](https://developer.apple.com/documentation/eventkit)

---

**Note**: This tutorial requires the latest iOS 26 beta and may require adjustments as the FoundationModels framework evolves during the beta period.
