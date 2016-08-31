//
//  ViewController.swift
//  SOCoreDataDemo
//
//  Created by Hitesh on 8/30/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tblStudent: UITableView!
    
    var arrStudents = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Fetch all student list from persistent data store
        fetchAllStudentList()
    }
    
    
    //Fetch Student List
    func fetchAllStudentList() {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        
        //Define your Entity name here
        let request = NSFetchRequest(entityName:"Student")
        do {
            let results = try context.executeFetchRequest(request)
            arrStudents = results as! [NSManagedObject]
            tblStudent.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    //Show list of student
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        let student = self.arrStudents[forRowAtIndexPath.row]
        cell.textLabel?.text = student.valueForKey("first_name") as? String
    }
    
    
    
    //Delete from core data
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        if editingStyle == .Delete {
            // Delete object from database
            context.deleteObject(self.arrStudents[indexPath.row])
            
            // Save the object to persistent store
            do {
                try context.save()
            } catch let error {
                print("Can't Delete! \(error))")
                return
            }

            // Remove student from table view
            self.arrStudents.removeAtIndex(indexPath.row)
            tblStudent.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

