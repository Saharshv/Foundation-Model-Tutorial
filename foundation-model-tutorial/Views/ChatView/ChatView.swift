//
//  ChatView.swift
//  foundation-model-tutorial
//
//  Created by Saharsh Vedi on 8/2/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isInputFocused: Bool

    init(repository: ChatRepository, onDeviceLLMManager: OnDeviceLLMManager) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(repository: repository, onDeviceLLMManager: onDeviceLLMManager))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                chatMessages
                inputRow
            }
            .navigationTitle("On-Device LLM Chat")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isInputFocused = true
            }
        }
    }

    private var chatMessages: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        messageView(for: message)
                    }
                    if viewModel.isResponding {
                        HStack {
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    scrollToLastMessage(with: proxy)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.hidden)
        .padding(16)
    }

    private var inputRow: some View {
        HStack(spacing: 12) {
            TextField("Enter a message", text: $viewModel.input)
                .focused($isInputFocused)
                .submitLabel(.send)
                .onSubmit {
                    viewModel.onSendTap()
                    isInputFocused = true
                }
                .padding(12)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))

            Button(action: viewModel.onSendTap) {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .disabled(viewModel.isResponding)
    }

    private func messageView(for message: Message) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isFromUser {
                Spacer()
            }

            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(message.isFromUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(message.isFromUser ? .white : .primary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }

            if !message.isFromUser {
                Spacer()
            }
        }
    }

    private func scrollToLastMessage(with scrollViewProxy: ScrollViewProxy) {
        if let lastMessage = viewModel.messages.last {
            withAnimation {
                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}
