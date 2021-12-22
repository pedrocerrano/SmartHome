//
//  Message.swift
//  Messages
//
//  Created by Trevor Adcock on 12/21/21.
//

import Foundation

/// A simple model class representing a message
class Message: Codable {
    
    /// The content of the message
    let text: String
    /// A boolean indicating if the message has been marked as read
    var isRead: Bool
    /// The date the message was created on
    let timeStamp: Date
    
    /// Initializes a new message with the give text, isRead, and timestamp
    /// - Parameters:
    ///   - text: The content of the message
    ///   - isRead: A boolean indicating if the message has been marked as read
    ///   - timeStamp: The date the message was created on
    init(text: String, isRead: Bool = false, timeStamp: Date = Date()) {
        self.text = text
        self.isRead = isRead
        self.timeStamp = timeStamp
    }
}
