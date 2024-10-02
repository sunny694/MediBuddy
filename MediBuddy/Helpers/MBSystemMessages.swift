//
//  MBSystemMessages.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//


import Foundation

struct MBSystemMessages {

    // MARK: - Validation Messages
    struct Validation {
        static let emailEmpty = "Email cannot be empty."
        static let emailInvalid = "Please enter a valid email address."
        
        static let passwordEmpty = "Password cannot be empty."
        static let passwordTooShort = "Password must be at least 2 characters long."
        
        static let confirmPasswordEmpty = "Confirm password cannot be empty."
        static let passwordsDoNotMatch = "Passwords do not match."
        
        static let nameEmpty = "Name cannot be empty."
        
        static let usernameEmpty = "Username cannot be empty."
        static let usernameTooShort = "Username must be at least 2 characters long."
    }

    // MARK: - Success Messages
    struct Success {
        static let signUpSuccess = "Sign up successful!"
    }

    // MARK: - Error Messages
    struct Error {
        static let generalError = "An error occurred. Please try again."
        static let invalidURL = "The URL provided is invalid. Please check the URL and try again."
        static let requestFailed = "The request could not be completed. Please check your network connection and try again."
        static let invalidResponse = "The server returned an invalid response. Please try again later."
        static let invalidData = "The data received is invalid. Please contact support."
        static let serializationError = "An error occurred while processing data. Please try again."
        static let parsingFailed = "Data parsing failed. Please contact support or try again later."
    }
    
    // MARK: - General Messages
    struct General {
        static let noInternetConnection = "No internet connection. Please check your network connection and try again."
        static let waitforGametoLoad = "Please wait while we are creating a game for you..."
        static let playGame = "Play Game"
        static let playAgain = "Play Again"
        static let gameOver = "Game Over"
        static let highScore = "High Score"
        static let accuracy = "Accuracy"
        static let endGame = "End Game"
        static let correct = "correct"
        static let incorrect = "incorrect"
        static let home = "home"
        static let difficulty = "difficulty"
        static let next = "next"
        static let gameSetup = "Game Setup"
        static let login = "login"
        static let signup = "signup"
        static let verify = "verify"
        static let firstNameTitle = "First Name"
        static let lastNameTitle = "Last Name"
        static let emailTitle = "Email"
        static let passwordTitle = "Password"
        static let ready = "ready"
        static let set = "set"
        static let go = "go!"
        
    }
}

