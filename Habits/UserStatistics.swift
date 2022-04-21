//
//  UserStatistics.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation

struct UserStatistics {
    let user: User
    let habitCounts: [HabitCount]
}

extension UserStatistics: Codable { }
