//
//  ResourceViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/15/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class ResourceViewController: NSViewController {
    static var sellectedResource : Resource?
    private var resources : Array<Resource>
        {
        get{
            return ResourceCatalog.getInstance().getAllResources()
            
        }
    }
    
    
    @IBOutlet weak var resourceTableView: NSTableView!
    
    @IBOutlet weak var resourceNameView: NSTextField!
    
    @IBOutlet weak var resourceCategoryView: NSTextField!
    
    @IBOutlet weak var totalAmount: NSTextField!
    
    @IBOutlet weak var dateAdded: NSTextField!
    
    @IBOutlet weak var allocatedAmountView: NSTextField!
    
    
    @IBOutlet weak var estimatedReleaseTime: NSTextField!
    @IBOutlet weak var remainedAmountView: NSTextField!
    
    @IBOutlet weak var totalAmountLabel: NSTextField!
    
    @IBOutlet weak var allocatedAmountLabel: NSTextField!
    
    @IBOutlet weak var remainedAmountLabel: NSTextField!
    
    @IBOutlet weak var showMaintenanceButton: NSButton!
    @IBOutlet weak var maintenanceButton: NSButton!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var descriptionFieldView: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ResourceCatalog.getInstance().getSampleResources()
        
        // Do view setup here.
    }
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.resources.count
    }
    
    func resouceSelector()-> Resource? {
        let selectedRow = self.resourceTableView.selectedRow;
        if selectedRow >= 0 && selectedRow < self.resources.count {
            return self.resources[selectedRow]
        }
        return nil
    }
    
    @IBAction func removeResource(sender: AnyObject) {
        if let selectedResouce = resouceSelector(){
            ResourceCatalog.getInstance().removeResource(selectedResouce)
            
            
            // 3. Remove the selected row from the table view
            self.resourceTableView.removeRowsAtIndexes(NSIndexSet(index:self.resourceTableView.selectedRow),
                                                   withAnimation: NSTableViewAnimationOptions.SlideRight)
            
            // 4. Clear detail info
            showResourceInfo(nil)
        }
    }
    
    @IBAction func reloadTable(sender: AnyObject) {
        resourceTableView.reloadData()
    }
    
    func showResourceInfo(resource: Resource?){
        var name = ""
        var category = ""
        var dateAdded = ""
        var releaseTime : String?
        if let resourceInfo = resource{
            name = resourceInfo.name as String
            category = resourceInfo.getCategory() as String
            dateAdded = resourceInfo.dateAdded as String
            releaseTime = (resourceInfo.getEstimatedRelease() as? String)
            // now we show them
            
            self.resourceNameView.stringValue = name
            self.resourceCategoryView.stringValue = category
            self.dateAdded.stringValue = dateAdded
            self.estimatedReleaseTime.stringValue = releaseTime != nil ? releaseTime! : ""
        
            
            totalAmount.hidden = true
            allocatedAmountView.hidden = true
            remainedAmountView.hidden = true
            
            totalAmountLabel.hidden = true
            allocatedAmountLabel.hidden = true
            remainedAmountLabel.hidden = true
            
            if resourceInfo is QuantitativeResource{
                descriptionLabel.hidden = true
                descriptionFieldView.hidden = true
                maintenanceButton.hidden = true
                showMaintenanceButton.hidden = true
                
                totalAmount.hidden = false
                allocatedAmountView.hidden = false
                remainedAmountView.hidden = false
                
                totalAmountLabel.hidden = false
                allocatedAmountLabel.hidden = false
                remainedAmountLabel.hidden = false
                
                self.totalAmount.integerValue = (resourceInfo as! QuantitativeResource).totalAmount
                self.allocatedAmountView.integerValue = (resourceInfo as! QuantitativeResource).allocatedAmount
                self.remainedAmountView.integerValue = (resourceInfo as! QuantitativeResource).remainedAmount
                
            }else if resourceInfo is Module{
                totalAmount.hidden = true
                allocatedAmountView.hidden = true
                remainedAmountView.hidden = true
                
                totalAmountLabel.hidden = true
                allocatedAmountLabel.hidden = true
                remainedAmountLabel.hidden = true
                
                descriptionLabel.hidden = false
                descriptionFieldView.hidden = false
                maintenanceButton.hidden = false
                showMaintenanceButton.hidden = false
                
            
                
                descriptionFieldView.stringValue = (resourceInfo as! Module).moduleDescription as String
            }
        }else{
            totalAmount.stringValue = ""
            allocatedAmountView.stringValue = ""
            remainedAmountView.stringValue = ""
            resourceNameView.stringValue = ""
            resourceCategoryView.stringValue = ""
            
        }
    }
    
    
}

extension ResourceViewController: NSTableViewDataSource {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView

        if tableColumn!.identifier == "ResourceColumn" {
            
            let resource = self.resources[row]
            cellView.textField!.stringValue = resource.name as String
            return cellView
        }
        
        return cellView
    }
    
}


extension ResourceViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        ResourceViewController.sellectedResource = resouceSelector()
        print(ResourceViewController.sellectedResource)

        showResourceInfo(ResourceViewController.sellectedResource)
    }
}