//
//  MessageController.swift
//  Messages
//
//  Created by Trevor Adcock on 12/21/21.
//

import Foundation

/// A simple model controller to control the creation, reading and persistence of `Message` instances
class MessageController {
    
    /// A shared instance of the message controller
    static let shared = MessageController()
    
    init() {
        loadMessages()
    }
    
    /// The array of messages and sourece of truth for the app
    private(set) var messages: [Message] = []
    
    /// The URL that messages are persist to on disk
    private var messagesURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("messages.json")
        return url
    }
    
    /// Creates a new message, adds it to our array of messages (source of truth) and persists the message to the local disk
    /// - Parameter text: The content of the message
    func createMessage(text: String) {
        let newMessage = Message(text: text)
        messages.append(newMessage)
        saveMessages()
    }
    
    func toggleIsRead(message: Message) {
        message.isRead.toggle()
        MessageController.shared.saveMessages()
    }
    
    /// Persists the message controllers array of messages to disk
    func saveMessages() {
        // 1. Get the address to save a file to
        guard let messagesURL = messagesURL else { return }
        do {
            // 2. Convert the swift class into JSON data
            let data = try JSONEncoder().encode(messages)
            // 3. Save the data to the URL from step 1
            try data.write(to: messagesURL)
        } catch {
            print("Error Saving Messages", error)
        }
    }
    
    /// Loads  messages that are persist to the local disk updates the model controllers `messages` property
    func loadMessages() {
        // 1. Get the address to save a file to
        guard let messagesURL = messagesURL else { return }
        do {
            // 2. Load the raw data from the url
            let data = try Data(contentsOf: messagesURL)
            // 3. Convert the raw data into our Swift class
            let messages = try JSONDecoder().decode([Message].self, from: data)
            self.messages = messages
        } catch {
            print("Error Loading Messages", error)
        }
    }
}
