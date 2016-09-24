//
//  LoginViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/20/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var token = ""
    var username = ""
    
    @IBOutlet weak var usernameTextFieldOut: UITextField!
    
    @IBOutlet weak var passwordTextFieldOut: UITextField!
    
    @IBAction func dismissButtonPress(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "loginToMain", sender: Any?.self)
        
    }
    
    @IBAction func signupButtonPress(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "signup", sender: Any?.self)
        
        
    }
    
    func loginToApi(username: String, password: String) {
        
        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/token")!
        let request = NSMutableURLRequest(url: link)
        request.httpMethod = "GET"
        
        let loginUsername = username
        let loginPassword = password
        let authString = "\(loginUsername):\(loginPassword)"
        
        let authData = authString.data(using: String.Encoding.utf8)
        let base64AuthData = authData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(base64AuthData)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let response:URLResponse = response  , error == nil else {
                
                return
            }
            print("printing data:")
            print(String(data: data!, encoding: String.Encoding.utf8))
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                print("printing status code:")
                print(statusCode)
                if statusCode != nil {
                    if statusCode == 401 {
                        print("invalid credentials")
                    } else {
                        if statusCode == 200 {
                            print("login succesful")
                            self.extract_json(data!, username: loginUsername)
                        } else {
                            print("unknown error")
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func extract_json(_ data: Data, username: String)
        
    {
        print("parsing JSON")
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: [])
            print("attempting json serialization")
        }
        catch
        {
            return
        }
        if let tokenResponse = json as? NSDictionary
        { print("tokenResponse as dict")
            for (key, value) in tokenResponse
            {
                print(key)
                print(value)
                var token = value
                print (token)
                print(username)
                let defaults = UserDefaults.standard
                defaults.set(token, forKey: "authToken")
                defaults.set(username, forKey: "loggedUsername")
                defaults.set("true", forKey: "loggedIn")
                
                if let defaultsTest = defaults.string(forKey: "authToken") {
                    print(defaultsTest)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginToMain", sender: Any?.self)
                        
                    }
                    
                }
                
                
            }
        } else {
            return
        }
    }
    
    func createAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Got it!", style: .default) { (UIAlertAction) in
            print("you got it")
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    
    @IBAction func loginButtonPress(_ sender: AnyObject) {
        
        if usernameTextFieldOut.text != "" && passwordTextFieldOut.text != "" {
            
            let username = usernameTextFieldOut.text
            let password = passwordTextFieldOut.text
            
            loginToApi(username: username!, password: password!)
            
        } else {
            createAlert(title: "Empty Fields", message: "Please fill out all fields.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextFieldOut.delegate = self
        passwordTextFieldOut.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


