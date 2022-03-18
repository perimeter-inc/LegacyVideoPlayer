//
//  CustomPlayer.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import AVKit

public struct LegacyVideoPlayer<Overlay: View>: UIViewControllerRepresentable {

    var overlay: () -> Overlay
    let url: URL

    // MARK: - Callbacks
    var onTimeControlStatusChange: ((AVPlayer.TimeControlStatus) -> Void)?

    @State var isPlaying = false
    @State var isLooping = false
    @State var showsPlaybackControls = true

    public func makeCoordinator() -> CustomPlayerCoordinator<Overlay> {
        CustomPlayerCoordinator(customPlayer: self)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<LegacyVideoPlayer>) -> LegacyAVPlayerViewController {
        let controller = LegacyAVPlayerViewController()

        controller.delegate = context.coordinator
        makeAVPlayer(in: controller, context: context)
        playIfNeeded(controller.player)

        return controller
    }

    public func updateUIViewController(_ uiViewController: LegacyAVPlayerViewController, context: UIViewControllerRepresentableContext<LegacyVideoPlayer>) {
        makeAVPlayer(in: uiViewController, context: context)
        playIfNeeded(uiViewController.player)
        updateOverlay(in: uiViewController, context: context)
    }

    private func updateOverlay(in controller: LegacyAVPlayerViewController, context: UIViewControllerRepresentableContext<LegacyVideoPlayer>) {
        guard let hostController = controller.overlayViewController as? UIHostingController<Overlay> else {
            let host = UIHostingController(rootView: overlay())
            
            controller.overlayViewController = host
            return
        }

        hostController.rootView = overlay()
    }

    private func makeAVPlayer(in controller: LegacyAVPlayerViewController, context: UIViewControllerRepresentableContext<LegacyVideoPlayer>) {
        if isLooping {
            let item = AVPlayerItem(url: url)
            let player = AVQueuePlayer(playerItem: item)
            let loopingPlayer = AVPlayerLooper(player: player, templateItem: item)
            controller.videoGravity = AVLayerVideoGravity.resizeAspectFill
            context.coordinator.loopingPlayer = loopingPlayer
            controller.player = player
        } else {
            controller.player = AVPlayer(url: url)
        }

        controller.showsPlaybackControls = showsPlaybackControls

        controller.onPlayerStatusChange = onTimeControlStatusChange
    }

    private func playIfNeeded(_ player: AVPlayer?) {
        if isPlaying { player?.play() }
        else { player?.pause() }
    }
}
