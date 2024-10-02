//
//  MBQuestionVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 01/10/24.
//

import UIKit

protocol MBQuestionDelegate:AnyObject {
    func questionAnswered(correctly: Bool)
}

class MBQuestionVC: UITableViewController {
    enum cellType:String {
        case question = "MBQuestionCell"
        case answer = "MBAnswerCell"
    }
    
    var viewModel: MBQuestionVM!
    var dataSourceArray:[cellType] = [.question,.answer]
    var delegate:MBQuestionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        
    }
    
    // setup table view delegate and data source
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension MBQuestionVC {
    //MARK: table view delegate methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        dataSourceArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSourceArray[section] {
        case .question:
            return 1
        case .answer:
            return viewModel.options.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSourceArray[indexPath.section] {
        case .question:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MBQuestionCell", for: indexPath) as! MBQuestionCell
            cell.configureCell(with: viewModel.question)
            cell.selectionStyle = .none
            return cell
        case .answer:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MBAnswerCell", for: indexPath) as! MBAnswerCell
            cell.configureCell(answerOption: viewModel.options[indexPath.row], indexPath: indexPath)
            cell.delegate = self
            cell.contentView.layer.zPosition = 10
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension MBQuestionVC:MBAnswerCellDelegate {
    // AnswerCell Delegate
    func answerTapped(with indexPath: IndexPath) {
        if !viewModel.didAnswerQuestion {
            if let cell = tableView.cellForRow(at: indexPath) as? MBAnswerCell {
                viewModel.didAnswerQuestion = true
                tableView.allowsSelection = false
                if viewModel.isValidAnswer(with: indexPath.row) {
                    // Mark answer by getting cell from index path
                    cell.indicateAnswer(isCorrect: true)
                    delegate?.questionAnswered(correctly: true)
                } else {
                    delegate?.questionAnswered(correctly: false)
                    cell.indicateAnswer(isCorrect: false)
                    // mark correct answer if user has selected wrong answer
                    markCorrectAnswer()
                    
                }
            }
        }
        
    }
    
    func markCorrectAnswer() {
        if let answerIndex = viewModel.getAnswerIndexPath() {
            if let cell = tableView.cellForRow(at: IndexPath(row: answerIndex, section: 1)) as? MBAnswerCell {
                cell.indicateAnswer(isCorrect: true)
            }
        }
    }
}
