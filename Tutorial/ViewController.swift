	//
//  ViewController.swift
//  Tutorial
//
//  Created by Użytkownik Gość on 01.12.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var rating: UITextField!
    
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            rating.text = String(meal.rating)
        }
        
        upadateSaveButtonState()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true;
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presetnation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigatinonController = navigationController {
            owningNavigatinonController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text="Default text";
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let name = nameTextField.text ?? ""
        let ratingTmp = Int(rating.text!)
        
        meal = Meal(name: name, rating: ratingTmp!);
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        upadateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    private func upadateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

