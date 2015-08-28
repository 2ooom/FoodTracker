//
//  Meal.swift
//  FoodTracker
//
//  Created by Dmitry Parfenchik on 26/08/2015.
//
//

import UIKit

class Meal : NSObject, NSCoding {
    // MARK: Properties
    
    var name:String
    var rating:Int
    var photo:UIImage?
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    init?(name:String, rating:Int, photo:UIImage?) {
        
        self.name = name
        self.rating = rating
        self.photo = photo
        
        super.init()
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MAKR: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKeys.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKeys.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKeys.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKeys.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKeys.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKeys.ratingKey)
        self.init(name: name, rating: rating, photo:photo)
    }
    
    // MARK: Types
    
    struct PropertyKeys {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        
    }
}
