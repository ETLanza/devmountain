//
//  PhotoSelectViewController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/8/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    weak var delegate: PhotoSelectViewControllerDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    //MARK: - IBActions
    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func resetViews(){
        selectImageButton.setTitle("Select Image", for: .normal)
        postImageView.image = nil
    }
    
    //MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            delegate?.photoSelectViewControllerSelected(image: image)
            selectImageButton.setTitle("", for: .normal)
            postImageView.image = image
        }
    }
}

//MARK: - Custom Delegate
protocol PhotoSelectViewControllerDelegate: class {
    func photoSelectViewControllerSelected(image: UIImage)
}
