//
//  ProjectViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/17/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class ProjectViewController: NSViewController {
    
    
    
    private var projects : Array<Project>
        {
        get{
            return ProjectCatalog.getInstance().getProjects()
            
        }
    }
    
    static var selectedItem: Project?
    static var selectedSystemItem : Project?
    static var selectedSubSystemItem : Project?
    static var selectedProductItem: Product?
    static var selectedRequirementItem: Requirement?
    static var selectedAllocationItem: Allocation?
    
    private var systems : Array<Project> = []
    
    private var requirements : Array<Requirement> = []
    
    private var allocations : Array<Allocation> = []
    
    private var products : Array<Product> = []
    
    private var subsystems: Array<Project> = []
    
    
    @IBOutlet weak var projectTable: NSTableView!
    
    @IBOutlet weak var systemTable: NSTableView!
    
    @IBOutlet weak var requirementTable: NSTableView!
    
    @IBOutlet weak var productTable: NSTableView!
    
    @IBOutlet weak var subSystemTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.projectTable.setDelegate(self)
        self.projectTable.setDataSource(self)
        
        self.systemTable.setDelegate(self)
        self.systemTable.setDataSource(self)
        
        self.subSystemTable.setDelegate(self)
        self.subSystemTable.setDataSource(self)
        
        self.requirementTable.setDelegate(self)
        self.requirementTable.setDataSource(self)
        
        self.productTable.setDelegate(self)
        self.productTable.setDataSource(self)
    }
    
    func selectedProject() -> Project? {
        let selectedRow = self.projectTable.selectedRow;
        if selectedRow >= 0 && selectedRow < self.projects.count {
            ProjectViewController.selectedItem = self.projects[selectedRow]
            ProjectViewController.selectedSystemItem = nil
            ProjectViewController.selectedSubSystemItem = nil
            ProjectViewController.selectedProductItem = nil
            ProjectViewController.selectedRequirementItem = nil
            return self.projects[selectedRow]
        }
        return nil
    }
    
    func selectedProduct() -> Product?{
        let selectedRow = self.productTable.selectedRow;
        if selectedRow >= 0 && selectedRow < self.products.count {
            ProjectViewController.selectedProductItem = self.products[selectedRow]
            return self.products[selectedRow]
        }
        return nil
    }
    func selectedRequirement() -> Requirement? {
        let selectedRow = self.requirementTable.selectedRow;
        if selectedRow >= 0 && selectedRow < self.requirements.count {
            ProjectViewController.selectedRequirementItem = self.requirements[selectedRow]
            return self.requirements[selectedRow]
        } else if (selectedRow >= 0 && selectedRow < self.requirements.count + self.allocations.count)
        {
            ProjectViewController.selectedAllocationItem = self.allocations[selectedRow - requirements.count]
        }
        return nil
    }
    func selectedSystem() -> Project? {
        let selectedRow = self.systemTable.selectedRow;
        if selectedRow >= 0 && selectedRow < self.systems.count {
            ProjectViewController.selectedSystemItem = self.systems[selectedRow]
            ProjectViewController.selectedSubSystemItem = nil
            ProjectViewController.selectedProductItem = nil
            ProjectViewController.selectedRequirementItem = nil
            return self.systems[selectedRow]
        }
        return nil
    }
    
    func selectedSubSystem() -> Project? {
        let selectedRow = self.subSystemTable.selectedRow
        if (selectedRow >= 0 && selectedRow < self.subsystems.count)
        {
            ProjectViewController.selectedSubSystemItem = self.subsystems[selectedRow]
            ProjectViewController.selectedProductItem = nil
            ProjectViewController.selectedRequirementItem = nil
            return self.subsystems[selectedRow]
        }
        return nil
    }
    
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        if (aTableView == self.projectTable)
        {
            return self.projects.count
        }
        else if(aTableView == self.systemTable)
        {
            return self.systems.count
        }
        else if(aTableView == self.requirementTable)
        {
            return self.requirements.count + allocations.count
        }else if(aTableView == self.productTable){
            return self.products.count
        }
        else if (aTableView == self.subSystemTable)
        {
            return self.subsystems.count
        }
        else{
            return 0
        }
    }
    
    func showNextItems<T>(clickedItem: T){
        
        if (clickedItem is Project){
            if ((clickedItem as! Project).isProject)
            {
                requirements.removeAll()
                allocations.removeAll()
                systems.removeAll()
                subsystems.removeAll()
                products.removeAll()
                
                systems = (clickedItem as! Project).subProjects
                requirements = (clickedItem as! Project).requirements
                allocations = (clickedItem as! Project).allocations
                products = (clickedItem as! Project).products
                
                requirementTable.reloadData()
                systemTable.reloadData()
                productTable.reloadData()
                subSystemTable.reloadData()
            }
            else if ((clickedItem as! Project).isSystem)
            {
                requirements.removeAll()
                subsystems.removeAll()
                allocations.removeAll()
                products.removeAll()
                
                subsystems = (clickedItem as! Project).subProjects
                requirements = (clickedItem as! Project).requirements
                allocations = (clickedItem as! Project).allocations
                products = (clickedItem as! Project).products
                
                requirementTable.reloadData()
                subSystemTable.reloadData()
                productTable.reloadData()
            }
            else
            {
                requirements.removeAll()
                products.removeAll()
                allocations.removeAll()
                
                requirements = (clickedItem as! Project).requirements
                allocations = (clickedItem as! Project).allocations
                products = (clickedItem as! Project).products
                
                requirementTable.reloadData()
                productTable.reloadData()
            }
        }
        else if clickedItem is Product{
            //            productTable.reloadData()
        }
        else if clickedItem is ProjectResourceRelationship{
            //            requirementTable.reloadData()
        }
    }
    
    
    @IBAction func reloadTables(sender: AnyObject) {
        projectTable.reloadData()
        systemTable.reloadData()
        subSystemTable.reloadData()
        requirementTable.reloadData()
        productTable.reloadData()
        
    }
    
    @IBAction func removeProduct(sender: AnyObject) {
        if selectedProduct() != nil{
            //            ProjectCatalog.getInstance()
            
            
            // 3. Remove the selected row from the table view
            self.productTable.removeRowsAtIndexes(NSIndexSet(index:self.productTable.selectedRow),
                                                  withAnimation: NSTableViewAnimationOptions.SlideRight)
        }
    }
    @IBAction func removeRequirement(sender: AnyObject) {
    }
    @IBAction func removeSubsystem(sender: AnyObject) {
    }
    @IBAction func removeSystem(sender: AnyObject) {
    }
    @IBAction func removeProject(sender: AnyObject) {
        
        if selectedProject() != nil{
            //            ProjectCatalog.getInstance()
            
            
            // 3. Remove the selected row from the table view
            self.projectTable.removeRowsAtIndexes(NSIndexSet(index:self.projectTable.selectedRow),
                                                  withAnimation: NSTableViewAnimationOptions.SlideRight)
        }
    }
    @IBAction func allocateRequirement(sender: AnyObject) {
        if let requirement = ProjectViewController.selectedRequirementItem{
            requirement.tryRequirement()
        }
        requirementTable.reloadData()
    }
    
    @IBAction func freeResourceFromProject (sender: AnyObject) {
        if let allocation = ProjectViewController.selectedAllocationItem{
            allocation.freeResource()
        }
        requirementTable.reloadData()
    }
}

