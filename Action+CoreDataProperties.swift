//
//  Action+CoreDataProperties.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Action {

    @NSManaged var status: NSNumber?
    @NSManaged var name: String?
    @NSManaged var goal: String?
    @NSManaged var result: String?
    @NSManaged var conclusion: String?
    @NSManaged var id: NSNumber?

}
