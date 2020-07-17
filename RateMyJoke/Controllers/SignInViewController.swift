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
        
        if Auth.auth().currentUser != nil {
            try? Auth.auth().signOut()
        }
        switchUIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("current user: \(Auth.auth().currentUser)")
    }
    
    func switchUIView() {
        self.verifyPasswordTextField.isHidden = isSignInView
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
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        // IF THE USER IS SIGNING IN
        if isSignInView {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard error == nil else {
                    self.showAlert(title: "Sign-in Failed", message: error?.localizedDescription ?? "")
                    return
                }
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.goToHomeScreen()
            }
        } else {  // IF THE USER IS SIGNING UP
            if passwordTextField.text == verifyPasswordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil else {
                        self.showAlert(title: "Sign-up Failed", message: error?.localizedDescription ?? "")
                        return
                    }
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.verifyPasswordTextField.text = ""
                    self.isSignInView = true
                    self.switchUIView()
                    self.goToHomeScreen()
                }
            } else {
                showAlert(title: "Password does not match", message: "Password and verify password field must match")
            }
        }
    }
//        if isSignInView {
//            Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
//                if authResult != nil {
//                    self.goToHomeScreen()
//                } else {
//                    self.showAlert(title: "Sign-in Failed", message: error?.localizedDescription ?? "")
//                }
//            }
//        } else {  // IF THE USER IS SIGNING UP
//            if passwordTextField.text == verifyPasswordTextField.text {
//                Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
//                    if authResult != nil {
//                        self.goToHomeScreen()
//                    } else {
//                        self.showAlert(title: "Sign-up Failed", message: error?.localizedDescription ?? "")
//                    }
//                }
//            } else {
//                showAlert(title: "Password does not match", message: "Password and verify password field must match")
//            }
//        }
//    }
    
    func goToHomeScreen() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}


