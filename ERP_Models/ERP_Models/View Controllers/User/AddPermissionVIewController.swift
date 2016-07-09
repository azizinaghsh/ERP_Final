//
//  AddPermissionVIewController.swift
//  ERP_Models
//
//  Created by Amir on 4/15/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddPermissionVIewController: NSViewController {
    
    @IBOutlet weak var resourcePermissionView: NSButton!
    @IBOutlet weak var userPermissionView: NSButton!
    @IBOutlet weak var projectPermissionView: NSButton!
    @IBOutlet weak var requirementPermissionView: NSButton!
    @IBOutlet var setPermissionPermissionView: NSView!
    @IBOutlet weak var permissionNameInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addPermission(sender: AnyObject) {
        PermissionCatalog.getInstance().createPermission(permissionTitle: permissionNameInput!.stringValue, canCreateProject: projectPermissionView.state == 1, canCreateUser: userPermissionView.state == 1, canCreateRequriement: requirementPermissionView.state == 1, canCreateResource: resourcePermissionView.state == 1, canCreatePermission: true, permissionEntity: nil)
        dismissViewController(self)
    }
    @IBAction func dismisssPermission(sender: AnyObject) {
        dismissViewController(self)
    }
}
