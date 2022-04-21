//
//  HabitStatistics.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation


struct HabitStatistics {
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable { }

