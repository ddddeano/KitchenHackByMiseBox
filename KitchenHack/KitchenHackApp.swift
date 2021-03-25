//
//  KitchenHackApp.swift
//  KitchenHack
//
//  Created by Daniel Watson on 25/02/2021.
//

import SwiftUI
import CoreData
@main
struct KitchenHack: App {
    @Environment(\.scenePhase) var scenePhase
    
    var model = IngredientControlModel()
    
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, pC.viewContext)
                .environmentObject(model)
        }
        .onChange(of: scenePhase) { _ in
            try? pC.viewContext.save()
        }
    }
}
    var pC: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "KitchenHack")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    func saveContext() {
        let context = pC.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
