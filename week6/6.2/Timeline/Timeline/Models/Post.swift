//
//  Post.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import  CloudKit

class Post {
    
    //MARK: - Constant Strings
    static let postTypeKey = "Post"
    static let photoDataKey = "photoData"
    static let timestampKey = "timestamp"
    
    //MARK: - Properties
    var photoData: Data?
    let timestamp: Date
    var comments: [Comment] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: PostController.PostCommentsChangedNotification, object: self)
            }
        }
    }
    var cloudKitRecordID: CKRecordID?
    
    var cloudKitRecord: CKRecord {
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record =  CKRecord(recordType: recordType, recordID: recordID)
        
        record[Post.timestampKey] = timestamp as CKRecordValue?
        record[Post.photoDataKey] = CKAsset(fileURL: temporaryPhotoURL)
        
        return record
    }
    
    var photo: UIImage? {
        guard let photoData = photoData,
        let image = UIImage(data: photoData)
        else { return nil }
        return image
    }
    
    var recordType: String {
        return Post.postTypeKey
    }
    
    //MARK: - Initilizer
    init(photoData: Data?, timestamp: Date = Date(), comments: [Comment] = []) {
        self.photoData = photoData
        self.timestamp = timestamp
        self.comments = comments
    }
    
    convenience required init?(record: CKRecord) {
        guard let timestamp = record.creationDate,
            let photoAsset = record[Post.photoDataKey] as? CKAsset else { return nil }
        
        let photoData = try? Data(contentsOf: photoAsset.fileURL)
        self.init(photoData: photoData, timestamp: timestamp)
        cloudKitRecordID = record.recordID
    }
    
    //MARK: - Private Helpers
    private var temporaryPhotoURL: URL {
        
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = URL(fileURLWithPath: temporaryDirectory)
        
        let fileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        try? photoData?.write(to: fileURL, options: [.atomic])
        
        return fileURL
    }
}

//MARK: - SearchableRecord
extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        let matchingComments = comments.filter { $0.matches(searchTerm: searchTerm) }
        return !matchingComments.isEmpty
    }
}
