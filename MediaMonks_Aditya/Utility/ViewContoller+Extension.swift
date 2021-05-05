//
//  ViewContoller+Extension.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 04/05/21.
//

import Foundation
import UIKit

extension UIViewController {

    func showError(_ errorString: String) {
        let alert = UIAlertController(title: "", message: errorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

