//
//  LegacyAVPlayerViewController.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import AVKit

public class LegacyAVPlayerViewController: AVPlayerViewController {

    // MARK: - Public Callbacks
    var onPlayerStatusChange: ((AVPlayer.TimeControlStatus) -> Void)?

    var overlayViewController: UIViewController! {
        willSet { assert(overlayViewController == nil, "contentViewController should be set only once") }
        didSet { attach() }
    }

    var overlayView: UIView { overlayViewController.view }

    private func attach() {
        guard
            let overlayViewController = overlayViewController,
            overlayViewController.parent == nil
        else {
            return
        }

        contentOverlayView?.addSubview(overlayView)
        overlayView.backgroundColor = .clear
        overlayView.sizeToFit()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(contentConstraints)
    }

    private lazy var contentConstraints: [NSLayoutConstraint] = {
        guard let overlay = contentOverlayView else { return [] }
        return [
            overlayView.topAnchor.constraint(equalTo: overlay.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: overlay.leadingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: overlay.bottomAnchor),
            overlayView.trailingAnchor.constraint(equalTo: overlay.trailingAnchor),
        ]
    }()

    // MARK: - Rate observers

    private var rateObserver: NSKeyValueObservation?

    public override var player: AVPlayer? {
        willSet { rateObserver?.invalidate() }
        didSet { rateObserver = player?.observe(\AVPlayer.rate, options: [.new], changeHandler: rateHandler(_:change:)) }
    }

    deinit { rateObserver?.invalidate() }

    private func rateHandler(_ player: AVPlayer, change: NSKeyValueObservedChange<Float>) {
        guard let item = player.currentItem,
              item.currentTime().seconds > 0.5,
              player.status == .readyToPlay
        else { return } // filter initial noise

        onPlayerStatusChange?(player.timeControlStatus)
    }
}
