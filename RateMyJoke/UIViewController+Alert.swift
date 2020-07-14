//
//  UIViewController+Alert.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/13.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
