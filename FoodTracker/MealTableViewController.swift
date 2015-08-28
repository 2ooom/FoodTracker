//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Dmitry Parfenchik on 26/08/2015.
//
//

import UIKit

class MealTableViewController: UITableViewController {
    // MARK: Properties
    var meals = [Meal]()
    
    // MARK: Constants
    let cellIdentifier = "MealTableViewCell"
    
    func loadSample() {
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "Pasta with sause", rating: 3, photo: photo1)!
        
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Vegetarian salad", rating: 3, photo: photo2)!
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Half BBQ chicken breast", rating: 5, photo: photo3)!
        
        meals += [meal1, meal2, meal3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedMeals = loadMeals() {
            meals += savedMeals
            print("loaded \(savedMeals.count) saved item(s)")
        } else {
            print("no meals saved")
            loadSample()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingCtrl.rating = meal.rating
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let ctrl = segue.destinationViewController as! MealViewController
            if let cell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(cell)!
                let meal = meals[indexPath.row]
                ctrl.meal = meal;
            }
        }
        else if (segue.identifier == "Add Item"){
            print("Adding new meal.")
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else {
            // TODO: Insert
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        if let source = sender.sourceViewController as? MealViewController, meal = source.meal {
            if let index = tableView.indexPathForSelectedRow {
                meals[index.row] = meal
                tableView.reloadRowsAtIndexPaths([index], withRowAnimation: .None)
            } else {
                let newIndex = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    
    func saveMeals() {
        let success = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !success {
            print("saving meals failed...")
        } else {
            print("saved at \(Meal.ArchiveURL.path!)")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
