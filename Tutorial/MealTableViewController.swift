//
//  MealTableViewController.swift
//  Tutorial
//
//  Created by Admin on 12/9/17.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleMeals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell
        let meal = meals[indexPath.row]
        
        // Configure the cell...
        cell!.nameLabel.text = meal.name
        cell!.ratingLabel.text = String(meal.rating)
        return cell!
    }

    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddItem":
                os_log("Adding a new meal. ", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                let mealdDetailedViewController = segue.destination as? ViewController
            
                let selectedMealCell = sender as? MealTableViewCell
            
                let indexPath = tableView.indexPath(for: selectedMealCell!)
            
                let selectedMeal = meals[(indexPath?.row)!]
                mealdDetailedViewController?.meal = selectedMeal
            
            default:
                fatalError("Unexpected Seque Identifier; \(segue.identifier)")
        }
    }
 
    
    
    private func loadSampleMeals() {
        let meal1 = Meal(name: "Name 1", rating: 111)
        let meal2 = Meal(name: "Name 2", rating: 222)
        let meal3 = Meal(name: "Name 3", rating: 333)
        
        meals += [meal1, meal2, meal3];
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as?
            ViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing meal.
                
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
            
                let newIndexPath = IndexPath(row: meals.count, section: 0)
            
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
            
    }

}
