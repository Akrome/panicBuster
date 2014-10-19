//
//  ViewController.swift
//  Panic Buster
//
//  Created by Clement Hathaway on 10/19/14.
//  Copyright (c) 2014 Clement Hathaway. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    let locationManager:CLLocationManager! = CLLocationManager() // Important
    
    var uuid:String?
    var lat:Double?
    var long:Double?
    var hacc:Double?

    
    ///// Obtain GPS Cords /////
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) -> Array<String> {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        var locInfo:CLLocationAccuracy = manager.location.horizontalAccuracy // Find our accuracy in meters
        
        return ["\(locValue.latitude)", "\(locValue.longitude)", "\(locInfo)"] //return location points in an array
    }
    
    
    ///// Send Coordinates + Horizontal Accuracy to the Server /////
    func postCords(data:Array<Double>, urld:String, id:String){
        let lat = data[0]
        let long = data[1]
        let hacc = data[2]
        
        let url = NSURL(string: "\(urld)?id=\(id)&glat=\(lat)&glong=\(long)&hacc=\(hacc)")
        let request = NSURLRequest(URL: url)
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
    }
    
    
    ///// Send Text to Number /////
    func sendText(data:Array<Double>,api_key:String,api_secret:String,from:String,to:Int,id:String){
        let lat = data[0]
        let long = data[1]
        let hacc = data[2]
        
        let url = NSURL(string: "https://rest.nexmo.com/sms/json?api_key=\(api_key)&api_secret=\(api_secret)&from=\(from)&to=\(to)&text=\(id):\(lat):\(long):\(hacc)")
        let request = NSURLRequest(URL: url)
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
    }
    
    
    ///// To Close active keyboard /////
    func textFieldShouldReturn(textField: UITextField!) -> Bool { // called when 'return' key pressed. return NO to ignore.
        //println("HI")
        
        textField.resignFirstResponder() //Resign the keyboard
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization() // Ask for authorization
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        uuid = NSUUID.UUID().UUIDString
        println(uuid)
        
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panicButton(sender: AnyObject) {
        let serverLoc = 447520615283
        
        let cords = locationManager(locationManager, didUpdateLocations:[])
        lat = NSString(string: cords[0]).doubleValue // Convert the String to Double using NSString
        long = NSString(string: cords[1]).doubleValue
        hacc = NSString(string: cords[2]).doubleValue
        
        //// Send Text to server
        sendText([lat!,long!,hacc!], api_key: "de6c6edd", api_secret: "890509c3", from: "TC", to: serverLoc, id: uuid!)
        
        //// Post Coordinates to the mapping server
        postCords([lat!,long!,hacc!], urld: "http://zaqwsx453454.ngrok.com/sms.php", id: uuid!) // Send to Server, making sure to unwrap the lat and longs
        
        
    }
}

