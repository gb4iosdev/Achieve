//
//  Item+CoreDataProperties.swift
//  Achieve
//
//  Created by Gavin Butler on 19-12-2020.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var itemDescription: String?
    @NSManaged public var createdDate: Date?
    
    var wrappedDescription: String {
        itemDescription ?? ""
    }
    
}

extension Item : Identifiable {
    
    static func item(withId id: String, in context: NSManagedObjectContext) -> Item? {
        let fetchReq: NSFetchRequest<Item> = Self.fetchRequest()
        let predicate = NSPredicate(format: "id \(Predicate.equals.rawValue) %@", id)
        fetchReq.predicate = predicate
        
        if let items = try? context.fetch(fetchReq) as [Item] {
            return items.first
        } else {
            return nil
        }
    }
}
