//
//  Decoder.swift
//  ThemNewMovies
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class Decoder: NSObject {
    
    // -----
    // Method used to decode network returned data into model structs
    // -----
    class func decodeJSON<T:Decodable>(withData data: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let value = try decoder.decode(T.self, from: data)
            return value
        } catch {
            return nil
        }
    }

}
