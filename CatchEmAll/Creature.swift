//
//  Creature.swift
//  CatchEmAll
//
//  Created by Bob Witmer on 2023-08-07.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    
    var name: String
    var url: String     // url for detail on each Pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
