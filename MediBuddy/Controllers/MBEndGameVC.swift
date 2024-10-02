//
//  MBEndGameVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import UIKit

class MBEndGameVC: UIViewController {
    
    // Outlets for buttons, label, and game stats views
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accuracyView: MBGameStatsView!
    @IBOutlet weak var difficultyView: MBGameStatsView!
    @IBOutlet weak var correctAttemptView: MBGameStatsView!
    @IBOutlet weak var incorrectAttemptView: MBGameStatsView!
    
    var viewModel: MBEndGameVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removePreviousVC() // Remove the previous view controller from the stack
    }
    
    // Sets up the UI components based on ViewModel data
    func setupUI() {
        accuracyView.setupView(viewModel: .init(title: MBSystemMessages.General.accuracy.capitalized, value: viewModel.getAccuracy()))
        difficultyView.setupView(viewModel: .init(title: MBSystemMessages.General.difficulty.capitalized, value: viewModel.getDifficulty().uppercased()))
        correctAttemptView.setupView(viewModel: .init(title: MBSystemMessages.General.correct.capitalized, value: viewModel.correctAttempts()))
        incorrectAttemptView.setupView(viewModel: .init(title: MBSystemMessages.General.incorrect.capitalized, value: viewModel.wrongAttempts()))
        
        homeButton.setTitle(MBSystemMessages.General.home.capitalized, for: .normal)
        playAgain.setTitle(MBSystemMessages.General.playAgain.capitalized, for: .normal)
        titleLabel.text = MBSystemMessages.General.endGame.capitalized
    }
    
    // Action for the home button to pop back to the game setup screen
    @IBAction func homeButtonAction(_ sender: Any) {
        if let controllers = self.navigationController?.viewControllers {
            for controller in controllers {
                if controller.isKind(of: MBGameSetupVC.self) {
                    self.navigationController?.popToViewController(controller, animated: false)
                }
            }
        }
    }
    
    // Action for the play again button to start a new game with a countdown
    @IBAction func playAgainAction(_ sender: Any) {
        viewModel.playAgain()
        let vc = MBGameCountdownVC(nibName: "MBGameCountdownVC", bundle: nil)
        vc.textsToAnimate = MBUtility.countDownArray
        vc.gamePlay = self.viewModel.gamePlay
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

