//
//  ViewController.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/24/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    static var instance : UserRegisterationViewController?
    
    @IBOutlet weak var loginButton: NSButton!
    
    override func viewDidLoad() {
        let loginView = LoginViewController()
        loginView.viewDidLoad()
        
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

