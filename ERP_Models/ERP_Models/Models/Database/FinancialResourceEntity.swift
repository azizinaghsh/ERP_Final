//
//  FinancialResourceEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class FinancialResourceEntity: QuantitativeResourceEntity {
    
    override func setupEntity(object: NSObject) {
        let financialResource = object as! FinancialResource
        self.myCategory = (ResourceCatalog.getInstance().getResourceEntitiesCategories(resourceClassName: String(FinancialResource), categoryName: financialResource.getCategory() as String)?[0] as! FinancialResourceCategoriesEntity)
        self.totalAmount = financialResource.totalAmount
        self.name = financialResource.name as String
        self.allocatedAmount = financialResource.allocatedAmount
        self.dateAdded = financialResource.dateAdded as String
    }
    
    override class func getMyType () -> String
    {
        return "FinancialResource"
    }
}
