//
//  Extensions.swift
//  Achieve
//
//  Created by Gavin Butler on 20-12-2020.
//

import SwiftUI


extension Array {
    
    ///Returns a unique array of objects from an array of objects that may contain duplicates, using a particular property of the object
    ///to test for duplication.  Array order is preserved.
    ///
    ///Used to show a unique list of search items when a new item is being entered.
    ///
    ///Usage example:  let unique = [items].unique{$0.wrappedDescription}
    func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because *we* know it's non-nil now.
        self.init(source)!
    }
}
