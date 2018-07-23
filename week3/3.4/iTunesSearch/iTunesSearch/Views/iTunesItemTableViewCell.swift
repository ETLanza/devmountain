//
//  iTunesItemTableViewCell.swift
//  iTunesSearch
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class iTunesItemTableViewCell: UITableViewCell {
    
    var iTunesItem: iTunesItem? {
        didSet {
            updateViews()
        }
    }
    
    var iTunesItemImage: UIImage?
    
    //MARK: - Properties
    @IBOutlet weak var iTunesItemImageView: UIImageView!
    @IBOutlet weak var iTunesItemArtistNameLabel: UILabel!
    @IBOutlet weak var iTunesItemTrackNameLabel: UILabel!
    @IBOutlet weak var iTunesItemAlbumNameLabel: UILabel!
    
    func updateViews() {
        guard let iTunesItem = iTunesItem,
            let iTunesItemImage = iTunesItemImage else { return }
        DispatchQueue.main.async {
            self.iTunesItemImageView.image = iTunesItemImage
            self.iTunesItemArtistNameLabel.text = iTunesItem.artistName
            self.iTunesItemTrackNameLabel.text = iTunesItem.songName
            self.iTunesItemAlbumNameLabel.text = iTunesItem.albumName
        }
    }
}
