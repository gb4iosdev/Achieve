//
//  ContentView.swift
//  Achieve
//
//  Created by Gavin Butler on 21-11-2020. 
//

import SwiftUI

struct AchieveMainView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.createdDate, ascending: false)]) var items: FetchedResults<Item>
    
    @State private var showItemEntryView = false
    //@State private var showItemEntryViewWithItem = false
    @State private var itemToUpdate: Item?
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                        VStack {
                            ForEach(items, id: \.id) { item in
                                Section {   //Only used because .contextMenu doesn't play with NavigationLink
                                    NavigationLink(destination: ItemDetailView(item: item)) {
                                        ItemView(item: item)
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
                                        showItemEntryView = true })
                                    {
                                        Text("Add Item")
                                        Image(systemName: "plus")
                                    }
                                    Button(action: {
                                            print("item is \(item)")
                                            self.itemToUpdate = item
                                            /*showItemEntryViewWithItem = true*/ })
                                    {
                                        Text("Edit Item")
                                        Image(systemName: "pencil")
                                    }
                                }
                                .sheet(item: $itemToUpdate) { item in
                                    ItemEntryView(item: item).environment(\.managedObjectContext, context)
                                }
                            }
                            
                        }
                        .padding(.top, topPadding)
                        .navigationBarItems(trailing:
                            Button(action: {
                                self.showItemEntryView = true
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                }
                            }
                        )
                    }
                .navigationBarTitle(Text("Achieve"), displayMode: .inline)
                .foregroundColor(.itemColour)
            }
            
        }
        .sheet(isPresented: $showItemEntryView) {
            ItemEntryView(item: itemToUpdate).environment(\.managedObjectContext, context)
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


struct TextEditingView: View {
    @State private var fullText: String = "This is some editable text..."
    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        TextEditor(text: $fullText)
            .font(.body)
            .lineSpacing(5)
    }
}

struct EditableTextRow: View {
    
    @State var text: String = "This is the Editable Text Row"
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .padding([.leading, .trailing], 5)
                .padding([.top, .bottom], 8)
                .foregroundColor(Color.clear)
            TextEditor(text: self.$text)
                .background(
                    Color.blue
                )
        }
    }
}
