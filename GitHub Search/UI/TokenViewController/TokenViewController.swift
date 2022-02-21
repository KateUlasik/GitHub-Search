//
//  TokenViewController.swift
//  GitHub Search
//
//  Created by Katerina Ulasik on 20.02.2022.
//

import UIKit


class TokenViewController: UIViewController {
    
    @IBOutlet weak var tokenTextField: UITextField!
    
    var fireAfterClose: () -> () = {}
    
    private let storageService = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.fireAfterClose()
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.dismiss(animated: true) {
            let token = self.tokenTextField.text
        self.storageService.setToken(token: token)
            
            self.fireAfterClose()
        }
    }
}
