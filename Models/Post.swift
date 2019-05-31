//
//  Post.swift
//  Kakistagram
//
//  Created by 垣内勇人 on 2019/05/27.
//  Copyright © 2019 Hayatokakiuchi. All rights reserved.
//

import UIKit

class Post: NSObject {
    var objectId: String
    var user: User
    var imageUrl: String
    var text: String
    var createDate: Date
    var isLiked: Bool?
    var comments: [Comment]?
    var likeCount: Int = 0
    
    init(objectId: String, user: User, imageUrl: String, text: String, createDate: Date) {
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl
        self.text = text
        self.createDate = createDate
       
    }

}
