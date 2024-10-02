//
//  MBGameStatsView.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import UIKit

class MBGameStatsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // common initializer for status view
    func commonInit() {
        Bundle.main.loadNibNamed("MBGameStatsView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.contentView.layer.cornerRadius = 8
        self.contentView.addShadow()
    }
    
    func setupView(viewModel:MBGameStatsVM) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }

}


