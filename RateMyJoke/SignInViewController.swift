//
//  ViewController.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/05.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignInView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchUIView()
    }
    
    func switchUIView() {
        if isSignInView {
            verifyPasswordTextField.isHidden = true
            signUpButton.setTitle("Don't have an account? Sign up", for: .normal)
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            verifyPasswordTextField.isHidden = false
            signUpButton.setTitle("Have an account? Sign in", for: .normal)
            signInButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        isSignInView = !isSignInView
        switchUIView()
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        // IF THE USER IS SIGNING IN
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if isSignInView {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult == nil else {
                    self.showAlert(title: "Sign In Failed", message: "")
                    return
                }
                self.goToHomeScreen()
            }
        } else {  // IF THE USER IS SIGNING UP
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if authResult != nil {
                    self.goToHomeScreen()
                } else {
                    self.showAlert(title: "Sign up failed", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func goToHomeScreen() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    
}

