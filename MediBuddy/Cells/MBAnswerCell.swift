//
//  MBAnswerCell.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import UIKit

protocol MBAnswerCellDelegate : AnyObject {
    func answerTapped(with indexPath : IndexPath)
}

class MBAnswerCell: UITableViewCell {
    
    // Stores the selected index path for the cell
    var selectedIndexPath : IndexPath?

    // Outlet for the answer button and label
    @IBOutlet weak var btnAnswer: UIButton!
    @IBOutlet weak var answerLabel: UILabel!

    // Delegate to handle cell interactions
    weak var delegate : MBAnswerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Allows the button to have multiple lines of text
        self.btnAnswer.titleLabel?.numberOfLines = 0
        contentView.addShadow()
    }
    
    // Configures the cell with the answer option and its index path
    func configureCell(answerOption:String,indexPath:IndexPath) {
        self.answerLabel.text = answerOption
        self.selectedIndexPath = indexPath
    }
    
    // Action method triggered when the submit button is tapped
    @IBAction func btnActionSubmit(_ sender: UIButton) {
        self.delegate?.answerTapped(with : selectedIndexPath!)
    }
    
    // Changes the UI to indicate if the answer is correct or incorrect
    func indicateAnswer(isCorrect : Bool) {
        self.btnAnswer.backgroundColor = isCorrect ? .green : .red
        self.answerLabel.textColor = .white
    }
}

