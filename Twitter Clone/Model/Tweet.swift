//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 1/23/26.
//

import Foundation


struct Tweet: Codable {
    var id = UUID().uuidString
    let author: XUser
    let authorID: String
    let tweetContent: String
    var likesCount: Int
    var likers: [String]
    let isReply: Bool
    let parentReference: String?
}
