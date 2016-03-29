//
//  CreateAccountViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/12/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateAccountViewController : UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var ref = Firebase(url: "https://get-grub.firebaseio.com/")

    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text

        if username != "" && email != "" && password != "" {
            
            ref.createUser(email, password: password,
                withValueCompletionBlock: { error, result in
                    if error != nil {
                        self.signupError("Uh Oh!", message: "Email or Username already taken")
                    } else {
                        let uid = result["uid"] as? String
                        NSUserDefaults.standardUserDefaults().setValue(uid, forKey: "uid")
                        self.ref.authUser(email , password: password,
                            withCompletionBlock: { error, authData in
                                if error != nil {
                                 
                                } else {
                                    print(authData.uid)
                                    
                                    let newUser = [
                                        "provider": authData.provider,
                                        "displayName": username
                                    ]
                                    
                                    self.ref.childByAppendingPath("users")
                                        .childByAppendingPath(authData.uid).setValue(newUser)
                                    self.performSegueWithIdentifier("signuptomain", sender: nil)
                                }
                        })
                    }
            })
            
            
        } else {
            signupError("Uh Oh!", message: "Don't forget to enter your email, password, and a username.")
        }
    }

    func signupError(title: String, message: String) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}