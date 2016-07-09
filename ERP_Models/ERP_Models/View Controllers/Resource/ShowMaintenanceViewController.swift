//
//  ShowMaintenanceViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/17/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class ShowMaintenanceViewController: NSViewController {

    @IBOutlet weak var maintenanceNameLabel: NSPopUpButton!
    
    @IBOutlet weak var modificationDateLabel: NSTextField!
    
    @IBOutlet weak var maintainersLabel: NSTextField!
    
    @IBOutlet weak var maintenanceDescriptionTextField: NSTextField!
    
    static var instance : addMaintenanceViewController?
    var maintainers : [HumanResource] = []
    
    var maintenances : Array<Maintenance> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let allResource = ResourceCatalog.getInstance().getAllResources()
        for resource in allResource
        {
            if(resource is Module && resource.name==(ResourceViewController.sellectedResource as! Module).name)
            {
                maintenances = (resource as! Module).maintenances
            }
        }
        
        for maintenance in maintenances
        {
            maintenanceNameLabel.addItemWithTitle(maintenance.title as String)
        }
        
        //we have to show first maintenace info
        if (maintenances.count>0)
        {
            showInfo(maintenances[0])
        }
        
    }
    
    func showInfo(maintenance: Maintenance){
        modificationDateLabel.stringValue = maintenance.modificationDate as String
         maintainersLabel.stringValue = " "
        for maintainer in maintenance.maintainers
        {
            maintainersLabel.stringValue += maintainer.name as String
            maintainersLabel.stringValue += "، "
        }
        maintenanceDescriptionTextField.stringValue = maintenance.describe as String
    }
    
    @IBAction func maintenanceChanged(sender: AnyObject) {
        var maintenance: Maintenance
        for maintain in maintenances{
            if(maintain.title == maintenanceNameLabel.selectedItem?.title)
            {
             maintenance = maintain
             showInfo(maintenance)
            }
        }
    }
    
}
