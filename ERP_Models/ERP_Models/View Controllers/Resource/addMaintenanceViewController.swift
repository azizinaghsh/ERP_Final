//
//  addMaintenanceViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/16/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa


class addMaintenanceViewController: NSViewController {
    
    @IBOutlet weak var maintenanceName: NSTextField!
    
    @IBOutlet weak var maintainersList: NSPopUpButton!
    
    @IBOutlet weak var maintainersLabel: NSTextField!
    
    @IBOutlet weak var descriptionTextInput: NSTextField!
    
    @IBOutlet weak var maintenanceDate: NSDatePicker!
    
    static var instance : addMaintenanceViewController?
    var maintainers : [HumanResource] = []
    
    override func viewDidLoad() {
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
            maintainersList.addItemWithTitle(human.name as String)
        }
    }
    
    @IBAction func addMaintainer(sender: AnyObject) {
        let selectedMaintainer = maintainersList.selectedItem?.title
        
        
        let allResource = ResourceCatalog.getInstance().getAllResources()
        var humanResources : [HumanResource] = []
        for resource in allResource
        {
            if (resource is HumanResource && resource.name==selectedMaintainer )
            {
                if (!maintainers.contains(resource as! HumanResource))
                {
                    humanResources.append(resource as! HumanResource)
                    maintainers.append(resource as! HumanResource)
                    maintainersLabel.stringValue += (resource.name as String)
                    maintainersLabel.stringValue += "\n"
                }
                
            }
        }
    }
    
    @IBAction func cancelMaintenance(sender: AnyObject) {
        dismissViewController(self)
    }
    @IBAction func saveMaintenance(sender: AnyObject) {
        let name = maintenanceName.stringValue
        let description = descriptionTextInput.stringValue
        let date = maintenanceDate.stringValue
        
        
        (ResourceViewController.sellectedResource as! Module).addMaintenance(TitleIs: name, withMaintainers: maintainers, description: description, andDate: date)
        dismissViewController(self)
    }
}
