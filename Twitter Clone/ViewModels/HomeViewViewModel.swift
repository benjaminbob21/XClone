//
//  HomeViewViewModel.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 12/29/25.
//

import Foundation
import Combine
import FirebaseAuth


final class HomeViewViewModel: ObservableObject {
    @Published var user: XUser?
    @Published var error: String?
    
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else {return}
        DatabaseManager.shared.collectionUsers(retreive: id)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: {[weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
}
