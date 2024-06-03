//
//  PhotoPickerVM.swift
//  SpoilPet
//
//  Created by Alex Ryan on 6/1/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
final class PhotoPickerVM: ObservableObject {

    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }

    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                selectedImage = uiImage
            } catch {
                print(error)
            }
        }
    }
}
