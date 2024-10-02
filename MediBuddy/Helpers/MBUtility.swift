//
//  MBUtility.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import Foundation

class MBUtility {
    // MARK: - Basic utility functionality can be added here
    
    static var countDownArray: [String] = [MBSystemMessages.General.ready.capitalized,MBSystemMessages.General.set.capitalized,MBSystemMessages.General.go.capitalized]
    
    class func getErrorString(_ error: APIError) -> String {
        switch error {
        case .invalidURL:
            return MBSystemMessages.Error.generalError
        case .requestFailed(_):
            return MBSystemMessages.Error.generalError
        case .invalidResponse:
            return MBSystemMessages.Error.generalError
        case .invalidData:
            return MBSystemMessages.Error.generalError
        case .serializationError(_):
            return MBSystemMessages.Error.generalError
        case .parsingFailed:
            return MBSystemMessages.Error.generalError
        }
    }
}
