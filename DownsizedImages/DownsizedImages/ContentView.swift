//
// ContentView.swift
// DownsizedImages
//
// Created by MANAS VIJAYWARGIYA on 17/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationStack {
        List {
          HStack {
            ForEach(1...3, id: \.self) { index in
              let size = CGSize(width: 150, height: 150)
              let id = "pic\(index)"
              DownsizedImageView(id: id, image: UIImage(named: id), size: size) { image in
                GeometryReader {
                  let size = $0.size
                  image.resizable().aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .frame(height: 150)
              }
            }
          }
          .frame(maxWidth: .infinity)
        }
        .navigationTitle("Downsized Image View")
      }
    }
}

#Preview {
    ContentView()
}

struct DownsizedImageView<Content: View>: View {
  var id: String
  var image: UIImage?
  var size: CGSize
  
  @ViewBuilder var content: (Image) -> Content
  @State private var downsizedImageView: Image?
  
  var body: some View {
    ZStack {
      if let downsizedImageView {
        content(downsizedImageView)
      } else {
        ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
    .onAppear {
      guard downsizedImageView == nil else { return }
      createDownsizedImage(image)
    }
    .onChange(of: image) { oldValue, newValue in
      guard oldValue != newValue else { return }
      createDownsizedImage(newValue)
    }
  }
  
  /// Creating Downsized Image
  private func createDownsizedImage(_ image: UIImage?) {
    if let cacheData = try? CacheManager.shared.get(id: id)?.data, let uiImage = UIImage(data: cacheData) {
      downsizedImageView = .init(uiImage: uiImage)
      print("From Cache")
    } else {
      print("Downsizing Image...")
      guard let image else { return }
      let aspectSize = image.size.aspectFit(size)
      /// Generating a smaller version of the image in a separate thread so that it will affect the main thread while it's generating.
      Task.detached(priority: .high) {
        let renderer = UIGraphicsImageRenderer(size: aspectSize)
        let resizedImage = renderer.image { ctx in
          image.draw(in: .init(origin: .zero, size: aspectSize))
        }
        
        /// Storing Cache Data
        if let jpegData = resizedImage.jpegData(compressionQuality: 1) {
          /// Since CacheManage is MainActor, it should run on MainActor
          await MainActor.run {
            try? CacheManager.shared.insert(id: id, data: jpegData, expirationDays: 1)
          }
        }
        
        /// Updating UI on main thread
        await MainActor.run {
          downsizedImageView = .init(uiImage: resizedImage)
        }
      }
    }
  }
}

extension CGSize {
  /// This func return a new size that fits the given size in an aspect ratio
  func aspectFit(_ to: CGSize) -> CGSize {
    let scaleX = to.width / self.width
    let scaleY = to.height / self.height
    
    let aspectRatio = min(scaleX, scaleY)
    return .init(width: aspectRatio * width, height: aspectRatio * height)
  }
}
