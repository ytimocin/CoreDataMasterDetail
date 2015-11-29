# CoreDataMasterDetail

Recall that the MasterDetail app has a table that shows NSDate objects.

The app has been set up with a Core Data stack in the app delegate, similar to the Favorite Actor app.

It also has a Managed Object subclass named Event that has a single NSDate property.

The goal of this exercise is to persist these Event objects into Core Data. All of the changes that you will make will be in MasterViewController.swift.

You can persist the Events in 5 steps:

Create a convenience property named sharedContext
Add a method named fetchAllEvents()
Invoke fetchAllEvents in viewDidLoad()
Insert a new Event object when the + button is tapped.
Save the context after each new Event has been inserted
