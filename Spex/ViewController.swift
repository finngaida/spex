//
//  ViewController.swift
//  Spex
//
//  Created by Finn Gaida on 25.06.17.
//  Copyright © 2017 Finn Gaida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = Bundle.main.url(forResource: "spectacles-1", withExtension: "mp4") else { return }

        let min = max(self.view.frame.width, self.view.frame.height)
        let pad = min / 10
        let layer = PlayerLayerHelper().layer(frame: CGRect(x: -(min-self.view.frame.width)/2 - pad, y: -pad, width: min+pad*2, height: min+pad*2), url: url)
        self.view.layer.addSublayer(layer)

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = UIApplication.shared.statusBarFrame
        self.view.addSubview(blur)
    }

}

