//
//  CombinedStatistics.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation

struct CombinedStatistics {
    let userStatistics: [UserStatistics]
    let habitStatistics: [HabitStatistics]
}

extension CombinedStatistics: Codable { }
