//
//  LoginViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var passwordInput: NSSecureTextField!
    @IBOutlet weak var userNameInput: NSTextField!
    
    @IBOutlet weak var logoutButton: NSButton!
    
    @IBOutlet weak var usernameLabel: NSTextField!
    
    @IBOutlet weak var passwordLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if ((UserCatalog.getInstance().currentUser) != nil) {
            userNameInput.hidden = true
            passwordInput.hidden = true
            passwordLabel.hidden = true
            
            usernameLabel.stringValue = (UserCatalog.getInstance().currentUser?.username)! as String
            usernameLabel.hidden = false
            logoutButton.hidden = false
            
        }
        
    }
    
    @IBAction func login(sender: AnyObject) {
        
        let username = userNameInput.stringValue
        let password = passwordInput.stringValue
        
        UserCatalog.getInstance().login(username, password: password)
        dismissViewController(self)
    }
    
    @IBAction func logout(sender: AnyObject) {
        UserCatalog.getInstance().logout()
        dismissViewController(self)
    }
}
