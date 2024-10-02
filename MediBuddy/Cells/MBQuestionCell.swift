//
//  MBQuestionCell.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import UIKit

// Question text cell
class MBQuestionCell: UITableViewCell {
    @IBOutlet weak var questionTextLabel: UILabel!
    func configureCell(with question:String) {
        questionTextLabel.text = question
    }
}
