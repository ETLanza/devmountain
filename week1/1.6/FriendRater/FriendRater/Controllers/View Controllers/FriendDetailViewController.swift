//
//  FriendDetailViewController.swift
//  FriendRater
//
//  Created by Jayden Garrick on 7/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {
    
    //MARK: - Properties
    var friend: Friend?
    
    @IBOutlet weak var friendNameTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        let raiting = Int(sender.value)
        ratingLabel.text = "\(raiting)"
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = friendNameTextField.text, name != "",
            let rating = ratingLabel.text else { return }
        guard let intRating = Int(rating) else { return }
        if let friend = friend {
            FriendController.shared.updateFriend(friend, withName: name, andRating: intRating)
        } else {
            FriendController.shared.createFriendWith(name: name, rating: intRating)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 5
        
    }
    
    //MARK: - Methods
    func updateViews() {
        if let friend = friend {
            ratingLabel.text = "\(friend.rating)"
            friendNameTextField.text = friend.name
            ratingSlider.value = Float(friend.rating)
        } else {
            ratingLabel.text = "\(0)"
        }
    }
}

