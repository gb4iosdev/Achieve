//
//  ItemDetailView.swift
//  Achieve
//
//  Created by Gavin Butler on 28-11-2020.
//

import SwiftUI

struct ItemDetailView: View {
    
    let item: Item
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ItemView(item: item)
                Spacer()
            }
            .padding(.top, .topPadding)
            .navigationBarTitle("Item Detail", displayMode: .inline)
        }
    }
    
    
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return ItemDetailView(item: ItemDataManager.exampleItem)
    }
}
