//
//  MBGameStatsVM.swift
//  MediBuddy
//
//  Created by Sunny Anand Jha on 02/10/24.
//

import Foundation

// MARK: - view model for Game stats that appear on end game
class MBGameStatsVM {
    var title:String
    var value:String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
