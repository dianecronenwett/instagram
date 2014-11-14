//
//  TableViewController.swift
//  instagram
//
//  Created by diane cronenwett on 11/13/14.
//  Copyright (c) 2014 dianesorg. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var photos: NSArray! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 346
        
        
        
        var clientId = "546953016910400799ac70654f1ce893"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            self.tableView.reloadData()
            
            println("response: \(self.photos)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoCell
        
       // cell.urlLabel.text = "URL"
        
        // Configure YourCustomCell using the outlets that you've defined.
        var photo = photos[indexPath.section] as NSDictionary
        
        
        
        var photoURL = photo.valueForKeyPath("images.low_resolution.url") as String
        //cell.urlLabel.text = photoURL
        
        cell.photoView.setImageWithURL(NSURL(string: photoURL))

        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Determine which row was selected
        var cell = sender as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)
        
        // Get the view controller that we're transitioning to.
        var photoViewController = segue.destinationViewController as PhotoViewController
        
        // Set the data of the view controller
        var photo = photos[indexPath!.section] as NSDictionary
        photoViewController.photo = photo
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        var photo = photos[section] as NSDictionary
        var user = photo["user"] as NSDictionary
        var username = user["username"] as String
        var profileUrl = NSURL(string: user["profile_picture"] as String)
        
        var profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1
        profileView.setImageWithURL(profileUrl)
        headerView.addSubview(profileView)
        
        var usernameLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 250, height: 30))
        usernameLabel.text = username
        usernameLabel.font = UIFont.boldSystemFontOfSize(16)
        usernameLabel.textColor = UIColor(red: 8/255.0, green: 64/255.0, blue: 127/255.0, alpha: 1)
        headerView.addSubview(usernameLabel)
        
        return headerView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
