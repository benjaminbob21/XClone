//
//  SearchViewViewModel.swift
//  Twitter Clone
//
//  Created by Benjamin Bamisile on 1/24/26.
//

import Foundation
import Combine

class SearchViewViewModel {
    var subscriptions: Set<AnyCancellable> = []
    
    func search(with query: String, _ completion: @escaping ([XUser]) -> Void) {
        DatabaseManager.shared.collectionUsers(search: query)
            .sink{completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }receiveValue: { users in
                completion(users)
            }
            .store(in: &subscriptions)
    }
}
