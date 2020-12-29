//
//  ContentView.swift
//  Achieve
//
//  Created by Gavin Butler on 21-11-2020. 
//

import SwiftUI

struct AchieveMainView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.createdDate, ascending: false)],
        animation: .default)
        private var items: FetchedResults<Item>
    
    @State private var showItemEntryView = false
    @State private var itemToEdit: Item?
    
    var body: some View {
        NavigationView {
            Group {
                if !items.isEmpty {
                    ZStack {
                        BackgroundView()
                        ScrollView {
                                VStack {
                                    ForEach(items, id: \.id) { item in
                                        Section {   //Only used because .contextMenu doesn't play with NavigationLink
                                            NavigationLink(destination: ItemDetailView(item: item)) {
                                                //If I pass the item itself through to the ItemView here the main list view will not
                                                //reflect the item update for some reason - not sure why.  If I pass the item.wrappedDescription
                                                //the main list view is refreshed for an update.
                                                ItemView(itemDescription: item.wrappedDescription)
                                            }
                                        }
                                        .contextMenu {
                                            Button(action: {
                                                withAnimation { ItemDataManager.deleteItem(item, from: context) } })
                                            {
                                                Text("Delete")
                                                Image(systemName: "xmark")
                                            }
                                            Button(action: {
                                                showItemEntryView.toggle() })
                                            {
                                                Text("Add Item")
                                                Image(systemName: "plus")
                                            }
                                            Button(action: {
                                                self.itemToEdit = item
                                                showItemEntryView.toggle()
                                            })
                                            {
                                                Text("Edit Item")
                                                Image(systemName: "pencil")
                                            }
                                        }
                                    }
                                }
                                .padding(.top, topPadding)
                            }
                    }
                } else {
                    VStack {
                        Text("Tap to Add")
                        Image(systemName: "tray.and.arrow.down.fill")
                            .resizable()
                            .frame(width: 200, height: 200)
                            
                    }
                    .foregroundColor(Color.secondary.opacity(0.25))
                }
            }
            .sheet(isPresented: $showItemEntryView, onDismiss: { self.itemToEdit = nil }) {
                ItemEntryView(itemToEdit: $itemToEdit).environment(\.managedObjectContext, context)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.showItemEntryView = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                    }
                }
            )
            .navigationBarTitle(Text("Achieve"), displayMode: .inline)
            .foregroundColor(.itemColour)
        }
    }
    
    //MARK: Drawing Constants
    let topPadding: CGFloat = 10
}

struct ContentView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    static var previews: some View {
        AchieveMainView().environment(\.managedObjectContext, context)
    }
}
