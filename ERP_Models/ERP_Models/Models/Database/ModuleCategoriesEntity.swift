//
//  ModuleResourceCategoriesEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class ModuleCategoriesEntity: CategoriesEntity {
    
    override class func getMyType () -> String
    {
        return "ModuleCategories"
    }
}
