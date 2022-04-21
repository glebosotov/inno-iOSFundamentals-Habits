//
//  Settings.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation

struct Settings {
    static var shared = Settings()
    static let favoriteHabits = "favoriteHabits"
    static let followedUserIDs = "followedUserIDs"

    private var defaults = UserDefaults.standard
    
    private func archiveJSON<T: Encodable>(value: T, key: String) {
        let data = try! JSONEncoder().encode(value)
        let string = String(data: data, encoding: .utf8)
        defaults.set(string, forKey: key)
    }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key),
              let data = string.data(using: .utf8) else {
            return nil
        }
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    var favoriteHabits: [Habit] {
        get {
            return unarchiveJSON(key: Settings.favoriteHabits) ?? []
        }
        set {
            archiveJSON(value: newValue, key: Settings.favoriteHabits)
        }
    }
    
    var followedUserIDs: [String] {
        get {
            return unarchiveJSON(key: Settings.followedUserIDs) ?? []
        }
        set {
            archiveJSON(value: newValue, key: Settings.followedUserIDs)
        }
    }
    
    mutating func toggleFavorite(_ habit: Habit) {
        var favorites = favoriteHabits

        if favorites.contains(habit) {
            favorites = favorites.filter { $0 != habit }
        } else {
            favorites.append(habit)
        }

        favoriteHabits = favorites
    }
    
    mutating func toggleFavorite(_ user: User) {
        var updated = followedUserIDs

        if updated.contains(user.id) {
            updated = updated.filter { $0 != user.id }
        } else {
            updated.append(user.id)
        }

        followedUserIDs = updated
    }
    
    let currentUser = User(id: "gleb", name: "gleb", color: nil, bio: nil)
}
