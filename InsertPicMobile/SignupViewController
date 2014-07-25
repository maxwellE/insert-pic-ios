//
//  SignupViewController.swift
//  InsertPicMobile
//
//  Created by Samarth Sandeep on 7/19/14.
//  Copyright (c) 2014 InsertPic. All rights reserved.
//

import UIKit
import CoreData



class SignupViewController: UIViewController {

  
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPasswordConfirm: UITextField!
    
    @IBAction func btnRegister(){
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        if(txtPassword == txtPasswordConfirm){
               context.save(nil)
        }else{
            var alert = UIAlertController(title: "Oops", message: "Passwords do not Match", preferredStyle: UIAlertControllerStyle.Alert)
            
        
        }
        
        
    }
    @IBAction func btnLogin(){
        
        if ((txtUsername == "email")&&(txtPassword == "password")){
            
        
            
        [self .performSegueWithIdentifier("login", sender: self)]
            
            
        }else{
            
            var alert = UIAlertController(title: "No Entry", message: "Email and Password do not Match", preferredStyle: UIAlertControllerStyle.Alert)
            
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
