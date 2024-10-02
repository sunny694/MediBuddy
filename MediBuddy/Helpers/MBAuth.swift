//
//  MBAuth.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import Foundation

class MBAuth {
    // MARK: After login or signup save auth token for now // by passed
    
    public class func login(userName:String,password:String,successHandler: @escaping (Result<Void, APIError>) -> Void) {
        let queryParams: [String: String] = ["email":userName,"password":password]
        MBAPIManager.shared.request(url: MBAPI.authLogin, httpMethod: .POST,queryParams: queryParams) { result in
            switch result {
            case .success(_):
                successHandler(.success(()))
            case .failure(let error):
                successHandler(.failure(error))
            }
        }
    }
    
    public class func signup(userName:String,password:String,successHandler: @escaping (Result<Void, APIError>) -> Void) {
        let queryParams: [String: String] = ["email":userName,"password":password]
        MBAPIManager.shared.request(url: MBAPI.authSignup, httpMethod: .POST,queryParams: queryParams) { result in
            switch result {
            case .success:
                successHandler(.success(()))
            case .failure(let error):
                successHandler(.failure(error))
            }
        }
    }
    
    //MARK: Logout
    public class func logout(successHandler: @escaping (Result<Void, APIError>) -> Void) {
        MBAPIManager.shared.request(url: MBAPI.logout, httpMethod: .POST) { result in
            switch result {
            case .success(_):
                successHandler(.success(()))
            case .failure(let error):
                successHandler(.failure(error))
            }
        }
    }
    
}
