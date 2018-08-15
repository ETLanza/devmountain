//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        postImageView.image = post?.photo
    }
}
