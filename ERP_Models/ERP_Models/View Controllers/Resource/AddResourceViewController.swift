//
//  AddResourceViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/16/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddResourceViewController: NSViewController {

    @IBOutlet weak var resourceNameInput: NSTextField!
    
    @IBOutlet weak var resourceClassInput: NSPopUpButton!
    
    @IBOutlet weak var resourceCategoryInput: NSPopUpButton!
    
    @IBOutlet weak var additionalLabel: NSTextField!

    @IBOutlet weak var descriptionField: NSTextField!
    @IBOutlet weak var totalAmountView: NSTextField!
    
    @IBOutlet weak var physicalResourceCodeInput: NSTextField!
    
    @IBOutlet weak var roomNumberInput: NSTextField!
    
    @IBOutlet weak var roomNumberLabel: NSTextField!
    
    
    @IBOutlet weak var addDeveloperButton: NSButton!
    
    @IBOutlet weak var resourceCodeLabel: NSTextField!
    

    
    @IBOutlet weak var newCategoryInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    let classNames: [String] = [String(FinancialResource),String(HumanResource),String(PhysicalResource),String(Module)]
    
    @IBAction func addNewCategory(sender: AnyObject) {
        let type = resourceClassInput.selectedItem
        let name = newCategoryInput.stringValue
        let index =  (type!.tag as Int)
        ResourceCatalog.getInstance().addCategory(classNames[index-1], newCategory: name)
        resourceCategoryInput.addItemWithTitle(name)
        resourceCategoryInput.selectItem(resourceCategoryInput.itemWithTitle(name))
        newCategoryInput.stringValue = ""
        
    }
    @IBAction func removeCategory(sender: AnyObject) {
        let type = resourceClassInput.selectedItem
        let name = resourceCategoryInput.selectedItem?.title
        let index =  (type!.tag as Int)
        ResourceCatalog.getInstance().removeCategory(classNames[index-1], category: name!)
        resourceCategoryInput.removeItemWithTitle(name!)
    }

    @IBAction func addResouceButton(sender: AnyObject) {
        
        let category = (resourceCategoryInput.selectedItem?.title)!
        let resourceName = resourceNameInput.stringValue
        
        let type = resourceClassInput.selectedItem
        
        switch (type!.tag as Int) {
        case 1:
            let newFinancialResouce = FinancialResource(name: resourceName, totalAmount: totalAmountView.integerValue, category: category)
            ResourceCatalog.getInstance().addResource(newFinancialResouce)
        case 2:
            let newHumanResource = HumanResource(name: resourceName, totalAmount: totalAmountView.integerValue, category: category)
            ResourceCatalog.getInstance().addResource(newHumanResource)
        case 3:
            let newPhysicalResource = PhysicalResource(category: category, name:resourceName, physicalResourceCode: physicalResourceCodeInput.stringValue, roomNumber: roomNumberInput.integerValue)
            ResourceCatalog.getInstance().addResource(newPhysicalResource)
        case 4:
            let creators = AddDeveloperViewController.instance!.developers
            let description = descriptionField.stringValue
            let newModule = Module(moduleName: resourceName, withDescription: description, moduleCreators: creators, category: category, entity: nil)
            ResourceCatalog.getInstance().addResource(newModule) 
        default:
            print("You would never see me!")
        }
        print(ResourceCatalog.getInstance().getAllResources())
    }
   
    @IBAction func resourceTypeClicked(sender: AnyObject) {
        
        let type = ((sender as! NSPopUpButton).selectedItem?.tag)! as Int
        
        switch (type) {
        case 1:
            resourceCategoryInput.removeAllItems()
            let categories = ResourceCatalog.getInstance().getCategories(String(FinancialResource))
            for cat in categories{
                resourceCategoryInput.addItemWithTitle(cat)
            }
            totalAmountView.hidden = false
            additionalLabel.hidden = false
            physicalResourceCodeInput.hidden = true
            roomNumberInput.hidden = true
            roomNumberLabel.hidden = true
            resourceCodeLabel.hidden = true
            addDeveloperButton.hidden = true
            descriptionField.hidden = true
        case 2:
            resourceCategoryInput.removeAllItems()
            let categories = ResourceCatalog.getInstance().getCategories(String(HumanResource))
            for cat in categories{
                resourceCategoryInput.addItemWithTitle(cat)
            }
            totalAmountView.hidden = false
            additionalLabel.hidden = false
            physicalResourceCodeInput.hidden = true
            resourceCodeLabel.hidden = true
            
            roomNumberInput.hidden = true
            roomNumberLabel.hidden = true
            addDeveloperButton.hidden = true
            descriptionField.hidden = true
        case 3:
            resourceCategoryInput.removeAllItems()
            let categories = ResourceCatalog.getInstance().getCategories(String(PhysicalResource))
            for cat in categories{
                resourceCategoryInput.addItemWithTitle(cat)
            }
            totalAmountView.hidden = true
            additionalLabel.hidden = true
            addDeveloperButton.hidden = true
            descriptionField.hidden = true
            
            physicalResourceCodeInput.hidden = false
            resourceCodeLabel.hidden = false
            roomNumberInput.hidden = false
            roomNumberLabel.hidden = false
        case 4:
            resourceCategoryInput.removeAllItems()
            let categories = ResourceCatalog.getInstance().getCategories(String(Module))
            for cat in categories{
                resourceCategoryInput.addItemWithTitle(cat)
            }
            addDeveloperButton.hidden = false
            descriptionField.hidden = false
            
            totalAmountView.hidden = true
            additionalLabel.hidden = true
            resourceCodeLabel.hidden = true
            physicalResourceCodeInput.hidden = true
            
            roomNumberInput.hidden = true
            roomNumberLabel.hidden = true
            
        default:
            print("You would never see me!")
        }
    
    }
}
