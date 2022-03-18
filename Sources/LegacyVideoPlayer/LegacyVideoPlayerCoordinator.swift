//
//  File.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import SwiftUI
import UIKit
import AVKit

public class CustomPlayerCoordinator<Overlay: View>: NSObject, AVPlayerViewControllerDelegate, AVPictureInPictureControllerDelegate {

    let customPlayer: LegacyVideoPlayer<Overlay>

    // loop
    var loopingPlayer: AVPlayerLooper?

    public init(customPlayer: LegacyVideoPlayer<Overlay>) {
        self.customPlayer = customPlayer
        super.init()
    }

    public func playerViewController(_ playerViewController: AVPlayerViewController,
                                     restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
}
