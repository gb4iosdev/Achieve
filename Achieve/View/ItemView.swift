//
//  ItemView.swift
//  Achieve
//
//  Created by Gavin Butler on 21-11-2020.
//

import SwiftUI

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: .itemCornerRadius)
                .foregroundColor(.itemColour)
                .frame(height: .itemHeight)
            
            Text(item.itemDescription!)
                .foregroundColor(.itemTextColour)
                .padding(.leading, .textInset)
        }
        .padding(.horizontal, .horizontalPadding)
        .padding(.vertical, .verticalPadding)
        .opacity(0.8)
        
    }
    
    
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item()
        item.itemDescription = "Testing"
        return ItemView(item: item)
    }
}
