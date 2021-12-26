//
//  CMTime + Extension.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 26.12.2021.
//

import AVKit
import Foundation

extension CMTime {
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return ""}
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
}
