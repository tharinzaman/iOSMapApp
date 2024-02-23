//
//  StaticLoader.swift
//  MapAppTests
//
//  Created by Tharin Zaman on 21/02/2024.
//

import Foundation

struct StaticLoader {
    
    static func loadJSONFromFileReturnData(
        file: String
    ) -> Data? {
        guard let path = Bundle.main.path(
            forResource: file,
            ofType: "json"
        ) else {
            fatalError("Invalid path")
        }
        guard let data = FileManager.default.contents(
            atPath: path
        ) else {
            fatalError("No data for path")
        }
        return data
    }
    
    static func loadJSONFromFileReturnDecodedData(
        file: String
    ) -> RandomLocation {
        
        guard let path = Bundle.main.path(
            forResource: file,
            ofType: "json"
        ) else {
            fatalError("Invalid path")
        }
        
        guard let data = FileManager.default.contents(
            atPath: path
        ) else {
            fatalError("No data for path")
        }
        
        do {
            return try JSONDecoder().decode(
                RandomLocationModel.self,
                from: data
            ).location
        } catch {
            fatalError("Invalid data")
        }
    }
    
}
