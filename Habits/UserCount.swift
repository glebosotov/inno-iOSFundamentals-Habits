//
//  UserCount.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation


struct UserCount {
    let user: User
    let count: Int
}

extension UserCount: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
    }
    
    static func ==(_ lhs: UserCount, _ rhs: UserCount) -> Bool {
        return lhs.user == rhs.user
    }
}

extension UserCount: Codable { }
