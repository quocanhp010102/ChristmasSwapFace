//
//  ChatModel.swift
//  SantaCallingApp
//
//  Created by tran the quan on 02/12/2021.
//

import Foundation
import RealmSwift
class ChatModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var check: Int = 0
    @objc dynamic var content: String?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

