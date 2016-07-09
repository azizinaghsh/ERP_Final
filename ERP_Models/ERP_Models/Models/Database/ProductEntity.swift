//
//  ProductEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/8/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class ProductEntity: Entity {

    override func setupEntity(object: NSObject) {
        self.module = (object as! Product).module?.myEntity as! ModuleEntity?
        
    }
    
    override class func getMyType () -> String
    {
        return "Product"
    }
}
