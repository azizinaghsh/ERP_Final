//
//  AddDeveloperViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/16/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddDeveloperViewController: NSViewController {
    
    
    @IBOutlet weak var listOfDevelopers: NSPopUpButton!
    
    @IBOutlet weak var developersLabel: NSTextField!
    
    static var instance : AddDeveloperViewController?
    var developers : [HumanResource] = []
    
    override func viewDidLoad() {
        AddDeveloperViewController.instance = self
        super.viewDidLoad()
        // Do view setup here.
        let allResource = ResourceCatalog.getInstance().getAllResources()
        var humanResources : [HumanResource] = []
        for resource in allResource
        {
            if (resource is HumanResource)
            {
                humanResources.append(resource as! HumanResource)
            }
        }
        
        for human in humanResources
        {
            listOfDevelopers.addItemWithTitle(human.name as String)
        }
        
        
        
    }
    
    @IBAction func addDeveloper(sender: AnyObject) {
        
        let selectedDeveloper = listOfDevelopers.selectedItem?.title
        print(selectedDeveloper)
        
        let allResource = ResourceCatalog.getInstance().getAllResources()
        var humanResources : [HumanResource] = []
        for resource in allResource
        {
            if (resource is HumanResource && resource.name==selectedDeveloper )
            {
                if (!developers.contains(resource as! HumanResource))
                {
                    humanResources.append(resource as! HumanResource)
                    developers.append(resource as! HumanResource)
                    developersLabel.stringValue += (resource.name as String)
                    developersLabel.stringValue += "\n"
                }
                
            }
        }
    }
}
