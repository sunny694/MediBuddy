//
//  MBHomeVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//

import UIKit
import SVProgressHUD

class MBGameSetupVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultySlider: UISlider!
    @IBOutlet weak var difficultyValueLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionSlider: UISlider!
    @IBOutlet weak var questionValueLabel: UILabel!
    
    @IBOutlet weak var playGameButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let viewModel: MBGameSetupVM = MBGameSetupVM()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindVM()
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Initial values for sliders and labels
        difficultySlider.minimumValue = 0
        difficultySlider.maximumValue = 2
        difficultySlider.value = 0
        difficultyValueLabel.text = String(viewModel.questionDifficulty.rawValue.uppercased())
        
        questionSlider.minimumValue = 1
        questionSlider.maximumValue = 25
        questionSlider.value = 0
        questionValueLabel.text = String(format: "%.0f", questionSlider.value)
        
        playGameButton.setTitle(MBSystemMessages.General.playGame.uppercased(), for: .normal)
        playGameButton.backgroundColor = .black
        playGameButton.tintColor = .white
        playGameButton.layer.cornerRadius = self.playGameButton.frame.height / 2
        
        titleLabel.text = MBSystemMessages.General.gameSetup.capitalized
        
    }
    
    //MARK: binding
    
    func bindVM() {
        // show error
        viewModel.showError = { errorString in
            self.showAlert(message: errorString)
            self.activatePlayGameButton()
        }
        
        // start gameplay
        viewModel.startGamePlay = { gamePlay in
            SVProgressHUD.dismiss()
            self.activatePlayGameButton()
            self.startCountdown(gamePlay: gamePlay)
        }
    }


    // MARK: - IBActions
    // Slider for determining the difficulty you want for the game
    @IBAction func difficultySliderChanged(_ sender: UISlider) {
        viewModel.questionValue = Int(sender.value)
        difficultyValueLabel.text = viewModel.checkForDifficulty().uppercased()
    }

    // Slider for determining the number of question you want for the game
    @IBAction func questionSliderChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        viewModel.numberOfQuestions = value
        questionValueLabel.text = String(value)
        
    }
    
    // start game play
    @IBAction func playGameButtonTapped(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: MBSystemMessages.General.waitforGametoLoad)
        viewModel.getQuestions()
        // Transition to game screen
    }
    
    // logout action
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.logout {
            DispatchQueue.main.async(execute: {
                if let controllers = self.navigationController?.viewControllers {
                    for vc in controllers {
                        if vc.isKind(of: MBLoginVC.self) {
                            self.navigationController?.popToViewController(vc, animated: false)
                        }
                    }
                }
            })
        }
    }
    
    // by passed needs to be implemented with login
    func activatePlayGameButton() {
        DispatchQueue.main.async {
            self.playGameButton.backgroundColor = .black
            self.playGameButton.isUserInteractionEnabled = true
        }
    }
    
    // start countdown for the game
    func startCountdown(gamePlay: MBGamePlay) {
        DispatchQueue.main.async {
            let vc = MBGameCountdownVC(nibName: "MBGameCountdownVC", bundle: nil)
            vc.configure(with: MBUtility.countDownArray,gamePlay: gamePlay)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // reset values when view dissappears
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetValues()
    }

    // reset sliders and assign default values
    func resetValues() {
        viewModel.reset()
        difficultySlider.value = 0
        difficultyValueLabel.text = String(MBQuestionDifficulty.easy.rawValue.uppercased())

        questionSlider.value = 0
        questionValueLabel.text = String(format: "%.0f", questionSlider.value)
    }
}

