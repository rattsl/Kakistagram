//
//  User.swift
//  Kakistagram
//
//  Created by 垣内勇人 on 2019/05/27.
//  Copyright © 2019 Hayatokakiuchi. All rights reserved.
//

import UIKit

class User: NSObject {
    var objectId: String
    var userName: String
    var displayName: String?
    var introduction: String?
    
    init(objectId: String, userName: String) {
        self.objectId = objectId
        self.userName = userName
    }

}
