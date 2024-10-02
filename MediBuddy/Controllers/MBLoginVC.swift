//
//  MBLoginVC.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//

import UIKit

class MBLoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var passwordTitle: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTitle: UILabel!
    @IBOutlet weak var lastNameTitle: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTitleTopConstraint: NSLayoutConstraint!
    
    var viewModel = MBLoginVM(authFlow: .login)
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
        setupTextFieldDelegates()
        bindViewModel()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Configure the login button to have rounded corners and background color
        verifyButton.layer.cornerRadius = 5
        verifyButton.backgroundColor = .black
        verifyButton.setTitleColor(.white, for: .normal)
        verifyButton.setTitle(MBSystemMessages.General.verify.capitalized, for: .normal)
        
        
        // Configure the logo image (you can set a custom image or use a system one)
        titleLabel.text = MBSystemMessages.General.login.capitalized
        
        // Set other UI configurations, if needed
        signUpButton.setTitle(MBSystemMessages.General.signup.capitalized, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        
        firstNameTitle.text = MBSystemMessages.General.firstNameTitle.capitalized
        lastNameTitle.text = MBSystemMessages.General.lastNameTitle.capitalized
        emailTitle.text = MBSystemMessages.General.emailTitle.capitalized
        passwordTitle.text =  MBSystemMessages.General.passwordTitle.capitalized
        
        // Setting Return Type for text fields
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next
        
        passwordTextField.isSecureTextEntry = true
        verifyButton.layer.cornerRadius = 5
        
        // Default Auth flow is login hence hiding the signup fields
        hideSignUpFields()
        
        
    }
    
    // MARK: - OBservers
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func bindViewModel() {
        // show error
        viewModel.errorMessage = { message in
            self.showAlert(message: message)
        }
        
        // redirect to game setup after authentication
        viewModel.handleSuccessfulAuthentication = {
            DispatchQueue.main.async {
                let vc = MBGameSetupVC(nibName: "MBGameSetupVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // reset fields
        viewModel.resetFields = {
            self.reset()
        }
        
    }
    
    private func setupTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        print("Login button tapped")
        // Perform Auth action
        viewModel.firstName = firstNameTextField.text ?? ""
        viewModel.lastName = lastNameTextField.text ?? ""
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        
        // BY pass for testing
        
//        viewModel.verifyCredentials()
        let vc = MBGameSetupVC(nibName: "MBGameSetupVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func signUpToggleButton(_ sender: UIButton) {
        print("Sign Up/Login button tapped")
        // Perform sign up action
        // hide/ show login based on the user toggle
        DispatchQueue.main.async {
            UIView.animate(withDuration:0.5 , delay: 0) { [self] in
                switch self.viewModel.authFlow {
                case .login:
                    viewModel.authFlow = .signup
                    showSignUpFields()
                    
                case .signup:
                    viewModel.authFlow = .login
                    hideSignUpFields()
                }
            }
            
        }
      
    }
    
    // hide signup fields when user clicks on login
    func hideSignUpFields() {
            signUpButton.setTitle(MBSystemMessages.General.signup.capitalized, for: .normal)
            titleLabel.text = MBSystemMessages.General.login.capitalized
            emailTitleTopConstraint.constant = -168
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            lastNameTitle.isHidden = true
            firstNameTitle.isHidden = true
            view.layoutIfNeeded()
    }
    
    // show signup fields when user clicks on signup
    func showSignUpFields() {
            signUpButton.setTitle(MBSystemMessages.General.login.capitalized, for: .normal)
            titleLabel.text = MBSystemMessages.General.signup.capitalized
            emailTitleTopConstraint.constant = 16
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            lastNameTitle.isHidden = false
            firstNameTitle.isHidden = false
            view.layoutIfNeeded()
    }
    
    // reset all fields
    func reset() {
        DispatchQueue.main.async {
            self.hideSignUpFields()
        }
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.reset()
    }
    
    
}

extension MBLoginVC: UITextFieldDelegate {
    
    // This method is called when the user taps the return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            case passwordTextField:
            textField.resignFirstResponder() // Dismiss the keyboard for the password field
            // Call the login action when password is entered
            verifyButtonTapped(verifyButton)
            
        default:
            break
        }
        return true
    }
}
