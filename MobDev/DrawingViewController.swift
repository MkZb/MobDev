//
//  DrawingViewController.swift
//  MobDev
//
//  Created by Mykola Zubets on 24.04.2021.
//

import UIKit

class DrawingViewController: UIViewController {
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var navTop: NSLayoutConstraint!
    @IBOutlet weak var firstViewHeight: NSLayoutConstraint!
    @IBOutlet weak var firstViewWidth: NSLayoutConstraint!
    @IBOutlet weak var secondViewHeight: NSLayoutConstraint!
    @IBOutlet weak var secondViewWidth: NSLayoutConstraint!
    @IBOutlet weak var firstViewTop: NSLayoutConstraint!
    @IBOutlet weak var secondViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondView.alpha = 0
        self.updateConstraints(orientation: .portrait)
        self.view.layoutIfNeeded()
    }
    
    func updateConstraints(orientation: UIDeviceOrientation) {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        if (orientation == .portrait) {
            self.navTop.constant = 60
            self.firstViewTop.constant = 20
            self.secondViewTop.constant = 20
            let squareSize = min(screenWidth, screenHeight) * 0.95
            self.firstViewHeight.constant = squareSize
            self.firstViewWidth.constant = squareSize
            self.secondViewHeight.constant = squareSize
            self.secondViewWidth.constant = squareSize
            self.firstView.setNeedsDisplay()
            self.secondView.setNeedsDisplay()
 
        } else {
            self.navTop.constant = 15
            self.firstViewTop.constant = 5
            self.secondViewTop.constant = 5
            let squareSize = min(screenWidth, screenHeight) * 0.7
            self.firstViewHeight.constant = squareSize
            self.firstViewWidth.constant = squareSize
            self.secondViewHeight.constant = squareSize
            self.secondViewWidth.constant = squareSize
            self.firstView.setNeedsDisplay()
            self.secondView.setNeedsDisplay()
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            let orientation = UIDevice.current.orientation
            self.updateConstraints(orientation: orientation)
            self.view.layoutIfNeeded()
        }, completion: {
            _ in
        })

    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        }
        
        if sender.selectedSegmentIndex == 1 {
            firstView.alpha = 0
            secondView.alpha = 1
        }
    }
}
