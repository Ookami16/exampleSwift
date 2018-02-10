//
//  Meal.swift
//  FootTracker
//
//  Created by Mayte Mejia Palacios on 31/01/18.
//  Copyright © 2018 Mayte. All rights reserved.
//

import UIKit
import os
class Meal: NSObject {
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int){
        // Initialization shound fail if there is no name or if the rating is negative
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: NSCoding
    /*func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)    //encode(name, forKey: PropertyKey.name)   swift 3
        aCoder.encodeObject(photo, forKey: PropertyKey.photo)
        aCoder.encodeObject(rating, forKey: PropertyKey.rating)
        
    }*/
    /*required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey:  PropertyKey.name) as? String
            else {
                return nil
            }
    }*/

}
