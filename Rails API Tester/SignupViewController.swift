//
//  SignupViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/21/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameTextFieldOut: UITextField!
    
    @IBOutlet weak var emailTextFieldOut: UITextField!
    
    @IBOutlet weak var passwordTextFieldOut: UITextField!
    
    @IBOutlet weak var confirmPasswordTextFieldOut: UITextField!
    
    @IBAction func signupButtonPress(_ sender: AnyObject) {
        
        if usernameTextFieldOut.text != "" {
            
            if emailTextFieldOut.text != "" {
                
                if passwordTextFieldOut.text != "" {
                    
                    if passwordTextFieldOut.text == confirmPasswordTextFieldOut.text {
                        print("calling signup function")
                        signUpToApi(username: usernameTextFieldOut.text!, password: passwordTextFieldOut.text!, email: emailTextFieldOut.text!)
                    } else {
                        createAlert(title: "Password Error", message: "Please make sure both password and confirm password are the same")
                        print("passwords don't match")
                    }
                } else {
                    createAlert(title: "Password Error", message: "Please make sure both password and confirm password are the same")
                    print("password not filled in")
                }
            } else {
                createAlert(title: "Email Error", message: "Please make sure email is filled in.")
                print("email not filled in")
            }
        } else {
            createAlert(title: "Username Error", message: "Ooops, missing a username. We kind of need it. ;)")
            print("username not filled in")
        }
    }
    
    
    @IBAction func loginButtonPress(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "signupToLogin", sender: Any?.self)
        
    }
    
    @IBAction func dismissButtonPress(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "signupToMain", sender: Any?.self)
        
    }
    
    func signUpToApi(username: String, password: String, email: String) {
        
        print(username)
        print(password)
        print(email)
        
        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/users")!
        let request = NSMutableURLRequest(url: link)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonData = ["username":username, "password":password, "email":email] as Dictionary
        
        do {
            let json = try JSONSerialization.data(withJSONObject: jsonData)
            print("printing json")
            print(json)
            request.httpBody = json
        } catch {
            print("json serialization failed")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if error == nil {
                print("printing with error nil")
                print(String(data: data!, encoding: String.Encoding.utf8))
                self.loginToApi(username: username, password: password)
            } else {
                print(error)
            }
        })
        
        task.resume()
        
    }
    
    func loginToApi(username: String, password: String) {
        print(username)
        print(password)
        
        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/token")!
        let request = NSMutableURLRequest(url: link)
        request.httpMethod = "GET"
        
        let loginUsername = username
        let loginPassword = password
        print("\(loginUsername):\(loginPassword)")
        let authString = "\(loginUsername):\(loginPassword)"
        
        let authData = authString.data(using: String.Encoding.utf8)
        let base64AuthData = authData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(base64AuthData)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            
            print(String(data: data!, encoding: String.Encoding.utf8))
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                print("printing status code:")
                print(statusCode)
                if statusCode != nil {
                    if statusCode == 401 {
                        self.createAlert(title: "Invalid Credentials", message: "Did you get your username and password right?")
                        print("invalid credentials")
                    } else {
                        if statusCode == 200 {
                            print("login succesful")
                            self.extract_json(data!, username: loginUsername)
                        } else {
                            self.createAlert(title: "Unknown Error", message: "Something crazy happened and I didn't fix it yet. My bad. Please try closing the app and logging in again. Just once. If it doesn't work, it's on me and i'm working on it.")
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
                        self.performSegue(withIdentifier: "signupToMain", sender: Any?.self)
                    }
                }
            }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
