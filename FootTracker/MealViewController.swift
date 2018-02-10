//
//  ViewController.swift
//  FootTracker
//
//  Created by Mayte Mejia Palacios on 30/01/18.
//  Copyright © 2018 Mayte. All rights reserved.
//

import UIKit
import os

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            //photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //Enable the save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        //mealNameLabel.text = textField.text
        //print(textField.text)
        saveButton.enabled = false
        updateSaveButtonState()
        navigationItem.title = textField.text
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dissmiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else{
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from ther photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil) // present swift 3.0
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil) //dismiss(animated: true, completion: nil) swift 3

        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewControllerAnimated(true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        super.prepareForSegue(segue, sender: sender) //super.prepare(for: segue, sender: sender)    swift 3
        guard let button = sender as? UIBarButtonItem where button === saveButton else {
            //os_log("The save button was not pressed, cancelling", log: customLog, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image ?? nil
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController afetr the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
        
        
    }
    /*@IBAction func setDefaultLabelText(sender: UIButton) {
     
        mealNameLabel.text = "Default Text"
        
    }*/
    // MARK: Private Methods
    private func updateSaveButtonState(){
        let text = nameTextField.text ?? "" // if nameTextField doesn´t containt anything then is equal to ""
        saveButton.enabled = !text.isEmpty // text diferente de vacío
    }


}

