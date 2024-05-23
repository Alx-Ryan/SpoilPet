    ////
    ////  NekoImage.swift
    ////  SpoilPet
    ////
    ////  Created by Alex Ryan on 5/4/24.
    ////

import SwiftUI
import Combine

struct Root: Codable {
    let items: [NekoImage2]
}

struct NekoImage2: Codable, Identifiable, Hashable {
let id: Int
let rating: String?
let sample_url: String?
let tags: [Tag]
    
        // Implement hashValue
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Combine with any other properties that contribute to uniqueness
    }
    
        // Implement the equality operator
    static func == (lhs: NekoImage2, rhs: NekoImage2) -> Bool {
        return lhs.id == rhs.id // Assuming 'id' is enough for equality
    }
}

    //MARK: - Tag
struct Tag: Codable, Hashable {
    let id: Int
    let name, description, sub: String
    let isNsfw: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, description, sub
        case isNsfw = "is_nsfw"
    }
}

class CombineVM: ObservableObject {
    
    @Published var catImages: [NekoImage2] = []
    @Published var imageName: [NekoImage2] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchRandomCatImage()
    }
    
    private func fetchRandomCatImage() {
        guard let url = URL(string: "https://api.nekosapi.com/v3/images/random") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, _ in
                return data
            }
            .decode(type: Root.self, decoder: JSONDecoder()) // Decodes a single image
            .map { $0.items }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching image: \(error)")
                }
            }, receiveValue: { images in
                self.catImages = Array(images.prefix(20)) // Limit to 20 items
                
            })
            .store(in: &cancellables)
    }
    
}

    //                            // Display details of the first tag only
    //                        if let firstTag = uniqueImage.tags.first {
    //                            VStack(alignment: .leading) {
    //                                Text("Name: \(firstTag.name)")
    //                                Text("Description: \(firstTag.description)")
    //                                Text("NSFW: \(firstTag.isNsfw)")
    //                            }
    //                            
    //                        } else {
    //                            Text("No Tags Available")
    //                        }
    //                        Text("\(uniqueImage.sample_url ?? "")")
