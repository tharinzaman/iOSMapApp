//
//  RandomLocation.swift
//  MapApp
//
//  Created by Tharin Zaman on 20/02/2024.
//

import Foundation

// Maybe add in identifiable or equatable, probably no need as we only get one item and not a list/array of items
struct RandomLocationModel: Decodable {
    let nearest: Nearest
}

struct Nearest: Decodable {
    let latt: String
    let longt: String
    let name: String
}
