//
//  ViewController.swift
//  simplePersist
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

struct Loves: Codable {
    var text: String
    var count: Int
}

class ViewController: UIViewController {

    var loves = Loves(text: "Love", count: 2)
    
    @IBOutlet weak var loveField: UITextField!
    @IBOutlet weak var loveCountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let l = loadLoves() {
            self.loves = l
            loveField.text = self.loves.text
            loveCountField.text = String(self.loves.count)
        }
        
    }
    
    @IBAction func endEditing(_ sender: Any) {
        if let loveText = loveField.text,
            let loveCountTest = loveCountField.text,
            let loveCount = Int(loveCountTest) {
            loves.text = loveText
            loves.count = loveCount
            saveLoves(loves: loves)
        }
    }
    
    func saveLoves(loves: Loves) {
        let je = PropertyListEncoder()
        do {
            let data = try je.encode(loves)
            try data.write(to: fileURL())
        } catch let e {
            print("Error saving loves, \(e)")
        }
    }
    
    func loadLoves() -> Loves? {
        do {
            let data = try Data(contentsOf: fileURL())
            let jd = PropertyListDecoder()
            let loves = try jd.decode(Loves.self, from: data)
            return loves
        } catch let e {
            print("Error loading JSON from disk \(e)")
        }
        return nil
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "loves.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        return fullURL
    }
}

































