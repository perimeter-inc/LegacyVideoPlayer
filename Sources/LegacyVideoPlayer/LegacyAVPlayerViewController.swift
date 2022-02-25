//
//  LegacyAVPlayerViewController.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import AVKit

public class LegacyAVPlayerViewController: AVPlayerViewController {

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
}
