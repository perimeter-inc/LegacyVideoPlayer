//
//  File.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import AVKit

public extension LegacyVideoPlayer {
    func play(isPlaying: Bool = true, looping: Bool = false) -> LegacyVideoPlayer {
        LegacyVideoPlayer(overlay: overlay, url: url, isPlaying: isPlaying, isLooping: looping)
    }
}
