//
//  LoginViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/12/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let ref = Firebase(url: "https://get-grub.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func login(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            ref.authUser(email , password: password,
                withCompletionBlock: { error, authData in
                    if error != nil {
                        // There was an error logging in to this account
                        self.loginError("Uh Oh!", message: "Error loggin in. Check Username/Password")
                    } else {
                        // We are now logged in
                        self.performSegueWithIdentifier("logintomain", sender: nil)
                        
                    }
            })
        }
        else {
            self.loginError("Uh Oh!", message: "Something went wrong!")

        }
        
    }
    
    func loginError(title: String, message: String) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}