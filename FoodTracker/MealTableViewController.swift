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
        loadSample()
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
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        let source = sender.sourceViewController as! MealViewController
        let meal = source.meal!
        let newIndex = NSIndexPath(forRow: meals.count, inSection: 0)
        meals.append(meal)
        tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation: .Bottom)
    }
}
