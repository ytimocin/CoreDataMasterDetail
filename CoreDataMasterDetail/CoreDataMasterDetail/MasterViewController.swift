//
//  MasterViewController.swift
//  MasterDetail-CoreData-1
//
//  Created by Jason on 3/9/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

/**
 * Five steps to using Core Data to persist MasterDetail:
 *
 * 1. Add a convenience method that find the shared context
 * 2. Add fetchAllEvents()
 * 3. Invoke fetchAllevents in viewDidLoad()
 * 4. Create an Event object in insertNewObject()
 * 5. Save the context in insertNewObject()
 *
 */

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var events = [Event]()
    
    // Step 1: Add a "sharedContext" convenience property.
    // (See the FavoriteActorViewController for an example)
    var sharedContext: NSManagedObjectContext {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton

        // Step 3: initialize the events array with the results of the fetchAllEvents() method
        // (see the initialization of the "actors" array in FavoreActorViewController for an example
        events = fetchAllEvents()
    }

    func insertNewObject(sender: AnyObject) {
        
        // Step 4: Create an Event object (and append it to the events array.)
        
        let newEvent = Event(context: sharedContext)
        
        events.append(newEvent)
        
        // Step 5: Save the context (and check for an error)
        var error: NSError?
        
        do {
            try sharedContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let error = error {
            print("error saving context: \(error)")
        }
        
        tableView.reloadData()

        /*
        // Step 4: Create an Event object (and append it to the events array.)
        // (see the actorPicker(:didPickActor:) method for an example with the Person object

        // Step 5: Save the context (and check for an error)
        // (see the actorPicker(:didPickActor:) method for an example
        let event = Event(context: self.sharedContext)
        
        var doesEventExist: Bool = false
        
        for e in events {
            if e.timeStamp == event.timeStamp {
                doesEventExist = true
            }
        }
        
        if !doesEventExist {
            // Create a dictionary from the event. Careful, the imagePath can be nil.
            var dictionary = [String : AnyObject]()
            dictionary[Event.Keys.TimeStamp] = event.timeStamp
            // Insert the actor on the main thread
            
            dispatch_async(dispatch_get_main_queue()) {
                // Init the Person, using the shared Context
                let eventToBeAdded = Event(dictionary: dictionary, context: self.sharedContext)
                
                // Append the actor to the array
                self.events.append(eventToBeAdded)
                
                // Save the context.
                do {
                    try self.sharedContext.save()
                } catch _ {}
            }
        }
        
        tableView.reloadData()
        */
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showDetail" {

        if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = events[indexPath.row]
                (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let event = events[indexPath.row]

        cell.textLabel!.text = event.timeStamp.description

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            // How do we delete a managed object? An interesting, open question.
        }
    }

    // MARK: - Core Data Fetch Helpers

    // Step 2: Add a fetchAllEvents() method
    // (See the fetchAllActors() method in FavoriteActorViewController for an example
    func fetchAllEvents() -> [Event] {
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Event")
        
        // Execute the Fetch Request
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Event]
        } catch _ {
            return [Event]()
        }
    }
}

