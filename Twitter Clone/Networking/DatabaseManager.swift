//
//  DatabaseManager.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 12/28/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    
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
            .map{_ in true}
            .eraseToAnyPublisher()
    }
}
