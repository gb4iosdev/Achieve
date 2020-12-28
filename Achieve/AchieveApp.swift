//
//  AchieveApp.swift
//  Achieve
//
//  Created by Gavin Butler on 21-11-2020.
//

import SwiftUI

@main
struct AchieveApp: App {
    let context = PersistenceController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            //AchieveMainView(dataManager: modelManager).environment(\.managedObjectContext, persistenceController.container.viewContext)
            AchieveMainView().environment(\.managedObjectContext, context)
        }
    }
}