extension ProjectViewController: NSTableViewDataSource {
    
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if tableView == self.projectTable{
            let project = self.projects[row]
            cellView.textField!.stringValue =  project.projectName as String
            return cellView
        }
        if tableView == self.systemTable{
            let system = self.systems[row]
            cellView.textField!.stringValue = system.projectName as String
        }
        else if tableView == self.requirementTable{
            if (row < requirements.count)
            {
                let requirement = self.requirements[row]
                cellView.textField!.stringValue = requirement.resource.name as String
            }
            else
            {
                let allocation = self.allocations[row - requirements.count]
                if (allocation.isCurrent)
                {
                    cellView.textField!.stringValue = allocation.resource.name as String
                    cellView.textField?.textColor = NSColor.init(red: 0.37, green: 0.72, blue: 0.38, alpha: 1)
                }
                else
                {
                    cellView.textField!.stringValue = allocation.resource.name as String
                    cellView.textField?.textColor = NSColor.init(red: 0.72, green: 0.37, blue: 0.37, alpha: 1)
                }
            }
            
        }
        else if tableView == self.subSystemTable{
            let subsystem = self.subsystems[row]
            cellView.textField!.stringValue = subsystem.projectName as String
        }
        else if tableView == self.productTable{
            let product = self.products[row]
            cellView.textField!.stringValue = product.module!.name as String
        }
        return cellView
        
    }
    
}


extension ProjectViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        switch ((notification.object?.identifier)! as String) {
        case "projectTable":
            if( projectTable.selectedRow>=0){
                let sellectedProject = selectedProject()
                showNextItems(sellectedProject!)
            }
        case "systemTable":
            if( systemTable.selectedRow>=0){
                let sellectedSystem = selectedSystem()
                showNextItems(sellectedSystem!)
            }
        case "subSystemTable":
            if( subSystemTable.selectedRow>=0){
                let sellectedSubSystem = selectedSubSystem()
                showNextItems(sellectedSubSystem)
            }
        case "productTable":
            if( productTable.selectedRow>=0){
                let sellectedProduct = selectedProduct()
                showNextItems(sellectedProduct)
            }
        case "requirementTable":
            if( requirementTable.selectedRow>=0){
                let sellectedRequirement = selectedRequirement()
                showNextItems(sellectedRequirement)
            }
        default:
            print("Wrong Table")
        }
    }
}