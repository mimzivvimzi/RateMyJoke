//
//  Joke.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/16.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class Joke {
    var id: String
    var jokeDescription: String?
    var likes: Int?
    var dislikes: Int?
    
    init(json: [String: Any], id: String) {
        jokeDescription = json["description"] as? String ?? ""
        likes = json["likes"] as? Int ?? 0
        dislikes = json["dislikes"] as? Int ?? 0
        self.id = id
    }
    
    init(description: String, likes: Int, dislikes: Int, id: String) {
        jokeDescription = description
        self.likes = likes
        self.dislikes = dislikes
        self.id = id
    }
    
//    init(dictionary: [String: Any], id: String) {
//        self.jokeDescription = dictionary["jokeDescription"] as? String
//        self.likes = dictionary["likes"] as? Int
//        self.dislikes = dictionary["dislikes"] as? Int
//        self.id = id
//    }
}
