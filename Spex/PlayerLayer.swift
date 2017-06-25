//
//  PlayerLayer.swift
//  Spex
//
//  Created by Finn Gaida on 25.06.17.
//  Copyright © 2017 Finn Gaida. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreMotion
import MotionKit

class PlayerLayerHelper: NSObject {

    let motion: MotionKit = MotionKit()
    var asset: AVAsset!
    var item: AVPlayerItem!
    var player: AVQueuePlayer!
    var layer: AVPlayerLayer!
    var looper: AVPlayerLooper!

    func layer(frame: CGRect, url: URL) -> AVPlayerLayer {
        asset = AVAsset(url: url)
        item = AVPlayerItem(asset: asset)
        player = AVQueuePlayer(playerItem: item)
        looper = AVPlayerLooper(player: player, templateItem: item)
        layer = AVPlayerLayer(player: player)
        layer.frame = frame
        player.play()

        motion.getGravityAccelerationFromDeviceMotion { x, y, _ in
            DispatchQueue.main.sync {
                let at = CGFloat(atan2(x, y)) - CGFloat.pi
                self.layer.transform = CATransform3DMakeRotation(at, 0, 0, 1)
            }
        }

        return layer
    }
}
