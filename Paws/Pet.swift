//
//  Pet.swift
//  Paws
//
//  Created by Vadim Vinogradov on 5/5/25.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        
        container.mainContext.insert(Pet(name: "Rexy"))
        container.mainContext.insert(Pet(name: "Bela"))
        container.mainContext.insert(Pet(name: "Charly"))
        container.mainContext.insert(Pet(name: "daisy"))
        container.mainContext.insert(Pet(name: "Fido"))
        container.mainContext.insert(Pet(name: "Gus"))
        container.mainContext.insert(Pet(name: "Mimi"))
        container.mainContext.insert(Pet(name: "Luna"))
        
        return container
    }
}
