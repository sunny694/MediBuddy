//
//  MBGameCountdownVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import UIKit


class MBGameCountdownVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var animationLabel: UILabel!
    var textsToAnimate: [String] = []
    var currentIndex = 0
    var gamePlay: MBGamePlay!
    
    //MARK: constants
    let kAnimationDuration: TimeInterval = 0.5 // sec
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Ensure the label is initially hidden
        animationLabel.alpha = 0.0
    }
    
    // MARK: - Start Animation Sequence
    private func startAnimation() {
        guard !textsToAnimate.isEmpty else {
            print("No texts to animate")
            return
        }
        currentIndex = 0
        animateNextText()
    }
    
    // MARK: - Animate Next Text
    private func animateNextText() {
        if currentIndex < textsToAnimate.count {
            let text = textsToAnimate[currentIndex]
            currentIndex += 1
            animateLabel(text: text) { [weak self] in
                self?.animateNextText()
            }
        } else {
            // Once all animations are done, trigger the final action
            let vc = MBGamePageVC(nibName: "MBGamePageVC", bundle: nil)
            vc.viewModel = .init(gamePlay: self.gamePlay)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func animateLabel(text: String, completion: @escaping () -> Void) {
        animationLabel.text = text
        animationLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Start with a smaller scale
        
        // Animate scale and fade-in simultaneously
        UIView.animate(withDuration: kAnimationDuration, animations: {
            self.animationLabel.alpha = 1.0 // Fade in
            self.animationLabel.transform = CGAffineTransform.identity // Scale back to original size
        }) { _ in
            // After fade-in and scale-in are done, animate scale and fade-out
            UIView.animate(withDuration: self.kAnimationDuration, animations: {
                self.animationLabel.alpha = 0.0 // Fade out
                self.animationLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Scale back down
            }, completion: { _ in
                completion()
            })
        }
    }
    
    
    // MARK: - Public Method to Set Animation Texts and Final Action
    func configure(with texts: [String],gamePlay:MBGamePlay) {
        self.textsToAnimate = texts
        self.gamePlay = gamePlay
    }
}
