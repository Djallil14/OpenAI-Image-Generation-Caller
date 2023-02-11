//
//  ImageGeneratorViewModel.swift
//  ImageAIGenerator
//
//  Created by Djallil on 2023-02-09.
//

import Foundation
@MainActor
class ImageGeneratorViewModel: ObservableObject {
    @Published var images: [AIImage] = []
    @Published var isLoading = false
    private let networkManager = OpenAINetworkManager.shared
    
    func getImagesFrom(_ prompt: String, imageSize: ImageSize) {
        isLoading = true
        Task {
            let images = try? await networkManager.generateImage(from: prompt, imageSize: imageSize)
            self.images = images ?? []
            isLoading = false
        }
    }
}
