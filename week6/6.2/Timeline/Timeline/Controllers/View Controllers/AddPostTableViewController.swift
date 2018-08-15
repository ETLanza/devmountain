//
//  AddPostTableViewController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Properties
    var image: UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var captionTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let image = image,
            let text = captionTextField.text, !text.isEmpty else {
            let alertController = UIAlertController(title: "Missing Info", message: "Make sure you have both an image and a caption before creating a new post", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            return
        }
        
        PostController.shared.createPostWith(image: image, caption: text) { (_) in
        }

        tabBarController?.selectedIndex = 0
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedPhotoSelect" {
            let embedViewController = segue.destination as? PhotoSelectViewController
            embedViewController?.delegate = self
        }
    }
}

//MARK: - Custom Delegate Conforming
extension AddPostTableViewController: PhotoSelectViewControllerDelegate {
    func photoSelectViewControllerSelected(image: UIImage) {
        self.image = image
    }
}
