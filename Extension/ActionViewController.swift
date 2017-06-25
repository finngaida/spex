//
//  ActionViewController.swift
//  Extension
//
//  Created by Finn Gaida on 25.06.17.
//  Copyright © 2017 Finn Gaida. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var found = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeMPEG4 as String) {
                    provider.loadItem(forTypeIdentifier: kUTTypeMPEG4 as String, options: nil, completionHandler: { url, error in
                        if let url = url as? URL {
                            OperationQueue.main.addOperation {
                                self.addLayer(url)
                            }
                        }
                    })
                    
                    found = true
                    break
                }
            }
            
            if found { break }
        }
    }

    func addLayer(_ url: URL) {

        let min = max(self.view.frame.width, self.view.frame.height)
        let pad = min / 10
        let layer = PlayerLayerHelper().layer(frame: CGRect(x: -(min-self.view.frame.width)/2 - pad, y: -pad, width: min+pad*2, height: min+pad*2), url: url)
        self.view.layer.addSublayer(layer)

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20)
        self.view.addSubview(blur)
    }

    @IBAction func done() {
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
