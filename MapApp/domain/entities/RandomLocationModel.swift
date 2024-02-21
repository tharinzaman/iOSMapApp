//
//  RandomLocation.swift
//  MapApp
//
//  Created by Tharin Zaman on 20/02/2024.

import Foundation

struct RandomLocationModel: Decodable {
    
    let location: RandomLocation
    
    enum CodingKeys: String, CodingKey {
        case location = "nearest"
    }
}

struct RandomLocation: Decodable {
    let lat: String
    let long: String
    var name: String // This is a var instead of let as we want to change it in case Combine fails
    
    enum CodingKeys: String, CodingKey {
        case lat = "latt"
        case long = "longt"
        
        case name
    }
}
