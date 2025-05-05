//
//  PawsApp.swift
//  Paws
//
//  Created by Vadim Vinogradov on 5/5/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
