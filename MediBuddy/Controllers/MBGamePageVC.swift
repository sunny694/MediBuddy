//
//  MBGamePageVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import UIKit

class MBGamePageVC: UIViewController {

    @IBOutlet weak var endGameButton: UIButton!
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var nextbutton: UIButton!
    
    @IBOutlet weak var attemptedQuestionLabel: UILabel!
    @IBOutlet weak var questionContainer: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    var child : UIViewController?
    var viewModel:MBGamePageVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
        presentNextQuestion()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removePreviousVC()
    }
    
    // set up UI
    func setupUI() {
        nextbutton.setTitle(MBSystemMessages.General.next.capitalized, for: .normal)
        nextbutton.isEnabled = false
        nextbutton.tintColor = .lightGray
        questionContainer.layer.zPosition = -1
        categoryName.text = viewModel.gamePlay.questions.first?.category
        attemptedQuestionLabel.text = "\(viewModel.gamePlay.attemptedQuestions)/\(viewModel.gamePlay.questions.count)"
        
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.layer.borderColor = UIColor.gray.cgColor
        progressView.layer.borderWidth = 1
        
        endGameButton.setTitle(MBSystemMessages.General.endGame.capitalized, for: .normal)
        endGameButton.tintColor = .black
        

        bottomView.addShadow()
        updateQuestionCount()
    }
    
    // data binding
    func addObservers() {
        viewModel.handleLastQuestion = { [weak self] in
            self?.nextbutton.setTitle(MBSystemMessages.General.next.capitalized, for: .normal)
        }
    }

    @IBAction func endGameButtonClicked(_ sender: Any) {
        // end game
        redirectToEndGame()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        presentNextQuestion()
    }
    
    func presentNextQuestion() {
        if let question  = viewModel.getQuestion() {
            // present next question if available
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MBQuestionVC") as! MBQuestionVC
            vc.delegate = self
            vc.viewModel = .init(questionObj: question)
            addChildToContainer(vc)
        } else {
            // end game
            redirectToEndGame()
        }
    }
    
    func redirectToEndGame() {
        let vc = MBEndGameVC(nibName: "MBEndGameVC", bundle: nil)
        vc.viewModel = .init(gamePlay: self.viewModel.gamePlay)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addChildToContainer(_ child: UIViewController) {
            DispatchQueue.main.async { [self] in
                // Remove previous tab from container view
                if let previousVC = self.child {
                    previousVC.willMove(toParent: nil)
                    previousVC.view.removeFromSuperview()
                    previousVC.removeFromParent()
                }
                
                // Add new tab to container view
                let vc = child
                addChild(vc)
                vc.view.frame = questionContainer.bounds
                questionContainer.addSubview(vc.view)
                vc.didMove(toParent: self)

                self.child = child
        }
        
    }
}

extension MBGamePageVC: MBQuestionDelegate {
    // delegate methods
    // Delegate method when a question is answered, updates game state

    func questionAnswered(correctly: Bool) {
        viewModel.gamePlay.attemptedQuestions += 1
        viewModel.gamePlay.correctAnswers += correctly ? 1 : 0
        updateProgressView()
        nextbutton.isEnabled = true
        nextbutton.tintColor = .black
    }
    
    // Updates the progress view based on the attempted questions
    func updateProgressView() {
        let progress = Float(viewModel.gamePlay.attemptedQuestions) / Float(viewModel.gamePlay.questions.count)
        progressView.setProgress(progress, animated: true)
        updateQuestionCount()
        
    }
    
    // Question Count
    func updateQuestionCount() {
        attemptedQuestionLabel.text = "\(viewModel.gamePlay.attemptedQuestions)/\(viewModel.gamePlay.questions.count)"
    }
}


