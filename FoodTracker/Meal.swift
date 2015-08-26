//
//  Meal.swift
//  FoodTracker
//
//  Created by Dmitry Parfenchik on 26/08/2015.
//
//

import UIKit

class Meal {
    // MARK: Properties
    
    var name:String
    var rating:Int
    var photo:UIImage?
    
    init?(name:String, rating:Int, photo:UIImage?) {
        self.name = name
        self.rating = rating
        self.photo = photo
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
