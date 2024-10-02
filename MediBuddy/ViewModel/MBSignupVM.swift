//
//  MBSignupVM.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//


import Foundation

// ViewModel for SignUp Screen
class MBSignUpVM {

    // MARK: - Properties to Bind with View
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var name: String = ""
    var lastName: String = ""

    // MARK: - Error Message Closure
    var errorMessage: ((String) -> Void)?

    // MARK: - Validation Methods

    // Validate email
    func validateEmail() -> Bool {
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
    func validatePassword() -> Bool {
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

    // Validate confirm password
    func validateConfirmPassword() -> Bool {
        if confirmPassword.isEmpty {
            errorMessage?(MBSystemMessages.Validation.confirmPasswordEmpty)
            return false
        }
        if password != confirmPassword {
            errorMessage?(MBSystemMessages.Validation.passwordsDoNotMatch)
            return false
        }
        return true
    }

    // Validate name
    func validateName() -> Bool {
        if name.isEmpty {
            errorMessage?(MBSystemMessages.Validation.nameEmpty)
            return false
        }
        return true
    }

    // Validate username
    func validateUsername() -> Bool {
        if lastName.isEmpty {
            errorMessage?(MBSystemMessages.Validation.usernameEmpty)
            return false
        }
        if lastName.count > 1 {
            errorMessage?(MBSystemMessages.Validation.usernameTooShort)
            return false
        }
        return true
    }

    // Validate all fields
    func validateAllFields() -> Bool {
        return validateEmail() &&
               validatePassword() &&
               validateConfirmPassword() &&
               validateName() &&
               validateUsername()
    }

    // MARK: - Sign Up Logic (For example, API call)
    func signUp() {
        if validateAllFields() {
            // Perform sign-up logic here (e.g., network call)
            print(MBSystemMessages.Success.signUpSuccess)
        }
    }
}
