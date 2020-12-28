//
//  ItemDataManager.swift
//  Achieve
//
//  Created by Gavin Butler on 22-11-2020.
//

import SwiftUI
import CoreData

class ItemDataManager: ObservableObject {
    
    static var exampleItem: Item {
        let item = Item()
        item.itemDescription = "Testing"
        return item
    }
    
    static func addNewItem(_ description: String, in context: NSManagedObjectContext) {
        let item = Item(context: context)
        item.id = UUID()
        item.itemDescription = description
        item.createdDate = Date()
        try? context.save()
    }
    
    static func deleteItem(_ item: Item, from context: NSManagedObjectContext) {
        context.delete(item)
        try? context.save()
    }
    
//    static func itemsMatching(_ searchFilter: String) -> [Item] {
//        self.items.filter {
//            $0.description.range(of: searchFilter, options: .caseInsensitive) != nil
//        }
//    }
}
