//
//  ItemEntryView.swift
//  Achieve
//
//  Created by Gavin Butler on 28-11-2020.
//

import SwiftUI

struct ItemEntryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    
    //@State private var newItemDescription = ""
    
    @State private var itemDescription = ""
    
    //var item: Item?
    @Binding var itemToEdit: Item?
    
    //Remove itemToEdit != nil later - this is just here because the implementation currently doesn't populate default values on the text field
    //and this implementation could result in a save with itemDescription being empty.
    private var validEntry: Bool { itemToEdit != nil || !itemDescription.isEmpty }
    
//    init(item: Item?) {
//        self.itemToEdit = item
//        print("In init and item is:\(itemToEdit)")
//        //self._newItemDescription = State<String>(initialValue: (item?.wrappedDescription ?? ""))
//
//
//    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    TextField(itemToEdit?.itemDescription ?? "Enter Description", text: $itemDescription)
                        .padding(.horizontal, .textInset)
                        .frame(height: .itemHeight)
                        .overlay(
                            RoundedRectangle(cornerRadius: .itemCornerRadius)
                                .stroke(Color.itemColour, lineWidth: 4)
                        )
                        .foregroundColor(.itemColour)
                        .padding(.horizontal, 5)
                        
                }
                FilteredScrollView(filterKey: "itemDescription", filterPredicate: .contains, filterValue: itemDescription, itemDescription: $itemDescription)
            }
            .padding(.horizontal, .horizontalPadding)
            .padding([.top], .topPadding)
            .navigationBarItems(leading:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing:
                Button(action: {
                    saveItem()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .opacity(validEntry ? 1 : 0.5)
                }).disabled(!validEntry)
            )
            .navigationBarTitle(Text(itemToEdit != nil ? "Edit Item" : "Add Item"), displayMode: .inline)
            .foregroundColor(.itemColour)
        }
        .onAppear {
            self.itemDescription = itemToEdit?.wrappedDescription ?? ""
        }
    }

    
}

extension ItemEntryView {
    private func saveItem() {
        /*itemToEdit?.itemDescription = "Check ths out baby nexto usssssss Yes"
        self.itemToEdit?.objectWillChange.send()
        try? self.context.save()*/
        
//        guard newItemDescription != "" else { return }  //Alert in here for the user
//            item.itemDescription = newItemDescription
//            try? context.save()
            //ItemDataManager.addNewItem(newItemDescription, in: context)
        
        //print("In save method and item to edit is: \(itemToEdit)")
        
        let item = itemToEdit != nil ? itemToEdit! : Item(context: context)
        //print("In save method and item to be saved is: \(item)")
        item.id = itemToEdit != nil ? itemToEdit?.id : UUID()
        item.createdDate = itemToEdit != nil ? itemToEdit?.createdDate : Date()
        
        item.itemDescription = self.itemDescription.isEmpty ? item.itemDescription : self.itemDescription
        //print("In save method and description to be saved for item is: \(item.itemDescription)")
        //print("Which means itemToEdit.description should now be: \(itemToEdit?.itemDescription)")
        
        do {
            //print("trying to save")
            try context.save()
        } catch let error {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}

struct ItemEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEntryView(itemToEdit: .constant(Item()))
    }
}
