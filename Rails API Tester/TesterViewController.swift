//
//  TesterViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/20/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit
import Foundation

class TesterViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let api = Bundle.main.infoDictionary!["APIURL"] as! String
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var newPostMsg: UITextView!
    
    @IBOutlet weak var newPostMsgOutlet: UITextView!
    
    @IBOutlet weak var newPostButtonOut: UIButton!
    
//    @IBOutlet weak var newPostImage: UIImageView!
    
//    var pictureString = ""
    
//    func createActionForPicture() {
//        let alertController = UIAlertController(title: "Image source selection", message: "Pick an option to add your picture to the wall post.", preferredStyle: .actionSheet)
//        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
//            print("Camera Selected")
//            self.addCameraPicture()
//        }
//        
//        alertController.addAction(cameraAction)
//        
//        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
//            print("Photo Library Selected")
//            self.addLibraryPicture()
//        }
//
//        alertController.addAction(libraryAction)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
//            print("Cancel button selected")
//        }
//        
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true) {
//            
//        }
//    }
//    
//    func addCameraPicture(){
//        var image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.camera
//        image.cameraDevice = UIImagePickerControllerCameraDevice.front
//        image.allowsEditing = true
//        
//        self.present(image, animated: true, completion: nil)
//    }
//    
//    func addLibraryPicture(){
//        var image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        image.allowsEditing = true
//        
//        self.present(image, animated: true, completion: nil)
//
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        
//        
////    }
////    
////    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
////    {
//        
////        self.activitySelfieImageView.image = image
////        print("activitySelfieSet")
////        self.activitySelfieImage = activitySelfieImageView.image!
////        self.dismissViewControllerAnimated(true, completion: nil)
////        var activity = PFObject(className:"activity")
////        //        activity["duration"] = time
////        //        activity["username"] = user?.username
////        activity.objectId = self.activityId
//        
//        var postPicture = info[UIImagePickerControllerOriginalImage] as! UIImage
//        self.newPostImage.isHidden = false
//        self.newPostImage.image = postPicture
//        
//        let imageData = UIImageJPEGRepresentation(postPicture, 1)
//        
//        let picBase64:String = (imageData?.base64EncodedString(options: .lineLength64Characters))!
//        self.pictureString = picBase64
//        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
////        print(picBase64)
//        self.activityIndicator.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
//        self.dismiss(animated: true, completion: nil)
////        base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
//        
//    }
    
//    @IBAction func pictureButtonPress(_ sender: AnyObject) {
//        createActionForPicture()
//    }
   
    @IBAction func newPostButtonPress(_ sender: AnyObject) {
        
        if newPostMsg.text != "" {
//            if pictureString != "" {
//                let postMsg = newPostMsg.text
//                let picString = pictureString
//                newPostMsgOutlet.resignFirstResponder()
//                print("posting to apiPic")
//                print(pictureString)
//                postToApiPic(msg: postMsg!, picture: picString)
//            }
            let postMsg = newPostMsg.text
            newPostMsgOutlet.resignFirstResponder()
            print("posting to api")
//            print(pictureString)
            postToApi(msg: postMsg!)
        }
    }
    
    
    @IBAction func loginButtonPress(_ sender: AnyObject) {
        performSegue(withIdentifier: "login", sender: Any?.self)
    }
    
    @IBOutlet weak var loginButtonOut: UIButton!
    
    
    @IBAction func logoutButtonPress(_ sender: AnyObject) {
        
        newPostButtonOut.isEnabled = false
        loginButtonOut.isHidden = false
        loginButtonOut.isEnabled = true
        logoutButtonOut.isHidden = true
        logoutButtonOut.isEnabled = false
        
        
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "authToken")
        defaults.set("", forKey: "loggedUsername")
        defaults.set("false", forKey: "loggedIn")
        print("logged out")
    }
    
    
    @IBOutlet weak var logoutButtonOut: UIButton!
    
    
    //    version for suthentication tests
    
    func postToApi(msg: String) {
        
        let defaults = UserDefaults.standard
        let authToken: String = defaults.string(forKey: "authToken")!
        print(authToken)
        let authUser: String = defaults.string(forKey: "loggedUsername")!
        print(authUser)
        print("printing authorization token")
        print(authToken)
        print("username")
        print("user for post")
        print(authUser)
        print("token for post")
        
//        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
        let link = URL(string: "\(api)/wall_posts")!
        let request = NSMutableURLRequest(url: link)
        request.httpMethod = "POST"
        let token = authToken
        request.addValue("Token token=\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = ["postMsg":msg, "username":authUser] as Dictionary
        
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
                self.reloadTable()
            } else {
                print(error)
            }
        })
        
        task.resume()
        newPostMsg.text = ""
    }
    
//    func postToApiPic(msg: String, picture: String) {
//        
//        let defaults = UserDefaults.standard
//        let authToken: String = defaults.string(forKey: "authToken")!
//        print(authToken)
//        let authUser: String = defaults.string(forKey: "loggedUsername")!
//        print(authUser)
//        print("printing authorization token")
//        print(authToken)
//        print("username")
//        print("user for post")
//        print(authUser)
//        print("token for post")
//        
//        let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
//        let request = NSMutableURLRequest(url: link)
//        request.httpMethod = "POST"
//        let token = authToken
//        request.addValue("Token token=\(token)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let jsonData = ["postMsg":msg, "username":authUser, "picture":picture] as Dictionary
//        
//        do {
//            let json = try JSONSerialization.data(withJSONObject: jsonData)
//            print("printing json")
//            print(json)
//            request.httpBody = json
//        } catch {
//            print("json serialization failed")
//        }
//        
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//            
//            if error == nil {
//                print("printing with error nil")
//                print(String(data: data!, encoding: String.Encoding.utf8))
//                self.reloadTable()
//            } else {
//                print(error)
//            }
//        })
//        
//        task.resume()
//        newPostMsg.text = ""
//    }
    
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
//        loadDefaults()
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "loggedIn") != nil {
            if let loggedIn: String = defaults.string(forKey: "loggedIn") {
                if loggedIn == "true" {
                    logoutButtonOut.isEnabled = true
                    loginButtonOut.isHidden = true
                    loginButtonOut.isEnabled = false
                    newPostButtonOut.isEnabled = true
                
                    
                    print("printing login status:")
                    print(loggedIn)
                } else {
                    logoutButtonOut.isHidden = true
                    logoutButtonOut.isEnabled = false
                    loginButtonOut.isHidden = false
                    loginButtonOut.isEnabled = true
                    newPostButtonOut.isEnabled = false
                    print("printing login status:")
                    print("logged out")
                    
                }
            }
        }

        
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
                    loginButtonOut.isHidden = true
                    loginButtonOut.isEnabled = false
                    newPostButtonOut.isEnabled = true
                    
                    print("printing login status:")
                    print(loggedIn)
                } else {
                    logoutButtonOut.isHidden = true
                    logoutButtonOut.isEnabled = false
                    loginButtonOut.isHidden = false
                    loginButtonOut.isEnabled = true
                    newPostButtonOut.isEnabled = false
                    print("printing login status:")
                    print("logged out")
                    
                }
            }
        } else {
            
            logoutButtonOut.isHidden = true
            logoutButtonOut.isEnabled = false
            loginButtonOut.isHidden = false
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
