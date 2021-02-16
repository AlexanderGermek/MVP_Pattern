//
//  ViewFunctions.swift
//  AG_GoraTest
//
//  Created by iMac on 31.01.2021.
//

import UIKit

func showAlert(withTitle title: String, andMessage message: String, inController controller: UIViewController) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(defaultAction)


        controller.present(alertController, animated: true, completion: nil)
}
