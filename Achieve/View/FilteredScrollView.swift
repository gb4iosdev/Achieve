//
//  FilteredScrollView.swift
//  Achieve
//
//  Created by Gavin Butler on 19-12-2020.
//

import CoreData
import SwiftUI

struct FilteredScrollView: View {
    var request: FetchRequest<Item>
    var items: [Item] {
        Array(request.wrappedValue).unique(by: { $0.wrappedDescription })
    }
    @Binding var newItemDescription: String
    
    var body: some View {
        ScrollView {
            ForEach(items, id: \.self) { item in
                ItemView(item: item)
                    .onTapGesture {
                        self.newItemDescription = item.wrappedDescription
                    }
            }
        }
    }
    
    init(filterKey: String,
         filterPredicate: Predicate,
         filterValue: String,
         sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \Item.createdDate, ascending: false)],
         itemDescription: Binding<String>)
    {
        self.request = FetchRequest<Item>(entity: Item.entity(), sortDescriptors:sortDescriptors,
                                          predicate: NSPredicate(format: "%K \(filterPredicate.rawValue)[c] %@", filterKey, filterValue))
        self._newItemDescription = itemDescription
    }
}
