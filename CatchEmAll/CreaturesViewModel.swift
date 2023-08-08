//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Bob Witmer on 2023-08-04.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?    // Optional to handle null case
        var results: [Creature]
    }
    
    @Published var urlString: String = "https://pokeapi.co/api/v2/pokemon"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    
    func getData() async {
        print("🕸️ We are accessing the URL \(urlString)")
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from:  url)
            
            // Try to decode JSON data into our out data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""    // Optional to handle null case
            self.creaturesArray += returned.results
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response --> \(error.localizedDescription)")
        }
    }
}
