//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Dmitry Parfenchik on 25/08/2015.
//
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating:Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var spacing = 5
    var stars = 5
    
    var ratingButtons = [UIButton]()
    let buttonSize = 44
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let filledImage = UIImage(named: "filledStar")
        let emptyImage = UIImage(named: "emptyStar")
        
        for _ in 0..<stars {
            let btn = UIButton()
            btn.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            
            btn.setBackgroundImage(emptyImage, forState: .Normal)
            btn.setBackgroundImage(filledImage, forState: .Selected)
            btn.setBackgroundImage(filledImage, forState: [.Selected, .Highlighted])
            
            btn.adjustsImageWhenHighlighted = false
            
            ratingButtons.append(btn)
            addSubview(btn)
        }
    }
    
    override func layoutSubviews() {
        var rect = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, btn) in ratingButtons.enumerate() {
            rect.origin.x = CGFloat(index * (buttonSize + spacing))
            btn.frame = rect
        }
        updateButtonSelectionStates()
    }
    
    // MARK: Actions
    
    func ratingButtonTapped(button:UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, btn) in ratingButtons.enumerate() {
            btn.selected = index < rating
        }
    }
}
