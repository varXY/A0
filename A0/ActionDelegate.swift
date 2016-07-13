//
//  ActionDelegate.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ActionDelegate {
    var appDelegate: UIApplicationDelegate { get }
    var managedContext: NSManagedObjectContext { get }
    
    func getAllActions() -> [[String]]
    func saveAction(content: [String], done: () -> ())
    func editAction(content: [String])
}

extension ActionDelegate {
    
    var appDelegate: UIApplicationDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedContext: NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    func getAllActions() -> [[String]] {
        var actions = [[String]]()
        
        let fetchRequest = NSFetchRequest(entityName: "Action")
        fetchRequest.entity = NSEntityDescription.entityForName("Action", inManagedObjectContext: managedContext)
        
        do {
            if let results = try managedContext.executeFetchRequest(fetchRequest) as? [Action] {
                results.forEach({
                    let action: [String] = ["\($0.id!)", "\($0.status!)", $0.name!, $0.goal!, $0.result!, $0.conclusion!]
                    actions.append(action)
                })
            }
        } catch {
            print("can't get actions")
        }
        
        print("get \(actions.count) saved actions")
        return actions
    }
    
    func saveAction(content: [String], done: () -> ()) {
        let entity = NSEntityDescription.entityForName("Action", inManagedObjectContext: managedContext)
        let action = Action(entity: entity!, insertIntoManagedObjectContext: managedContext)
        action.id = NSDate().dateID() as NSNumber
        action.status = Int(content[1])! as NSNumber
        action.name = content[2]
        action.goal = content[3]
        action.result = content[4]
        action.conclusion = content[5]
        
        do {
            try managedContext.save()
            done()
            print("action  saved")
        } catch {
            print("can't save action")
        }
    }
    
    func editAction(content: [String]) {
        let fetchRequest = NSFetchRequest(entityName: "Action")
        fetchRequest.entity = NSEntityDescription.entityForName("Action", inManagedObjectContext: managedContext)
        fetchRequest.predicate = NSPredicate(format:"id == %@", Int(content[0])! as NSNumber)
        
        do {
            if let actions = try managedContext.executeFetchRequest(fetchRequest) as? [Action] {
                actions[0].status = Int(content[1])! as NSNumber
                actions[0].name = content[2]
                actions[0].goal = content[3]
                actions[0].result = content[4]
                actions[0].conclusion = content[5]
            }
        } catch {
            print("can't get existed action")
        }
        
        do {
            try managedContext.save()
            print("acton edited")
        } catch {
            print("can't edit existed action")
        }
    }
    
}

