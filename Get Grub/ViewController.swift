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
    
    @IBOutlet var welcomeLabel : UILabel!
    @IBOutlet var infoLabel : UILabel!
    @IBOutlet var searchField : UITextField!
    @IBOutlet var searchButton : UIButton!
    @IBOutlet var foodImage : UIImageView!
    var nameParameter : String!
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let apiConsoleInfo = YelpAPIConsole()
    var client = YelpClient!()
    var tableView = UITableView()
    var restaurants: [Business]!
    
    let yelpConsumerKey = "-juUeNMM-9BHuamEp7Is7g"
    let yelpConsumerSecret = "zFbfCqoFPBx_psI1s4cm3ah8WHM"
    let yelpToken = "QaolEjs33uqpzC7v99fQXc1-x4TscbCu"
    let yelpTokenSecret = "-qI4tsWdod-yHPFWCG-CAZ266t4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        welcomeLabel.alpha = 0
        infoLabel.alpha = 0
        searchField.alpha = 0
        searchButton.alpha = 0
        foodImage.alpha = 0
        searchButton.layer.borderColor = UIColor.blackColor().CGColor
        searchButton.layer.borderWidth = 1.0
        
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func createTableView() {
        tableView.frame = CGRectMake(UIScreen.mainScreen().bounds.origin.x, searchField.frame.origin.y + searchField.frame.height , searchField.frame.width, (UIScreen.mainScreen().bounds.height / 2))
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        tableView.removeFromSuperview()
        self.searchButton.hidden = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //datasource method returning the what cell contains
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
      //  cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    @IBAction func searchFood(sender : AnyObject) {
        if (searchField.text != "") {
            nameParameter = searchField.text
//            client.searchPlacesWithParameters(["term": "\(nameParameter)","ll": "\(latitude),\(longitude)","limit":"3"], successSearch: { (data, response : AnyObject!) -> Void in
//               // print(NSString(data: data, encoding: NSUTF8StringEncoding))
//                let json = JSON(data: data)
//                self.restaurants = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [NSDictionary]
//                //self.createTableView()
//                //self.searchButton.hidden = true
////                let name = json["businesses"][0]["name"].stringValue
////                let phone = json["businesses"][0]["display_phone"].stringValue
////                let openStatus = json["businesses"][0]["is_closed"].stringValue
////                let address = json["businesses"][0]["display_address "][0].stringValue
////                let address1 = json["businesses"][0]["display_address "][1].stringValue
////                self.restaurantInfo.updateValue(name, forKey: "name")
////                self.restaurantInfo.updateValue(phone, forKey: "phone")
////                self.restaurantInfo.updateValue(openStatus, forKey: "status")
////                self.restaurantInfo.updateValue(address, forKey: address)
////                self.restaurantInfo.updateValue(address, forKey: address1)
////                print(json["businesses"][0]["location"])
//                })
//                {
//                    (error) -> Void in
//                    print(error)
//                }
                    client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
            
                    client.searchWithTerm("\(nameParameter)", latitude: latitude, longitude: longitude, completion: { (businesses: [Business]!, error: NSError!) -> Void in
                        self.restaurants = businesses
                        self.createTableView()
                        self.searchButton.hidden = true
                        self.tableView.reloadData()
                    })
            
            }
            
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
        self.searchButton.fadeIn(2, delay: 1.4, completion: {
            (finished : Bool) -> Void in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

