//
//  TesterViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/20/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit
import Foundation

class TesterViewController: UIViewController, UITextViewDelegate {
    
    
    //    var authToken = ""
    //    var authUser = ""
    
    @IBOutlet weak var newPostMsg: UITextView!
    
    @IBOutlet weak var newPostMsgOutlet: UITextView!
    
    @IBOutlet weak var newPostButtonOut: UIButton!
    
    @IBAction func newPostButtonPress(_ sender: AnyObject) {
        
        if newPostMsg.text != "" {
            
            let postMsg = newPostMsg.text
            
            //        postMsgToUrl("https://gentle-shelf-67593.herokuapp.com/wall_posts", msg: postMsg)
            newPostMsgOutlet.resignFirstResponder()
            postToApi(msg: postMsg!)
            
        }
    }
    
    @IBAction func loginButtonPress(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "login", sender: Any?.self)
    }
    
    @IBOutlet weak var loginButtonOut: UIBarButtonItem!
    
    @IBAction func logoutButtonPress(_ sender: AnyObject) {
        
        newPostButtonOut.isEnabled = false
        loginButtonOut.isEnabled = true
        loginButtonOut.title = "Login to write on the wall!"
        logoutButtonOut.isEnabled = false
        logoutButtonOut.title = ""
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "authToken")
        defaults.set("", forKey: "loggedUsername")
        defaults.set("false", forKey: "loggedIn")
        print("logged out")
        //        print(authUser)
    }
    
    @IBOutlet weak var logoutButtonOut: UIBarButtonItem!
    
    
    
    
    
    //    func postMsgToUrl(_ link:String, msg:String)
    //    {
    //        let url:URL = URL(string: link)!
    //        let session = URLSession.shared
    //
    //        let request = NSMutableURLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
    //        request.httpBody = msg.data(using: String.Encoding.utf8)
    //
    //
    //        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
    //            if error == nil {
    //
    //                print(response)
    //
    //            }
    //        }
    //
    //        task.resume()
    //
    //    }
    
    //    working, do not break please
    //        func postToApi(msg: String) {
    //
    //        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
    //        let request = NSMutableURLRequest(url: link)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //    //    request.httpBody = "{\"postMsg\":\"test\"}".data(using: String.Encoding.utf8);
    //            request.httpBody = "{\"postMsg\":\"\(msg)\"}".data(using: String.Encoding.utf8);
    //
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
    //
    //            if error == nil {
    //                //                print(response)
    //                print(String(data: data!, encoding: String.Encoding.utf8))
    //                self.reloadTable()
    //            } else {
    //                print(error)
    //            }
    //        })
    //
    //        task.resume()
    //            newPostMsg.text = ""
    //
    //    }
    
    
    //    version for suthentication tests
    
    func postToApi(msg: String) {
        //        loadDefaults()
        let defaults = UserDefaults.standard
        let authToken: String = defaults.string(forKey: "authToken")!
        print(authToken)
        let authUser: String = defaults.string(forKey: "loggedUsername")!
        print(authUser)
        //        let defaultsTest = defaults.object(forKey: "authToken") as! String
        print("printing authorization token")
        print(authToken)
        //        let username = authUser
        print("username")
        print("user for post")
        print(authUser)
        print("token for post")
        //        print(self.authToken)
        
        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
        //let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/users")!
        let request = NSMutableURLRequest(url: link)
        request.httpMethod = "POST"
        let token = authToken
        request.addValue("Token token=\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //    request.httpBody = "{\"postMsg\":\"test\"}".data(using: String.Encoding.utf8);
        
        let jsonData = ["postMsg":msg, "username":authUser] as Dictionary
        
        //        do {
        //
        //            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted) {
        //
        //                print(jsonData)
        //            }
        //        } catch {
        //            print(error)
        //        }
        
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            print("printing json")
            print(json)
            request.httpBody = json
        } catch {
            print("json serialization failed")
        }
        
        
        //        request.httpBody = "{\"postMsg\":\"\(msg)\"}".data(using: String.Encoding.utf8);
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error == nil {
                //                                print(response)
                print("printing with error nil")
                print(String(data: data!, encoding: String.Encoding.utf8))
                self.reloadTable()
            } else {
                //                print("printing task session error")
                print(error)
            }
        })
        
        task.resume()
        newPostMsg.text = ""
        
    }
    
    
    
    //    BEST WORKING VERSION
    //    func postToApi(msg: String) {
    //
    //        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
    ////let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/users")!
    //        let request = NSMutableURLRequest(url: link)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        //    request.httpBody = "{\"postMsg\":\"test\"}".data(using: String.Encoding.utf8);
    //
    //        var jsonData = ["postMsg":msg] as Dictionary
    //
    ////        do {
    ////
    ////            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted) {
    ////
    ////                print(jsonData)
    ////            }
    ////        } catch {
    ////            print(error)
    ////        }
    //
    //        do {
    //            let json = try JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted)
    //            print("printing json")
    //            print(json)
    //            request.httpBody = json
    //        } catch {
    //            print("jason serialization failed")
    //        }
    //
    //
    ////        request.httpBody = "{\"postMsg\":\"\(msg)\"}".data(using: String.Encoding.utf8);
    //
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
    //
    //            if error == nil {
    ////                                print(response)
    //                print("printing with error nil")
    //                print(String(data: data!, encoding: String.Encoding.utf8))
    //                self.reloadTable()
    //            } else {
    ////                print("printing task session error")
    //                print(error)
    //            }
    //        })
    //
    //        task.resume()
    //        newPostMsg.text = ""
    //
    //    }
    
    
    
    //    NOT WORKING!!!!
    //    func postToApi(msg: String) {
    //
    //        let postEndpoint = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
    //        let session = URLSession.shared
    //        let postParams: [String: String] = ["postMsg": msg as String]
    //
    //        let request = NSMutableURLRequest(url: postEndpoint)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    //
    //        do {
    //
    //            request.httpBody = try JSONSerialization.data(withJSONObject: postParams, options: JSONSerialization.WritingOptions())
    //            print(postParams)
    //        } catch {
    //            print("post failed, json serialization")
    //        }
    //
    //        session.dataTask(with: request as URLRequest!) { (data, response, error) in
    //
    //            if let realResponse = response as? HTTPURLResponse {
    ////                if realResponse.statusCode == 200 {
    //                    print("Great Success: 200")
    //                    print(response)
    ////                if let postString = String(data: data!, encoding: String.Encoding.utf8) {
    ////                print("POST: " + postString)
    ////                    }
    //                } else {
    //
    //                print(response)
    //
    //            }
    //
    //            //        JSON Parsing
    //
    //            }
    //            return()
    //        }
    //
    //    good parsing example with error throws
    
    //    enum JSONError: String, Error {
    //        case NoData = "ERROR: no data"
    //        case ConversionFailed = "ERROR: conversion from JSON failed"
    //    }
    //
    //    func jsonParser() {
    //        let urlPath = "http://headers.jsontest.com/"
    //        guard let endpoint = URL(string: urlPath) else {
    //            print("Error creating endpoint")
    //            return
    //        }
    //        let request = URLRequest(url: endpoint)
    //        URLSession.shared.dataTask(with: request) { (data, response, error) in
    //            do {
    //                guard let data = data else {
    //                    throw JSONError.NoData
    //                }
    //                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
    //                    throw JSONError.ConversionFailed
    //                }
    //                print(json)
    //            } catch let error as JSONError {
    //                print(error.rawValue)
    //            } catch let error as NSError {
    //                print(error.debugDescription)
    //            }
    //            }.resume()
    //    }
    
    
    //    JUNK STILL
    //    func postToApi(msg: String) {
    //
    //        let json = [ "title":msg ]
    ////        let jsonData = NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted, error: nil)
    //
    //        do {
    //
    //        let jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
    //
    //        } catch {
    //            print(error)
    //        }
    //        postToApi.resume()
    //
    //        // create post request
    //        let url = URL(string: "http://httpbin.org/post")!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //
    //        // insert json data to the request
    //        request.httpBody = jsonData
    //            let task = URLSession.shared.dataTask(with: request as URLRequest!){ data,response,error in
    //                if error != nil{
    //                    print(error?.localizedDescription)
    //                    return
    //                }
    //
    //                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]{
    //                    print(responseJSON)
    //
    //            }
    //
    //            task.resume()
    //
    //
    //
    //}
    
    //    JUNK
    //    //declare parameter as a dictionary which contains string as key and value combination.
    //    var parameters = ["postMsg": msg] as Dictionary<String, String>
    //
    //    //create the url with NSURL
    //    let url = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts") //change the url
    //
    //    //create the session object
    //    var session = URLSession.shared
    //
    //    //now create the NSMutableRequest object using the url object
    //    let request = NSMutableURLRequest(url: url!)
    //    request.httpMethod = "POST" //set http method as POST
    //
    //        do {
    //            try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted) // pass dictionary to nsdata object and set it as request body
    //        } catch {
    //         print("something broke")
    //        }
    //
    //
    //    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //    request.addValue("application/json", forHTTPHeaderField: "Accept")
    //
    //    //create dataTask using the session object to send data to the server
    //    var task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
    //        print("Response: \(response)")
    //        var strData = String(data: data!, encoding: String.Encoding.utf8)
    //        print("Body: \(strData)")
    //        var err: Error?
    //
    //        do {
    //            var json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
    //            if let parseJSON = json {
    //                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
    //                var success = parseJSON["success"] as? Int
    //                println("Succes: \(success)")
    //            }
    //            else {
    //                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
    //                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
    //                println("Error could not parse JSON: \(jsonStr)")
    //            }
    //        } catch {
    //        print("something broke again")
    //        }
    //        }
    //
    //        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
    ////        if(error != nil) {
    ////            print(error!.localizedDescription)
    ////            let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
    ////            println("Error could not parse JSON: '\(jsonStr)'")
    ////        }
    ////        else {
    //            // The JSONObjectWithData constructor didn't return an error. But, we should still
    //            // check and make sure that json has a value using optional binding.
    //            if let parseJSON = json {
    //                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
    //                var success = parseJSON["success"] as? Int
    //                println("Succes: \(success)")
    //            }
    //            else {
    //                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
    //                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
    //                println("Error could not parse JSON: \(jsonStr)")
    //            }
    //        }
    //    })
    //
    //    task.resume()
    //}
    
    
    func loadDefaults(){
        let defaults = UserDefaults.standard
        if let defaultsToken = defaults.string(forKey: "authToken") {
            var authToken = defaultsToken
            if authToken != "" {
                if let defaultsUser = defaults.string(forKey: "loggedUsername") {
                    var authUser = defaultsUser
                    print("defaults set")
                    print(authToken)
                    print(authUser)
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        
//        let defaults = UserDefaults.standard
//        if defaults.string(forKey: "loggedIn") != nil {
//            if let loggedIn: String = defaults.string(forKey: "loggedIn") {
//                if loggedIn == "true" {
//                    logoutButtonOut.isEnabled = true
//                    loginButtonOut.isEnabled = false
//                    loginButtonOut.title = ""
//                    
//                    print("printing login status:")
//                    print(loggedIn)
//                } else {
//                    logoutButtonOut.isEnabled = false
//                    logoutButtonOut.title = ""
//                    loginButtonOut.isEnabled = true
//                    print("printing login status:")
//                    print("logged out")
//                    
//                }
//            }
//        } else {
//            logoutButtonOut.isEnabled = false
//            logoutButtonOut.title = ""
//            loginButtonOut.isEnabled = true
//            print("printing login status:")
//            print("nil log in")
//        }
        //        if authToken != "" {
        //            if let defaultsUser = defaults.string(forKey: "loggedUsername") {
        //                var authUser = defaultsUser
        //                print("defaults set")
        //                print(authToken)
        //
        //
        //
        //        if let defaultsTest = defaults.string(forKey: "loggedIn") as! String! == "true" {
        //
        //            
        //            
        //            logoutButtonOut.enabled = true
        //            loginButtonOut.enabled = false
        //        } else {
        //            logoutButtonOut.enabled = false
        //            loginButtonOut.enabled = true
        //        }
        //        }
        
        newPostMsg.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "loggedIn") != nil {
            if let loggedIn: String = defaults.string(forKey: "loggedIn") {
                if loggedIn == "true" {
                    logoutButtonOut.isEnabled = true
                    loginButtonOut.isEnabled = false
                    loginButtonOut.title = ""
                    newPostButtonOut.isEnabled = true
                    
                    print("printing login status:")
                    print(loggedIn)
                } else {
                    logoutButtonOut.isEnabled = false
                    logoutButtonOut.title = ""
                    loginButtonOut.isEnabled = true
                    newPostButtonOut.isEnabled = false
                    print("printing login status:")
                    print("logged out")
                    
                }
            }
        } else {
            
            logoutButtonOut.isEnabled = false
            logoutButtonOut.title = ""
            loginButtonOut.isEnabled = true
            newPostButtonOut.isEnabled = false
            
            print("printing login status:")
            print("nil log in")
        }

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func reloadTable(){
        print("reloading table")
        let childView = self.childViewControllers.last as! TesterTableViewController
        childView.refresh()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
