//
//  ItemEntryView.swift
//  Achieve
//
//  Created by Gavin Butler on 28-11-2020.
//

import SwiftUI

struct ItemEntryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var context
    
    @State private var newItemDescription = ""
    
    let item: Item?
    
    init(item: Item?) {
        self.item = item
        print("In init and item is:\(item)")
        self._newItemDescription = State(initialValue: (item?.wrappedDescription ?? ""))
        
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    TextField("", text: $newItemDescription)
                        .padding(.horizontal, .textInset)
                        .frame(height: .itemHeight)
                        .overlay(
                            RoundedRectangle(cornerRadius: .itemCornerRadius)
                                .stroke(Color.itemColour, lineWidth: 4)
                        )
                        .foregroundColor(.itemColour)
                        .padding(.horizontal, 5)
                        
                }
                FilteredScrollView(filterKey: "itemDescription", filterPredicate: .contains, filterValue: newItemDescription, itemDescription: $newItemDescription)
            }
            .padding(.horizontal, .horizontalPadding)
            .padding([.top], .topPadding)
            .navigationBarItems(leading:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing:
                Button("Save") {
                    saveItem()
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .navigationBarTitle(Text("Item Entry"), displayMode: .inline)
            .foregroundColor(.itemColour)
        }
    }

    func saveItem() {
        guard newItemDescription != "" else { return }  //Alert in here for the user
        if let item = self.item {
            item.itemDescription = newItemDescription
            try? context.save()
        } else {
            ItemDataManager.addNewItem(newItemDescription, in: context)
        }
    }
}

//struct ItemEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemEntryView(item: Binding<Item?>())
//    }
//}
