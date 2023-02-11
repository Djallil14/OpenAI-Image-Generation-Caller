//
//  ContentView.swift
//  ImageAIGenerator
//
//  Created by Djallil on 2023-02-09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var imageViewModel = ImageGeneratorViewModel()
    @State var textPrompt = ""
    var body: some View {
        ZStack {
            AngularGradient(colors: [.purple, .pink, .purple], center: .zero)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .center) {
                    Color.gray.blendMode(.overlay)
                    if imageViewModel.isLoading {
                        ProgressView()
                    }
                }
                // Putting the image as overlay to avoid overflowing
                .overlay {
                    if !imageViewModel.images.isEmpty {
                        ForEach(imageViewModel.images) { aiimage in
                            AsyncImage(url: aiimage.imageURL) { image in
                                ZStack {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text(aiimage.prompt)
                                                .font(.headline)
                                                .minimumScaleFactor(0.4)
                                                .lineLimit(3)
                                            Spacer()
                                        }
                                        .padding()
                                        .background(.thinMaterial)
                                    }
                                }
                            } placeholder: {
                                ZStack {
                                    Color.gray.blendMode(.overlay)
                                    ProgressView()
                                }
                            }
                            .clipped()
                        }
                    }
                }
                .overlay {
                    if imageViewModel.isLoading {
                        ProgressView()
                    }
                }
                .frame(height: 500)
                .edgesIgnoringSafeArea(.top)
                
                VStack {
                    TextField("Prompt", text: $textPrompt, prompt: Text("Imagine ..."))
                        .padding()
                        .autocorrectionDisabled()
                        .background(.thickMaterial)
                        .cornerRadius(8)
                        .padding()
                    Button(action: {
                        imageViewModel.getImagesFrom(textPrompt, imageSize: .medium)
                    }) {
                        Text("Generate Images")
                            .font(.headline)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
