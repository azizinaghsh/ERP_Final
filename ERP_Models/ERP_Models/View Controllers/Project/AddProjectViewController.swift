//
//  AddProjectViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddProjectViewController: NSViewController {

    @IBOutlet weak var newProjectName: NSTextField!
    
    @IBOutlet weak var newProjectBudget: NSTextField!
    
    @IBOutlet weak var newProjectHumanResource: NSTextField!
    
    @IBOutlet weak var newProjectManager: NSPopUpButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let users = UserCatalog.getInstance().getSampleUsers()
        for user in users{
            newProjectManager.addItemWithTitle(user.username as String)
        }
        
    }
    
    @IBAction func saveProject(sender: AnyObject) {
        let name = newProjectName.stringValue
        let budget = newProjectBudget.integerValue
        let humanResource = newProjectHumanResource.integerValue
    
        let manager = newProjectManager.selectedItem?.title
        
        let user = UserCatalog.getInstance().FindUser(manager!)
        
        ProjectCatalog.getInstance().addProject(withName: name, category: "", describedAs: "some description", budgetLimit: budget, humanResourceLimit: humanResource, isManagedBy: user, entity: nil)
        dismissViewController(self)
        
    }
}
