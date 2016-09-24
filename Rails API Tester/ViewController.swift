//
//  ViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/16/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testResponseLabel: UILabel!
    
    
    @IBAction func testButtonPress(_ sender: AnyObject) {
        
        //       working test on the heroku server
        
        let url = NSURL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("0726ffad", forHTTPHeaderField: "app_id")
        //        request.addValue("53099d1a2b2bc52a0f35016f87597296", forHTTPHeaderField: "app_key")
        
        //        request.httpBody = "{\n  \"image\": \"http://media.kairos.com/kairos-elizabeth.jpg\",\n  \"subject_id\": \"subtest1\",\n  \"gallery_name\": \"gallerytest1\",\n  \"selector\": \"SETPOSE\",\n  \"symmetricFill\": \"true\"\n}".data(using: String.Encoding.utf8);
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if response != nil{
                let urlContent = data
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    print(jsonResult)
                    
                    //                    array example
                    if let array = jsonResult as? [Any] {
                        if let firstObject = array.first {
                            print("printing first object in array")
                            print(firstObject)
                            if let dictionary = firstObject as? [String: Any] {
                                print("cast as dictionary")
                                if let msg = dictionary["postMsg"] as? String {
                                    print("printing message")
                                    print(msg)
                                    self.testResponseLabel.text = msg
                                }
                            }
                        }
                    }
                    //                    object example
                    //                    if let dictionary = jsonResult as? [String: Any] {
                    //                        print("cast as dictionary")
                    //                        if let msg = dictionary["postMsg"] as? String {
                    //                        print("printing message")
                    //                            print(msg)
                    //                            self.testResponseLabel.text = msg
                    //                    }
                    //                    }
                    
                    
                    //                    self.testResponseLabel.text = jsonResult["postMsg"]
                    //
                    //                    if let post = jsonResult["postMsg"] as? String {
                    //                    print(post)
                    //                    }
                    
                } catch {
                    
                    print("Serialization Failed")
                    
                }
                
                //                print("Printing Data")
                //                print(String(data: data!, encoding: String.Encoding.utf8))
                //                self.testResponseLabel.text = String(data: data!, encoding: String.Encoding.utf8)
                //                //                print("Print Response")
                //                //                print(String(describing: response))
                
            } else {
                
                print(error)
                
            }
        }
        
        task.resume()
        
    }
    
    ////       working test on the heroku server
    //
    //        let url = NSURL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
    //        let request = NSMutableURLRequest(url: url as URL)
    //        request.httpMethod = "GET"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    ////        request.addValue("0726ffad", forHTTPHeaderField: "app_id")
    ////        request.addValue("53099d1a2b2bc52a0f35016f87597296", forHTTPHeaderField: "app_key")
    //
    ////        request.httpBody = "{\n  \"image\": \"http://media.kairos.com/kairos-elizabeth.jpg\",\n  \"subject_id\": \"subtest1\",\n  \"gallery_name\": \"gallerytest1\",\n  \"selector\": \"SETPOSE\",\n  \"symmetricFill\": \"true\"\n}".data(using: String.Encoding.utf8);
    //
    //        let session = URLSession.shared
    //
    //        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
    //            if response != nil{
    //                let data = data
    //                print("Printing Data")
    //                print(String(data: data!, encoding: String.Encoding.utf8))
    //                self.testResponseLabel.text = String(data: data!, encoding: String.Encoding.utf8)
    //                //                print("Print Response")
    //                //                print(String(describing: response))
    //
    //            } else {
    //
    //                print(error)
    //
    //            }
    //        }
    //
    //        task.resume()
    //
    //    }
    
    
    //        testing JSON response with the Kairos API
    
    //        let url = NSURL(string: "https://api.kairos.com/enroll")!
    //        let request = NSMutableURLRequest(url: url as URL)
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.addValue("0726ffad", forHTTPHeaderField: "app_id")
    //        request.addValue("53099d1a2b2bc52a0f35016f87597296", forHTTPHeaderField: "app_key")
    //
    //        request.httpBody = "{\n  \"image\": \"http://media.kairos.com/kairos-elizabeth.jpg\",\n  \"subject_id\": \"subtest1\",\n  \"gallery_name\": \"gallerytest1\",\n  \"selector\": \"SETPOSE\",\n  \"symmetricFill\": \"true\"\n}".data(using: String.Encoding.utf8);
    //
    //        let session = URLSession.shared
    //
    //        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
    //            if response != nil{
    //                let data = data
    //                print("Printing Data")
    //                print(String(data: data!, encoding: String.Encoding.utf8))
    ////                print("Print Response")
    ////                print(String(describing: response))
    //
    //            } else {
    //
    //                print(error)
    //
    //            }
    //        }
    //
    //        task.resume()
    //
    //    }
    
    //
    //
    //        }
    //
    //            let task = session.dataTaskWithRequest(request as URLRequest) { data, response, error in
    //                if let response = response, let data = data {
    //                    //                print(response)
    //                    print(String(data: data, encoding: NSUTF8StringEncoding))
    //
    //
    //                } else {
    //                    print(error)
    //                }
    //            }
    //
    //            task.resume()
    //
    //        }
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

