//
//  AddVC.swift
//  SOCoreDataDemo
//
//  Created by Hitesh on 8/30/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import CoreData

class AddVC: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtRollNo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    lazy var context: NSManagedObjectContext = {
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        return appDel.managedObjectContext
    }()

    //MARK:- Save student record action
    @IBAction func actionSave(sender: AnyObject) {
        if (txtRollNo.text?.characters.count > 0) && (txtRollNo.text?.characters.count > 0) && (txtRollNo.text?.characters.count > 0) {
            
            let entity = NSEntityDescription.entityForName("Student", inManagedObjectContext:context)
            
            let newStudent = Student(entity:entity!, insertIntoManagedObjectContext:context)
            newStudent.first_name = txtFirstName.text
            newStudent.last_name = txtLastName.text
            
            if let number = Int(txtRollNo.text!) {
                let myRollNo = NSNumber(integer:number)
                newStudent.rollno = myRollNo
            } else {
                print("'\(txtRollNo.text!)' did not convert to an Int")
            }

            do {
                try self.context.save()
            } catch let error as NSError {
                print("Error saving movie \(error.localizedDescription)")
            }
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            print("it will not be saved")
        }
        
    }
    
    
    @IBAction func actionBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
