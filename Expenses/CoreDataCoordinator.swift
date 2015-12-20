//
//  CoreDataCoordinator.swift
//  Expenses
//
//  Created by Patel, Ashish on 10/31/15.
//  Copyright © 2015 Ashish Patel. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataError: ErrorType{
    case FetchResult
}

class CoreDataCoordinator {
    
    internal static let sharedInstance = CoreDataCoordinator()
    
    func fetchAllFamilies() throws -> [Family] {
        
        let fetchRequest = NSFetchRequest(entityName: "Family")
        do{
            let results = try CoreDataStackManager.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest)
            return results as! [Family]
        }catch{
            throw CoreDataError.FetchResult
        }
    }
    
}