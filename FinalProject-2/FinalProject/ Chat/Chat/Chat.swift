//
//  Chat.swift
//  FinalProject
//

import Foundation
import UIKit
import Firebase
import MessageKit

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Chat {
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}

struct chatData {
    var senderID: String
    var recieverID: String
    var message: String
    var date: String
    var threadID: String
    var docID: String
    var name:String
}
