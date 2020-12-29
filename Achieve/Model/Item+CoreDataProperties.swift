//
//  Item+CoreDataProperties.swift
//  Achieve
//
//  Created by Gavin Butler on 19-12-2020.
//
//

import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var itemDescription: String?
    @NSManaged public var createdDate: Date?
    
}

extension Item : Identifiable {
    
    var wrappedDescription: String { itemDescription ?? "Unknown description" }
    var wrappedId: UUID { id ?? UUID() }
    
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
