//
//  ViewController.swift
//  m20_UserDefaults
//
//  Created by Андрей Антонен on 22.03.2022.
//

import UIKit

enum Keys {
    static let studentName = "studentName"
    static let studentAge = "studentAge"
//    static let studentData = "studentData"
}

//struct UserData: Codable {
//    var studentName: String?
//    var studentAge: Int?
//}

//extension UserDefaults {
//    @objc dynamic var studentName: String {
//        return string(forKey: Keys.studentName) ?? ""
//    }
//
//    @objc dynamic var studentAge: Int {
//        return integer(forKey: Keys.studentAge)
//    }
//}

class ViewController: UIViewController {
    
//    var studentNameObserver: NSKeyValueObservation?
//    var studentAgeObserver: NSKeyValueObservation?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var savedName: String? = nil
    private var savedAge: Int? = nil
    
//    private var savedData: UserData = UserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate = self
        ageField.delegate = self
        
//        saveButton.isHidden = true
        
//        studentNameObserver = UserDefaults.standard.observe(\.studentName, options: [.initial, .new], changeHandler: { [weak self] (defaults, change) in
//            self?.savedName = change.newValue
//            self?.updateSavedData()
//        })
//
//        studentAgeObserver = UserDefaults.standard.observe(\.studentAge, options: [.initial, .new], changeHandler: { [weak self] (defaults, change) in
//            self?.savedAge = change.newValue
//            self?.updateSavedData()
//        })
        //20.3: UserDefaults
//        if let data = UserDefaults.standard.data(forKey: Keys.studentData) {
//            savedData = (try? JSONDecoder().decode(UserData.self, from: data)) ?? UserData()
//        }
        savedName = NSUbiquitousKeyValueStore().string(forKey: Keys.studentName)
        savedAge = Int(NSUbiquitousKeyValueStore().longLong(forKey: Keys.studentAge))
        
        updateSavedData()
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        updateSavedData()
    }
    
    private func updateSavedData() {
        if let savedName = savedName {
            titleLabel.text = "Saved name: \(savedName)"
        } else {
            titleLabel.text = "Name is not set"
        }

        if let savedAge = savedAge {
            ageLabel.text = "Saved age: \(savedAge)"
        } else {
            ageLabel.text = "Age is not set"
        }
        
//        20.3: UserDefaults:
//        if let savedName = savedData.studentName {
//                    titleLabel.text = "Saved name: \(savedName)"
//                } else {
//                    titleLabel.text = "Name is not set"
//                }
//
//        if let savedAge = savedData.studentAge {
//                    ageLabel.text = "Saved age: \(savedAge)"
//                } else {
//                    ageLabel.text = "Age is not set"
//                }
    }
    
//    deinit {
//        studentNameObserver?.invalidate()
//        studentAgeObserver?.invalidate()
//    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == titleField {
//            savedName = textField.text
//            UserDefaults.standard.set(savedName, forKey: Keys.studentName)
//        } else {
//            savedAge = Int(textField.text ?? "")
//            UserDefaults.standard.set(savedAge, forKey: Keys.studentAge)
//        }
        
//        20.3: UserDefaults:
//        if textField == titleField {
//            savedData.studentName = textField.text
////            UserDefaults.standard.set(savedName, forKey: Keys.studentName)
//        } else {
//            savedData.studentAge = Int(textField.text ?? "")
////            UserDefaults.standard.set(savedAge, forKey: Keys.studentAge)
//        }
//
//        if let data = try? JSONEncoder().encode(savedData) {
//            UserDefaults.standard.set(data, forKey: Keys.studentData)
//        }
//        textField.resignFirstResponder()
//        textField.text = nil
//        return true
        
//        20.4: NSUbiqitous
        if textField == titleField {
                savedName = textField.text
                NSUbiquitousKeyValueStore().set(savedName, forKey: Keys.studentName)
            } else {
                savedAge = Int(textField.text ?? "")
                NSUbiquitousKeyValueStore().set(savedAge, forKey: Keys.studentAge)
            }
            NSUbiquitousKeyValueStore().synchronize()
            textField.resignFirstResponder()
            textField.text = nil
            return true
        }
}
