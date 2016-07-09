//
//  ShowInfoViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class ShowInfoViewController: NSViewController {
    
    static var instance : ShowInfoViewController?
    
    private var projects : Array<Project>
        {
        get{
            return ProjectCatalog.getInstance().getProjects()
            
        }
    }
    
    @IBOutlet weak var amountOfRequirmentsLabel: NSTextField!
    @IBOutlet weak var projectTitleLabel: NSTextField!
    @IBOutlet weak var projectManagerLabel: NSTextField!
    @IBOutlet weak var projectStartDateLabel: NSTextField!
    @IBOutlet weak var projectHumanResourceLimit: NSTextField!
    @IBOutlet weak var projectBudgetLimit: NSTextField!
    
    @IBOutlet weak var managerLabel: NSTextField!
    
    @IBOutlet weak var humanResourceLimitLabel: NSTextField!
    
    @IBOutlet weak var startDateLabel: NSTextField!
    
    @IBOutlet weak var budgetLimitLabel: NSTextField!
    
    
    
    @IBOutlet weak var projectDesciptionText: NSTextField!
    
    @IBOutlet weak var categoryLabel: NSTextField!
    
    @IBOutlet weak var categoryValueLabel: NSTextField!
    
    @IBOutlet weak var creatorLabel: NSTextField!
    
    @IBOutlet weak var creatorValueLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let selectedItem = ProjectViewController.selectedItem
        let selectedProductItem = ProjectViewController.selectedProductItem
        let selectedRequirementItem = ProjectViewController.selectedRequirementItem
        if selectedItem != nil{
            let name = selectedItem!.projectName
            let createdAt = selectedItem?.startDate
            
            projectTitleLabel.stringValue = name as String
            projectStartDateLabel.stringValue = createdAt as! String
            
            if (selectedItem != nil && selectedItem!.isProject)
            {
                categoryLabel.hidden = true
                categoryValueLabel.hidden = true
                
                amountOfRequirmentsLabel.hidden = true
                creatorLabel.hidden = true
                creatorValueLabel.hidden = true
                
                
                managerLabel.hidden = false
                humanResourceLimitLabel.hidden = false
                startDateLabel.hidden = false
                budgetLimitLabel.hidden = true
                
                projectTitleLabel.hidden = false
                projectHumanResourceLimit.hidden = false
                projectBudgetLimit.hidden = true
                
                let manager = selectedItem!.projectManager
                let humanLimit = selectedItem!.humanResourceLimit
                let budgetLimit = selectedItem!.budgetLimit
                let description = selectedItem!.projectDescription as String?
                
                if (manager != nil){
                    self.projectManagerLabel.stringValue = (manager?.username)! as String
                }
                projectHumanResourceLimit.integerValue = humanLimit!
                projectBudgetLimit.integerValue = budgetLimit!
                projectDesciptionText.stringValue = description ?? ""
                
            }
            
        }
        if selectedProductItem != nil {
            
            projectTitleLabel.hidden = true
            projectHumanResourceLimit.hidden = true
            projectBudgetLimit.hidden = true
            
            amountOfRequirmentsLabel.hidden = true
            managerLabel.hidden = true
            humanResourceLimitLabel.hidden = true
            startDateLabel.hidden = true
            budgetLimitLabel.hidden = true
            
            
            
            
            creatorLabel.hidden = false
            creatorValueLabel.hidden = false
            
            projectTitleLabel.stringValue = selectedProductItem!.title as String
            
            categoryValueLabel.stringValue = selectedProductItem!.module!.getCategory() as String
            creatorValueLabel.stringValue = ""
            var moduleCreator: [HumanResource] = []
            for c in selectedProductItem!.module!.creators{
                if (!moduleCreator.contains(c)){
                    moduleCreator.append(c)
                    creatorValueLabel.stringValue += c.name as String
                    creatorValueLabel.stringValue += "\n"
                }
                
            }
            projectDesciptionText.stringValue = selectedProductItem!.module!.moduleDescription as String
            
        }
        if selectedRequirementItem != nil{
            amountOfRequirmentsLabel.hidden = false
            projectBudgetLimit.hidden = false
            startDateLabel.hidden = false
            let name = selectedRequirementItem?.resource.name as! String
            projectTitleLabel.stringValue = name
            let amount = selectedRequirementItem?.amount
            projectBudgetLimit.integerValue = amount!
            let date = selectedRequirementItem?.createdAt
            startDateLabel.stringValue = date! as String
            
            let desc = " برای" + String(selectedRequirementItem!.estimatedUseDuration)
                + " روز لازم است."
            projectDesciptionText.stringValue = desc
        
        }
        
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewController(self)
    }
    
    @IBAction func finishTheProject(sender: AnyObject) {
    }
}
