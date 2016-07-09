//
//  AddSystemViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddSystemViewController: NSViewController {
    private var projects : Array<Project>
        {
        get{
            return ProjectCatalog.getInstance().getProjects()
        }
    }
    var currentProject: Project?
    var currentSystem: Project?
    @IBOutlet weak var systemDescriptionInput: NSTextField!
    
    @IBOutlet weak var systemNameInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let project = ProjectViewController.selectedItem
        if let system = ProjectViewController.selectedSystemItem{
            currentSystem = system
        }
        currentProject = project
        // Do view setup here.
    }
    
    @IBAction func saveSystem(sender: AnyObject) {
        let selectedProject = currentProject
        let subSystemName = systemNameInput.stringValue
        let description = systemDescriptionInput.stringValue
        
        if let addButton = ((sender as! NSButton) as NSButton?){
            if addButton is AddSystemButtonClass{
                selectedProject!.addSubSystem(withName: subSystemName, isSystem: true, category: currentProject!.category, description: description, budgetLimit: nil, humanResourceLimit: nil, managedBy: nil, entity: nil)
                
            }
            else{
                currentSystem!.addSubSystem(withName: subSystemName, isSystem: true, category: currentProject!.category, description: description, budgetLimit: nil, humanResourceLimit: nil, managedBy: nil, entity: nil)
            }
            
        }
        dismissViewController(self)
    }
}
