//
//  CloudKitManager.swift
//  BulletinBoardVideo
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Error?) -> Void = { _ in }) {
        
    }
}
