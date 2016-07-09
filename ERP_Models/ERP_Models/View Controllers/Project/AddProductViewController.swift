//
//  AddProductViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddProductViewController: NSViewController {

    @IBOutlet weak var productNameInput: NSTextField!
    
    @IBOutlet weak var productCategory: NSTextField!
    @IBOutlet weak var creatorsListInput: NSPopUpButton!
    
    @IBOutlet weak var productDescriptionText: NSTextField!
    
    @IBOutlet weak var productCreatorsLabel: NSTextField!
    
    private var resources : Array<Resource>
        {
        get{
            return ResourceCatalog.getInstance().getAllResources()
            
        }
    }
    var creators : [HumanResource] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for res in resources{
            if (res is HumanResource){
                creatorsListInput.addItemWithTitle(res.name as String)
            }
        }
        // Do view setup here.
        
    }
    
    @IBAction func creatorSelected(sender: AnyObject) {
        let selectedCreator = (creatorsListInput.selectedItem?.title)! as String
        for res in resources{
            if (res is HumanResource && res.name == selectedCreator){
                
                if (!creators.contains(res as! HumanResource))
                {
                    creators.append(res as! HumanResource)
                    creators.append(res as! HumanResource)
                    productCreatorsLabel.stringValue += (res.name as String)
                    productCreatorsLabel.stringValue += "\n"
                }
            }
        }
        
        
    }
    @IBAction func addProduct(sender: AnyObject) {
        let project = ProjectViewController.selectedItem
        let name = productNameInput.stringValue as String

        let description = productDescriptionText.stringValue as String
        let category = productCategory.stringValue as String
        
        project?.createProduct(withName: name, withDescription: description, productCreatorsAre: creators, category: category, entity: nil)
        
        dismissViewController(self)
        
    }
}
