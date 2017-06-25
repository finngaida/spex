//
//  ViewController.swift
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

class ViewController: UIViewController {

    let motion = MotionKit()
    var looper: AVPlayerLooper!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = Bundle.main.url(forResource: "spectacles-1", withExtension: "mp4") else { return }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: item)
        let layer = AVPlayerLayer(player: player)
        looper = AVPlayerLooper(player: player, templateItem: item)

        let min = max(self.view.frame.width, self.view.frame.height)
        let pad = min / 10

        layer.frame = CGRect(x: -(min-self.view.frame.width)/2 - pad, y: -pad, width: min+pad*2, height: min+pad*2)

        self.view.layer.addSublayer(layer)
        player.play()

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = UIApplication.shared.statusBarFrame
        self.view.addSubview(blur)

        motion.getGravityAccelerationFromDeviceMotion { x, y, _ in
            DispatchQueue.main.sync {
                let at = CGFloat(atan2(x, y)) - CGFloat.pi
                layer.transform = CATransform3DMakeRotation(at, 0, 0, 1)
            }
        }

    }

}

