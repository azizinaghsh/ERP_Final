//
//  UserViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/15/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class UserViewController: NSViewController {
    
    private var users : Array<User>
    {
        get{
            return UserCatalog.getInstance().users
            
        }
    }
    
    @IBOutlet weak var userTableView: NSTableView!

    
    @IBOutlet weak var fnameField: NSTextFieldCell!
    
    @IBOutlet weak var lnameField: NSTextField!
    @IBOutlet weak var unameField: NSTextField!
    @IBOutlet weak var titleField: NSTextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCatalog.getInstance().getSampleUsers()
        
        
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.users.count
    }
    
    func sellecteduser() -> User? {
        let selectedRow = self.userTableView.selectedRow;
        if selectedRow >= 0 && selectedRow < self.users.count {
            return self.users[selectedRow]
        }
        return nil
    }
    
    @IBAction func reload(sender: AnyObject) {
        userTableView.reloadData()
    }
    
    
    @IBAction func removeUser(sender: AnyObject) {
        if let sellectedUser = sellecteduser(){
            UserCatalog.getInstance().removeUser(sellectedUser)
            
            
            // 3. Remove the selected row from the table view
            self.userTableView.removeRowsAtIndexes(NSIndexSet(index:self.userTableView.selectedRow),
                                                       withAnimation: NSTableViewAnimationOptions.SlideRight)
            
            // 4. Clear detail info
            showUserInfo(nil)
        }
    }
    
    func showUserInfo(user: User?){
        var firstname = ""
        var lastname = ""
        var username = ""
        var permission = ""
        
        if let userInfo = user{
            firstname = userInfo.firstName as String
            lastname = userInfo.lastName as String
            username = userInfo.username as String
            permission = userInfo.userPermission.title as String
            // now we show them 
            
            self.fnameField.stringValue = firstname
            self.lnameField.stringValue = lastname
            self.unameField.stringValue = username
            self.titleField.stringValue = permission
        }
    }

   
}

extension UserViewController: NSTableViewDataSource {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn!.identifier == "UsersColumn" {
            
            let user = self.users[row]
            cellView.textField!.stringValue = user.firstName as String + " " + (user.lastName as String) as String
            return cellView
        }
        
        return cellView
    }

    }


extension UserViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let sellectedUser = sellecteduser()
        showUserInfo(sellectedUser)
    }
}