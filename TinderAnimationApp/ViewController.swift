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
    var divisor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = view.frame.width / 2 / 0.61   // 0.61 - angle of card rotation in radians
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let scale = min(100 / abs(point.x), 1)   // 100 - scale becomes to work only when card is dragging out of center by 100
        card.transform = CGAffineTransform(rotationAngle: point.x / divisor).scaledBy(x: scale, y: scale)
        if point.x > 0 {
            imageView.image = #imageLiteral(resourceName: "star")
            imageView.tintColor = .yellow
        } else {
            imageView.image = #imageLiteral(resourceName: "trash")
            imageView.tintColor = .red
        }
        imageView.alpha = abs(point.x) / view.center.x
        if sender.state == .ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            } else if card.center.x > view.frame.width - 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                return
            }
            resetCard()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2) {
            self.card.center = self.view.center
            self.imageView.alpha = 0
            self.card.alpha = 1
            self.card.transform = .identity
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}












