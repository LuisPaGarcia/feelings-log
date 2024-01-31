//
//  AppDelegate.swift
//  Feelings Log
//
//  Created by Luis García on 30/01/24.
//

import Foundation
import CoreData
import UIKit


// Managed Object Context
var managedObjectContext: NSManagedObjectContext = {
    return persistentContainer.viewContext
}()

// Persistent Container
var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FeelingsModel")
    container.loadPersistentStores { storeDescription, error in
        if let error = error as NSError? {
            // Manejar el error adecuadamente
            fatalError("Error al cargar el store de Core Data: \(error), \(error.userInfo)")
        }
    }
    return container
}()


func applicationWillTerminate(_ application: UIApplication) {
    saveContext()
}

func saveContext () {
    if managedObjectContext.hasChanges {
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Error al guardar el contexto de Core Data: \(nserror), \(nserror.userInfo)")
        }
    }
}
