//
//  MasterViewController.swift
//  review
//
//  Created by Jonathan Yen on 11/16/14.
//  Copyright (c) 2014 Jonathan Yen. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var titles = NSMutableArray()
    var objects = NSMutableArray()
    
    var currentCard: Int = 0
    
    var notificationCenter = NSNotificationCenter.defaultCenter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        notificationCenter.addObserver(self, selector: "titleTextDidChange:", name: UITextFieldTextDidChangeNotification, object: nil)
        notificationCenter.addObserver(self, selector: "bodyTextDidChange:", name: UITextViewTextDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject("Start typing here...", atIndex: 0)
        titles.insertObject(objects.count, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func titleTextDidChange(notification: NSNotification) {
        self.detailViewController?.titleItem = (notification.object as UITextField).text
        titles[self.currentCard] = (notification.object as UITextField).text
        let cell = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow() as NSIndexPath!) as UITableViewCell!
        cell.textLabel.text = (notification.object as UITextField).text
    }
    
    
    func bodyTextDidChange(notification: NSNotification) {
        self.detailViewController?.detailItem = (notification.object as UITextView).text
        objects[self.currentCard] = (notification.object as UITextView).text
    }
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                self.currentCard = indexPath.row
                let object = objects[indexPath.row] as String
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                let title = titles[indexPath.row] as String
                controller.titleItem = title
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                self.detailViewController?.titleItem = title
                self.detailViewController?.detailItem = object
            }
        }
        println("segueing")
        println(segue.identifier)
    }
    
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as String
        //cell.textLabel.text = object.description
        cell.textLabel.text = "New Card " + String(objects.count)
        titles[indexPath.row] = "New Card " + String(objects.count)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

