//
//  Settings.swift
//  Achieve
//
//  Created by Gavin Butler on 22-11-2020.
//

import SwiftUI

extension Color {
    static let itemColour = Color("ItemColour")
    static let itemTextColour = Color("ItemTextColour")
}

extension CGFloat {
    static let horizontalPadding: Self = 5                              //Horizontal buffer to side of screen
    static let verticalPadding: Self = 0                                //Vertical buffer between items
    static let topPadding: Self = 10                                    //Vertical buffer between top item and top of view (used in ItemDetailView)
    static let itemHeight: Self = 60                                    //Height of an Item cell
    static let itemCornerRadius: Self = itemHeight / 2                  //Item Rounded Rectangle corner radius
    static let textInset: Self = itemHeight / 2 - horizontalPadding     //Text inset from rounded edge of the Item
}
