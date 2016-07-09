//
//  Product.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/2/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Product: NSObjectStored {
    var module : Module?
    var title : String
    
    init (withName name : NSString, withDescription description : NSString, productCreatorsAre creators : [HumanResource], category: NSString, entity: ProductEntity?)
    {
        module = Module (moduleName: name, withDescription: description, moduleCreators: creators, category: category, entity: entity?.module)
        self.title = name as String
        super.init(ProductEntity.self, entity: entity, saveContext: false)
    }
    
    init (entity : ProductEntity)
    {
        self.title = entity.title!
        super.init(ProductEntity.self, entity: entity)
    }
    
    func produce ()
    {
        if (module != nil)
        {
            module!.dateAdded = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
            ResourceCatalog.getInstance().addResource(module!)
            (myEntity as! ProductEntity).module = nil
            do {try myEntity?.managedObjectContext?.save()} catch{ fatalError("failed to produce module") }
        }
    }
}
