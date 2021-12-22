//
//  MessagesTableViewController.swift
//  Messages
//
//  Created by Trevor Adcock on 12/21/21.
//

import UIKit

class MessagesTableViewController: UITableViewController {

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        let message = MessageController.shared.messages[indexPath.row]
        cell.updateViews(message: message)
        cell.delegate = self
        return cell
    }
    
    /// Presents the create new message alert controller
    private func presentNewMessageAlertController() {
        let alertController = UIAlertController(title: "New Message", message: "Enter the text for your message below", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Your Message Content"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Post", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                    let content = contentTextField.text  else { return }
            MessageController.shared.createMessage(text: content)
            self.tableView.reloadData()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentNewMessageAlertController()
    }
}

// MARK: - MessageTableViewCellDelegate Conformance
extension MessagesTableViewController: MessageTableViewCellDelegate {
    
    func markAsReadButtonWasTapped(_ cell: MessageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let message = MessageController.shared.messages[indexPath.row]
        MessageController.shared.toggleIsRead(message: message)
        cell.updateViews(message: message)
    }
}
