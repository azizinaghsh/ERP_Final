//
//  AddRequirementViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddRequirementViewController: NSViewController {

    @IBOutlet weak var resourceListButton: NSPopUpButton!
    @IBOutlet weak var selectedProjectHierarchyLabel: NSTextField!
    
    @IBOutlet weak var estimatedTime: NSTextField!
    @IBOutlet weak var numberOfRequirement: NSTextField!
    
    var currentProject: Project?
    private var resources : Array<Resource>
        {
        get{
            return ResourceCatalog.getInstance().getAllResources()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let project = ProjectViewController.selectedItem
        currentProject = project
        if (project != nil){
            selectedProjectHierarchyLabel.stringValue = (project?.projectName)! as String
            for res in resources{
                resourceListButton.addItemWithTitle(res.name as String)
            }
            
        }
        
        // Do view setup here.
    }
    
    @IBAction func addRequirement(sender: AnyObject) {
        for res in resources{
            if(res.name == resourceListButton.selectedItem?.title){
                let numberOfReq = numberOfRequirement.integerValue
                let estimated = estimatedTime.integerValue
                
                currentProject!.createRequirement(forResource: res, withAmount: numberOfReq, estimatedToBeUsed: estimated, entity: nil)
                
            }
        }
        
    }
    
}
