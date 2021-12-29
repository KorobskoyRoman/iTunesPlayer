//
//  UserDefaults.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 29.12.2021.
//

import Foundation

extension UserDefaults {
    static let favoriteTrackKey = "favoriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        guard let savedTracks = defaults.object(forKey: UserDefaults.favoriteTrackKey) as? Data else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as?
                [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
}
