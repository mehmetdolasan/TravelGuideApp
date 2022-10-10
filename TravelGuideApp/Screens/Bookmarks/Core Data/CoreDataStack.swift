//
//  CoreDataStack.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 4.10.2022.
//

import CoreData
import Foundation

class CoreDataStack {
  
  private let modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  //MARK: Create a container
  private lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modelName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Unsuccesfull container loading ...\(error.localizedDescription)")
      }
    }
    return container
  }()
  
  lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
  
  func saveContext() {
    
    guard managedContext.hasChanges else {
      return
    }
    
    do {
      try managedContext.save()
      print("Successfully saved")
    } catch let error as NSError {
      print("Unresolved error \(error)")
    }
    
  }
  
}
