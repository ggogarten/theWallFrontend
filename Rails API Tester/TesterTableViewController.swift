//
//  TesterTableViewController.swift
//  Rails API Tester
//
//  Created by George Gogarten on 9/20/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit
import Foundation

class TesterTableViewController: UITableViewController {
    
    var tableData:Array = [String()]
    
    var tableDataId = [Double()]
    
    var tableDataDate = [String()]
    
    var tableDataUsername = [String()]
    
    var refresher: UIRefreshControl!
    
    func refresh() {
        
        print("Refreshed")
        
        getDataFromUrl("https://gentle-shelf-67593.herokuapp.com/wall_posts")
        
        print("Updated")
        
        print(tableData)
        
        self.tableData.removeAll(keepingCapacity: true)
        self.tableDataId.removeAll(keepingCapacity: true)
        
        print(tableData)
        
        self.refresher.endRefreshing()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableData.removeAll(keepingCapacity: true)
        self.tableDataId.removeAll(keepingCapacity: true)
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refresher.addTarget(self, action: #selector(TesterTableViewController.refresh), for: UIControlEvents.valueChanged)
        
        self.tableView.addSubview(refresher)
        
        getDataFromUrl("https://gentle-shelf-67593.herokuapp.com/wall_posts")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TesterTableViewCell
        
        // Configure the cell...
        if indexPath.row < tableData.count{
            
            cell.usernameLabel?.text = tableDataUsername[indexPath.row]
            cell.postLabel?.text = tableData[indexPath.row]
            cell.dateLabel?.text = tableDataDate[indexPath.row]
            
            
        }
        return cell
    }
    
    
    
    
    func getDataFromUrl(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            
            
            self.extract_json(data!)
            
            
        })
        
        task.resume()
        
    }
    
    
    func extract_json(_ data: Data)
        
    {
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_list = json as? NSArray else
        {
            return
        }
        
        
        if let msgsList = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let post = msgsList[i] as? NSDictionary
                { print(post)
                    if let postId = post["id"] as? Double
                    {
                        if let postMsg = post["postMsg"] as? String
                        {
                            if let createdAt = post["created_at"] as? String
                            {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
                                let msgDate = dateFormatter.date(from: createdAt)
                                let formatter = DateFormatter()
                                formatter.dateStyle = DateFormatter.Style.medium
                                formatter.timeStyle = DateFormatter.Style.medium
                                let createdAtString = formatter.string(from: msgDate!)
                                
                                if let username = post["username"] as? String
                                {
                                    
                                    tableDataUsername.append(username)
                                    tableDataDate.append(createdAtString)
                                    tableDataId.append(postId)
                                    tableData.append(postMsg)
                                    print(createdAt)
                                    print(msgDate)
                                    
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
        tableData.reverse()
        tableDataId.reverse()
        tableDataDate.reverse()
        tableDataUsername.reverse()
        
        
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
