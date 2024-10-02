//
//  MBLoginVM.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//

import Foundation

class MBLoginVM {
    var authFlow: MBAuthFlow
    
    init(authFlow: MBAuthFlow) {
        self.authFlow = authFlow
    }
    
    // MARK: - Properties to Bind with View
    var email: String = ""
    var password: String = ""
    var firstName: String = ""
    var lastName: String = ""

    // MARK: - Error Handling via Closure
    var errorMessage: ((String) -> Void)?
    var handleSuccessfulAuthentication: (() -> Void)?
    var resetFields: (() -> Void)?
    
    // MARK: - Validation Logic
    
    // Validate email
    private func validateEmail() -> Bool {
        if email.isEmpty {
            errorMessage?(MBSystemMessages.Validation.emailEmpty)
            return false
        }
        
        // Regular expression for email validation
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            errorMessage?(MBSystemMessages.Validation.emailInvalid)
            return false
        }
        
        return true
    }

    // Validate password
    private func validatePassword() -> Bool {
        if password.isEmpty {
            errorMessage?(MBSystemMessages.Validation.passwordEmpty)
            return false
        }
        if password.count < 6 {
            errorMessage?(MBSystemMessages.Validation.passwordTooShort)
            return false
        }
        return true
    }


    // Validate username
    private func validateFirstname() -> Bool {
        if firstName.isEmpty {
            errorMessage?(MBSystemMessages.Validation.usernameEmpty)
            return false
        }
        if firstName.count < 2 {
            errorMessage?(MBSystemMessages.Validation.usernameTooShort)
            return false
        }
        return true
    }
    
    // Validate lastName
    private func validateLastName() -> Bool {
        if lastName.isEmpty {
            errorMessage?(MBSystemMessages.Validation.usernameEmpty)
            return false
        }
        if lastName.count < 2 {
            errorMessage?(MBSystemMessages.Validation.usernameTooShort)
            return false
        }
        return true
    }

    // Validate all fields
    private func validateCredentialsForSignUp() -> Bool {
        return validateEmail() &&
               validatePassword() &&
        validateFirstname() &&
        validateLastName()
    }
    
    // Validate both username and password
    private func validateCredentialsForLogin() -> Bool {
        return validateEmail() && validatePassword()
    }
    
    // VALIDATE CREDENTIALS BASED ON THE AUTH FLOW
    func verifyCredentials() {
        DispatchQueue.main.async(execute: { [self] in
            switch authFlow {
            case .login:
                login()
            case .signup:
                signUp()
            }
        })
    }
        

    // MARK: - Sign Up Logic (For example, API call) BYPASSED
    private func signUp() {
        if validateCredentialsForSignUp() {
            // Perform sign-up logic here (e.g., network call)
            MBAuth.signup(userName: email, password: password, successHandler: {
                result in
                switch result {
                case .success():
                    self.handleSuccessfulAuthentication?()

                case .failure(let error):
                    self.errorMessage?(MBUtility.getErrorString(error))
                }
            })

        }
    }
    // MARK: - Login Logic BYPASSED
    private func login() {
        if validateCredentialsForLogin() {
            // Simulate success login (this is where you might call an API)
            MBAuth.login(userName: email, password: password, successHandler: {
                result in
                switch result {
                    case .success():
                    self.handleSuccessfulAuthentication?()

                case .failure(let error):
                    self.errorMessage?(MBUtility.getErrorString(error))
                }
            })
        }
    }
    
    func reset() {
        email = ""
        password = ""
        firstName = ""
        lastName = ""
        authFlow = .login
        resetFields?()
        
    }
}

public enum MBAuthFlow {
    case login
    case signup
}
