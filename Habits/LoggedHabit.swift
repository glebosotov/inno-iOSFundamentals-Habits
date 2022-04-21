//
//  LoggedHabit.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation

struct LoggedHabit {
    let userID: String
    let habitName: String
    let timestamp: Date
}

extension LoggedHabit: Codable { }


