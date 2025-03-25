//
// ContentView.swift
// CachingAPIResponseSwiftData
//
// Created by MANAS VIJAYWARGIYA on 25/03/25.
// ------------------------------------------------------------------------
//
// ------------------------------------------------------------------------
//


import SwiftUI
import SwiftData

struct ContentView: View {
  @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Photo.id) private var photos: [Photo]
  @State private var isLoading: Bool = false
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(photos, id: \.id) { item in
          VStack(alignment: .leading) {
            AsyncImage(url: .init(string: item.thumbnailUrl)) { image in
              image.resizable().scaledToFill().frame(maxWidth: .infinity).frame(height: 300).clipped()
            } placeholder: {
              ProgressView()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            Text(item.title).font(.caption).bold().padding(.horizontal).padding(.top)
          }
          .padding(.bottom).background(.white).clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .listRowSeparator(.hidden).listRowBackground(Color.clear)
      }
      .navigationTitle("Posts")
      .listStyle(.plain).scrollContentBackground(.hidden).background(Color(uiColor: .systemGroupedBackground))
      .task {
        do {
          isLoading = true
          defer { isLoading = false }
          if hasExceededFetchLimit() || photos.isEmpty {
            try clearPhotos()
            try await fetchPhotos()
          }
        } catch {
          print(error)
        }
      }
      .overlay {
        if isLoading {
          ProgressView()
        }
      }
    }
  }
}

@Model
class Photo: Codable {
  
  @Attribute(.unique)
  var id: Int?
  
  let albumId: Int
  let title: String
  let url: String
  let thumbnailUrl: String
  
  enum CodingKeys: String, CodingKey {
    case albumId
    case id
    case title
    case url
    case thumbnailUrl
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.albumId = try container.decode(Int.self, forKey: .albumId)
    self.id = try container.decode(Int?.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.url = try container.decode(String.self, forKey: .url)
    self.thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
  }
  
  func encode(to encoder: Encoder) throws {
    // TODO: Handle encoding if you need to here
  }
}

private extension ContentView {
  func clearPhotos() throws {
    _ = try modelContext.delete(model: Photo.self)
    try? modelContext.save()
  }
  
  func fetchPhotos() async throws {
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
    let request = URLRequest(url: url)
    let (data, _) = try await URLSession.shared.data(for: request)
    
    let photos = try JSONDecoder().decode([Photo].self, from: data)
    
    photos.forEach { modelContext.insert($0) }
    try? modelContext.save()
    
    lastFetched = Date.now.timeIntervalSince1970
    print("API_CALLED")
  }
  
  func hasExceededFetchLimit() -> Bool {
    let timeLimit = 300 // 5 mins
    let currentTime = Date.now
    let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
    
    guard let differenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else {
      return false
    }
    
    return differenceInMins >= timeLimit
  }
}

#Preview {
  ContentView().modelContainer(for: [Photo.self])
}
