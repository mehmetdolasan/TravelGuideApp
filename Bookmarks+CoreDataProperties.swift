//
//  Bookmarks+CoreDataProperties.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 4.10.2022.
//
//

import Foundation
import CoreData


extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?

}

extension Bookmarks : Identifiable {

}
