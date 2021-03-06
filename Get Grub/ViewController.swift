//
//  ViewController.swift
//  Get Grub
//
//  Created by Justin Matsnev on 3/3/16.
//  Copyright © 2016 Justin Matsnev. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import Alamofire
import SwiftyJSON

class RestaurantTableViewCell : UITableViewCell {
    
}

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var groupsButton : UIButton!
    @IBOutlet var welcomeLabel : UILabel!
    @IBOutlet var infoLabel : UILabel!
    @IBOutlet var searchField : UITextField!
    @IBOutlet var foodImage : UIImageView!
    var nameParameter : String!
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    var client = YelpClient!()
    var restaurants: [Business]! = [Business]()
    @IBOutlet var tableView : UITableView!
    let yelpConsumerKey = "-juUeNMM-9BHuamEp7Is7g"
    let yelpConsumerSecret = "zFbfCqoFPBx_psI1s4cm3ah8WHM"
    let yelpToken = "QaolEjs33uqpzC7v99fQXc1-x4TscbCu"
    let yelpTokenSecret = "-qI4tsWdod-yHPFWCG-CAZ266t4"
    var ref = Firebase(url:"https://get-grub.firebaseio.com")
    let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid")
    var groupID : String!
    
    var userDictionary : NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
        grabUsersName()
        welcomeLabel.alpha = 0
        infoLabel.alpha = 0
        searchField.alpha = 0
        foodImage.alpha = 0
        tableView.alpha = 0
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
       
        
        
        textFieldShouldReturn(searchField)
        textFieldDidBeginEditing(searchField)
    }
    
    @IBAction func goToGroups(sender : AnyObject) {
        self.performSegueWithIdentifier("searchtogroups", sender: nil)
    }
    
    func grabUsersName() {
        let usersRef = ref.childByAppendingPath("users/")
        usersRef.observeEventType(.Value, withBlock: { snapshot in
            self.userDictionary = snapshot.value.objectForKey(self.uid!)! as! NSDictionary
            let username = self.userDictionary["displayName"]! as! String
            self.welcomeLabel.text = "Welcome, \(username)"
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
       
    }
    
    func createGroup(restaurantName : String, restaurantAddress : String) {
        groupID = randomAlphaNumericString(10)
        let groupsRef = ref.childByAppendingPath("groups/")
        let usersRef = ref.childByAppendingPath("users/\(uid!)/")
        let groupMembers = [
            "\(uid!)": true
        ]
        let groupInfo = [
            "restaurantName" : restaurantName,
            "restaurantAddress" : restaurantAddress,
            
        ]
        let groupsUsersIn = [
            "\(groupID)" : true
        
        ]
        
        usersRef.childByAppendingPath("groups").updateChildValues(groupsUsersIn)
        groupsRef.childByAppendingPath(groupID).setValue(groupInfo)
        groupsRef.childByAppendingPath(groupID).childByAppendingPath("members").setValue(groupMembers)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "searchtodate") {
            let setTimeViewController = segue.destinationViewController as! SetTimeViewController
            let groupsID = groupID
            setTimeViewController.groupID = groupsID
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        if (searchField.text != "") {
            nameParameter = searchField.text
            
            client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
            
            client.searchWithTerm("\(nameParameter)", latitude: latitude, longitude: longitude, completion: { (businesses: [Business]!, error: NSError!) -> Void in
                self.restaurants = businesses
                self.tableView.reloadData()
                self.tableView.fadeIn(1, delay: 0, completion: {
                    (finished : Bool) -> Void in
                    
                })
                
            })
            
        }
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath!) as! BusinessCell
        
        createGroup(selectedCell.nameLabel.text!, restaurantAddress: selectedCell.addressLabel.text!)
        
        self.performSegueWithIdentifier("searchtodate", sender: nil)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        let business = restaurants[indexPath.row]
        cell.setFields(business)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.welcomeLabel.fadeIn(2, delay: 0.1, completion: {
            (finished : Bool) -> Void in

        })
        self.foodImage.fadeIn(2, delay: 0.4, completion: {
            (finished : Bool) -> Void in
            
        })
        self.infoLabel.fadeIn(2, delay: 0.7, completion: {
            (finished : Bool) -> Void in
            
        })
        self.searchField.fadeIn(2, delay: 1, completion: {
            (finished : Bool) -> Void in
            
        })
       
        
        
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            randomString += String(newCharacter)
        }
        
        return randomString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

