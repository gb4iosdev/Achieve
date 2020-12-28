//
//  ItemMenu.swift
//  Achieve
//
//  Created by Gavin Butler on 27-12-2020.
//

import SwiftUI
import CoreData

struct ItemMenu: View {
    let item: Item
    let context: NSManagedObjectContext
    @Binding var showItemEntryView: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                ItemDataManager.deleteItem(item, from: context)
            }
        }) {
            Text("Delete")
            Image(systemName: "xmark")
        }
        Button(action: {
            showItemEntryView = true
        }) {
            Text("Add Item")
            Image(systemName: "plus")
        }
    }
}

struct ItemMenu_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        ItemMenu(item: Item(), context: context, showItemEntryView: .constant(true))
    }
}
