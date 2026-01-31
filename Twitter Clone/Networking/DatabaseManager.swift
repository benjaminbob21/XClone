//
//  DatabaseManager.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 12/28/25.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Foundation

class DatabaseManager {
  static let shared = DatabaseManager()

  let db = Firestore.firestore()
  let usersPath: String = "users"
  let tweetsPath: String = "tweets"
    let followingPath : String = "followings"

  func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
    let XUser = XUser(from: user)
    return db.collection(usersPath).document(XUser.id).setData(from: XUser)
      .map { _ in return true }
      .eraseToAnyPublisher()
  }

  func collectionUsers(retreive id: String) -> AnyPublisher<XUser, Error> {
    db.collection(usersPath).document(id).getDocument()
      .tryMap { try $0.data(as: XUser.self) }
      .eraseToAnyPublisher()
  }

  func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
    db.collection(usersPath).document(id).updateData(updateFields)
      .map { _ in true }
      .eraseToAnyPublisher()
  }

  func collectionTweets(dispatch tweet: Tweet) -> AnyPublisher<Bool, Error> {
    db.collection(tweetsPath).document(tweet.id).setData(from: tweet)
      .map { _ in true }
      .eraseToAnyPublisher()
  }

  func collectionUsers(search query: String) -> AnyPublisher<[XUser], Error> {
    // Remove @ symbol and trim whitespace
    let cleanQuery = query.trimmingCharacters(in: .whitespaces).replacingOccurrences(
      of: "@", with: "")

    // If query is empty (user just typed @), return all users
    if cleanQuery.isEmpty {
      return db.collection(usersPath)
        .limit(to: 50)
        .getDocuments()
        .map(\.documents)
        .tryMap { snapshots in
          try snapshots.map({
            try $0.data(as: XUser.self)
          })
        }
        .eraseToAnyPublisher()
    }

    // Fetch all users and filter client-side for substring matching
    return db.collection(usersPath)
      .getDocuments()
      .map(\.documents)
      .tryMap { snapshots in
        try snapshots.compactMap { snapshot -> XUser? in
          let user = try snapshot.data(as: XUser.self)
          // Case-insensitive substring match on username or displayName
          let queryLowercased = cleanQuery.lowercased()
          let usernameMatch = user.username.lowercased().contains(queryLowercased)
          let displayNameMatch = user.displayName.lowercased().contains(queryLowercased)

          return (usernameMatch || displayNameMatch) ? user : nil
        }
      }
      .eraseToAnyPublisher()
  }

  func collectionTweets(retreiveTweets forUserID: String) -> AnyPublisher<[Tweet], Error> {
    db.collection(tweetsPath).whereField("authorID", isEqualTo: forUserID)
      .getDocuments()
      .tryMap(\.documents)
      .tryMap { snapshots in
        try snapshots.map({
          try $0.data(as: Tweet.self)
        })
      }
      .eraseToAnyPublisher()
  }
    
    func collectionFollowings(isFollower: String, following: String) -> AnyPublisher<Bool, Error> {
        db.collection(followingPath)
            .whereField("follower", isEqualTo: isFollower)
            .whereField("following", isEqualTo: following)
            .getDocuments()
            .map(\.count)
            .map{
                $0 != 0
            }
            .eraseToAnyPublisher()
    }
    
    func collectionFollowings(follower: String, following: String) -> AnyPublisher<Bool, Error> {
        db.collection(followingPath).document().setData([
            "follower": follower,
            "following": following
        ])
        .map {true}
        .eraseToAnyPublisher()
    }
    
    
    func collectionFollowings(delete follower: String, following: String) -> AnyPublisher<Bool, Error> {
        db.collection(followingPath)
            .whereField("follower", isEqualTo: follower)
            .whereField("following", isEqualTo: following)
            .getDocuments()
            .map(\.documents.first)
            .map{ query in
                query?.reference.delete(completion: nil)
                return true
            }
            .eraseToAnyPublisher()
    }
}
