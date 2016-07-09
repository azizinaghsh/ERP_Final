//
//  UserRegisterationViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/15/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class UserRegisterationViewController: NSViewController {

    @IBOutlet weak var firstNameInput: NSTextField!
    
    @IBOutlet weak var lastNameInput: NSTextField!
    
    @IBOutlet weak var userNameInput: NSTextField!
    
    @IBOutlet weak var passwordInput: NSTextField!
   
    @IBOutlet weak var permissionSetter: NSPopUpButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let permissions = PermissionCatalog.getInstance().permissions
        for permission in permissions {
            permissionSetter.addItemWithTitle(permission.title as String)
        }
    }
    
    @IBAction func addUser(sender: AnyObject) {
        let newUser = UserCatalog.getInstance().addUser(withFirstName: firstNameInput.stringValue, lastName: lastNameInput.stringValue, andUserName: userNameInput.stringValue, withPassword: passwordInput.stringValue, entity: nil)
        newUser?.setPermission(PermissionCatalog.getInstance().getPermission(withTitle: (permissionSetter.selectedItem?.title)!)!)
        dismissViewController(self)

    }
}
