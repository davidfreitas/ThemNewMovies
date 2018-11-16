//
//  ModelDecoder.swift
//  ThemNewMovies
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class ModelDecoder {
    
    // -----
    // Method used to decode network returned data into model structs
    // -----
    class func decodeJSON<T:Decodable>(withData data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        // Set up api date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let value = try decoder.decode(T.self, from: data)
            return value
        } catch {
            throw error
        }
    }

}
