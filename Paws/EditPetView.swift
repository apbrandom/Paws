//
//  EditPetView.swift
//  Paws
//
//  Created by Vadim Vinogradov on 5/10/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
  @Binding var pet: Pet
  @State private var photosPickerItem: PhotosPickerItem?
  
  var body: some View {
    Form {
      //MARK: - INMAGE
      if let imageData = pet.photo {
        if let image = UIImage(data: imageData) {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
        }
      } else {
        CustomContentUnavailableView(
          icon: "pawprint.circle",
          title: "No Photo",
          description: "Add a photo of your favorite pet to make it easer t ifind them."
        )
        .padding(.top)
      }
      
      //MARK: - PHOTO PICKER
      PhotosPicker(selection: $photosPickerItem, matching: .images) {
        Label("Select a Photo", systemImage: "photo.badge.plus")
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .listRowSeparator(.hidden)
      
      //MARK: - TEXT FILED
      TextField("Name", text: $pet.name)
        .textFieldStyle(.roundedBorder)
        .font(.largeTitle.weight(.light))
        .padding(.vertical)
      
      //MARK: - BUTTON
      Button {
      } label: {
        Text("Save")
          .font(.title3.weight(.medium))
          .padding(8)
          .frame(minWidth: 0, maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      
    } //: FORM
    .listStyle(.plain)
    .navigationTitle("Edit \(pet.name)")
    .navigationBarTitleDisplayMode(.inline)
    .onChange(of: photosPickerItem) {
      Task {
        pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
      }
    }
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Pet.self, configurations: configuration)

  let sampleData = Pet(name: "Daisy")

  container.mainContext.insert(sampleData)

  return NavigationStack {
    EditPetView(pet: .constant(sampleData))
      .modelContainer(container)
  }
}
