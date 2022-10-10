//
//  BookmarksModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import CoreData
import Foundation

protocol BookmarksModelProtocol: AnyObject {
  
  func didFetchProcessFinish(_ isSuccess: Bool)
  
}

class BookmarksModel {
  
  weak var delegate: BookmarksModelProtocol?
  
  //entity variable
  var bookmarks: [Bookmarks] = []
  
  func fetchData() {
  
    let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
    
    do {
      let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
      let results = try context.fetch(fetchRequest)
      bookmarks = results
      delegate?.didFetchProcessFinish(true)
      print(results.map { $0.name })
    } catch  {
      delegate?.didFetchProcessFinish(false)
      print(error.localizedDescription)
    }
  }
}
  
