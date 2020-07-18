//
//  CreditsViewController.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/18.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayCredits()
    }
    
    func displayCredits() {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        let cgRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let newView = UIView(frame: cgRect)
        newView.backgroundColor = .white
        view.addSubview(newView)
        self.title = "Credits"
        let creditsTextView = UITextView(frame: CGRect(x: 0, y: 0, width: w/1.5, height: h/2))
        creditsTextView.center = CGPoint(x: UIScreen.main.bounds.size.width * 0.5,y: UIScreen.main.bounds.size.height * 0.5)
        creditsTextView.textAlignment = .center
        let attributedString = NSMutableAttributedString(string: "I created my free logo at LogoMakr.com.")
        attributedString.addAttribute(.link, value: "https://www.LogoMakr.com", range: NSRange(location: 26, length: 12))
        creditsTextView.attributedText = attributedString
        self.view.addSubview(creditsTextView)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}


