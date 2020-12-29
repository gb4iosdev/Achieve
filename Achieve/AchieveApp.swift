//
//  AchieveApp.swift
//  Achieve
//
//  Created by Gavin Butler on 21-11-2020.
//

import SwiftUI

@main
struct AchieveApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            AchieveMainView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
