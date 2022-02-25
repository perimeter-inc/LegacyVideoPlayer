//
//  File.swift
//  
//
//  Created by Bruno Wide on 25/02/22.
//

import Foundation
import UIKit
import SwiftUI

extension LegacyVideoPlayer {
    public init(url: URL) where Overlay == EmptyView {
        self.init(url: url, overlay: { EmptyView() })
    }

    public init(url: URL, @ViewBuilder overlay: @escaping () -> Overlay) {
        self.url = url
        self.overlay = overlay
    }
}
