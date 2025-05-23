//
//  ContentView.swift
//  Paws
//
//  Created by Vadim Vinogradov on 5/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query private var pets: [Pet]
  
  let layout = [
    GridItem(.flexible(minimum: 120)),
    GridItem(.flexible(minimum: 120))
  ]
  
  
  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVGrid(columns: layout) {
          GridRow {
            ForEach(pets) { pet in
              NavigationLink(destination: EmptyView()) {
                VStack {
                  
                  if let imageData = pet.photo {
                    if let image = UIImage(data: imageData) {
                      Image(uiImage: image)
                      
                    }
                  } else {
                    Image(systemName: "pawprint.circle")
                      .resizable()
                      .scaledToFit()
                      .padding(40)
                      .foregroundStyle(.quaternary)
                  }
                  
                  Spacer()
                  
                  Text(pet.name)
                    .font(.title.weight(.light))
                    .padding(.vertical)
                  
                  Spacer()
                } //: VSTACK
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                
              } //: NAVLINK
              .foregroundStyle(.primary)
            } //: LOOP
          } //: GRID ROW
        } //: GRID LAYOUT
        .padding(.horizontal)
      } //: SCROLLVIEW
      .navigationTitle(pets.isEmpty ? "" : "Paws")
      .overlay {
        if pets.isEmpty {
          CustomContentUnavailableView(icon: "dog.circle", title: "No Pets", description: "Add a new pet to get started.")
        }
      }
    } //: NAVSTACK
  }
}

#Preview("Sample Data") {
  ContentView()
    .modelContainer(Pet.preview)
}

#Preview("No Data") {
  ContentView()
    .modelContainer(for: Pet.self, inMemory: true)
}
