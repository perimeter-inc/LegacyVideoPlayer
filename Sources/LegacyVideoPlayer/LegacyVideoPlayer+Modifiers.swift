//
//  File.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import AVKit

public extension LegacyVideoPlayer {
    func play(_ isPlaying: Bool = true, isLooping: Bool = false) -> LegacyVideoPlayer {
        LegacyVideoPlayer(overlay: overlay,
                          url: url,
                          onTimeControlStatusChange: onTimeControlStatusChange,
                          isPlaying: isPlaying,
                          isLooping: isLooping,
                          showsPlaybackControls: showsPlaybackControls)
    }

    func onTimeControlStatusChange(_ onTimeControlStatusChange: @escaping (AVPlayer.TimeControlStatus) -> Void) -> LegacyVideoPlayer {
        LegacyVideoPlayer(overlay: overlay,
                          url: url,
                          onTimeControlStatusChange: onTimeControlStatusChange,
                          isPlaying: isPlaying,
                          isLooping: isLooping,
                          showsPlaybackControls: showsPlaybackControls)
    }

    func showingPlaybackControls(_ showsPlaybackControls: Bool = true) -> LegacyVideoPlayer {
        LegacyVideoPlayer(overlay: overlay,
                          url: url,
                          onTimeControlStatusChange: onTimeControlStatusChange,
                          isPlaying: isPlaying,
                          isLooping: isLooping,
                          showsPlaybackControls: showsPlaybackControls)
    }
}
