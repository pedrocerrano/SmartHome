//
//  MessageTableViewCell.swift
//  Messages
//
//  Created by Trevor Adcock on 12/21/21.
//

import UIKit

/// A delegate protocol for the `MessageTableViewCell` which reports signals when the cells mark as read button is tapped
protocol MessageTableViewCellDelegate: AnyObject {
    
    /// A delegate method signaling that the mark as read button has just been tapped
    func markAsReadButtonWasTapped(_ cell: MessageTableViewCell)
}

/// A custom table view cell used for rendering the contents of a `Message` instance
class MessageTableViewCell: UITableViewCell {
    
    /// A label for the contents of the message
    @IBOutlet weak var messageLabel: UILabel!
    /// A lable for the date of the message
    @IBOutlet weak var dateLabel: UILabel!
    /// A button which can be used to indicate and change if the message is marked as read
    @IBOutlet weak var markAsReadButton: UIButton!
    
    /// The table view cells delegate which reports when the mark as read button is tapped
    weak var delegate: MessageTableViewCellDelegate?
    
    /// A date formatter used to conver the messages date into a coherent string
    private var shortDateFormatter = DateFormatter.short()
    
    /// Updates the table view cells views for the given messages content
    /// - Parameter message: The message to display in the cell
    func updateViews(message: Message) {
        messageLabel.text = message.text
        dateLabel.text = shortDateFormatter.string(from: message.timeStamp)
        let readImageName = message.isRead ? "checkmark.circle" : "circle"
        let readImage = UIImage(systemName: readImageName)
        markAsReadButton.setImage(readImage, for: .normal)
    }

    @IBAction func readButtonTapped(_ sender: UIButton) {
        delegate?.markAsReadButtonWasTapped(self)
    }
}
