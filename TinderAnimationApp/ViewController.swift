//
//  ViewController.swift
//  TinderAnimationApp
//
//  Created by Руслан Акберов on 10.06.2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        if point.x > 0 {
            imageView.image = #imageLiteral(resourceName: "star")
            imageView.tintColor = .yellow
        } else {
            imageView.image = #imageLiteral(resourceName: "trash")
            imageView.tintColor = .red
        }
        imageView.alpha = abs(point.x) / view.center.x
        if sender.state == .ended {
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.imageView.alpha = 0
            }
        }
    }
    
}

