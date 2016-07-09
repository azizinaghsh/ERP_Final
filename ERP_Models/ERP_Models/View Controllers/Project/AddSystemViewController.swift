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
    
    @IBOutlet weak var projectListButton: NSPopUpButton!

    @IBOutlet weak var systemNameInput: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        for project in projects{
            projectListButton.addItemWithTitle(project.projectName as String)
        }
    }
    
    @IBAction func saveSystem(sender: AnyObject) {
        let selectedProject = projectListButton.selectedItem?.title
        let subSystemName = systemNameInput.stringValue
        for project in projects{
            if project.projectName == selectedProject{
                project.addSubSystem(withName: subSystemName, category: "", description: "some Description", budgetLimit: nil, humanResourceLimit: nil, managedBy: nil, entity: nil)
            }
        }
        dismissViewController(self)
    }
}
