//
//  FriendController.swift
//  FriendRater
//
//  Created by Eric Lanza on 7/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import Foundation

class FriendController: Codable {
    
    //MARK: - Source of truth
    var friends: [Friend] = []
    
    //MARK: - Shared Instance
    static let shared = FriendController()
    
    //MARK: - CRUD Functions
    func createFriendWith(name: String, rating: Int) {
        let newFriend = Friend(name: name, rating: rating)
        FriendController.shared.friends.append(newFriend)
        saveToPersistentStore()
    }
    
    func updateFriend(_ friend: Friend, withName name: String, andRating rating: Int) {
        friend.name = name
        friend.rating = rating
        saveToPersistentStore()
    }
    
    func deleteFriend(_ friend: Friend) {
        guard let index = FriendController.shared.friends.index(of: friend) else { return }
        FriendController.shared.friends.remove(at: index)
        saveToPersistentStore()
    }
    
    //MARK: - Peristance Methods
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "friend.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(friends)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error when saving to persistent store: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedFriends = try decoder.decode([Friend].self, from: data)
            FriendController.shared.friends = decodedFriends
        } catch let error {
            print("There was an error when loading from persistent store: \(error)")
        }
    }
}
