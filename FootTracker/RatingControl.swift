//
//  RatingControl.swift
//  FootTracker
//
//  Created by Mayte Mejia Palacios on 31/01/18.
//  Copyright © 2018 Mayte. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: Initialization
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupButtons()
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton){
        print("Button pressed")
        guard let index = ratingButtons.indexOf(button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    // MARK: Private Methods
    
    private func setupButtons(){
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        //aClass: AnyClass
        let bundle = NSBundle(forClass: object_getClass(self)) //Bundle(for: type(of: self)) for swift 3
        
        let filledStar = UIImage(named: "filledStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        //let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection) for swift 3
        let emptyStar = UIImage(named: "emptyStar", inBundle: bundle, compatibleWithTraitCollection:  self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", inBundle: bundle, compatibleWithTraitCollection: self.traitCollection)
        
        
        for index in 0..<starCount {
        
            let button = UIButton()
            //button.backgroundColor = UIColor.redColor() //red swift 3    -> auto Layout   ->rectangle
            
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(highlightedStar, forState: .Highlighted)
            button.setImage(highlightedStar, forState: [.Highlighted, .Selected])
        
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false // remove auto generate constrain
            button.heightAnchor.constraintEqualToConstant(starSize.height).active = true
            button.widthAnchor.constraintEqualToConstant(starSize.width).active = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
        
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchUpInside)
            
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating //button.isSelected = index < rating swift 3
            
            //Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            //Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 Star set."
            default: valueString = "\(rating) stars set."
            }
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
    }

}
