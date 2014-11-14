//
//  PhotoViewController.swift
//  instagram
//
//  Created by diane cronenwett on 11/13/14.
//  Copyright (c) 2014 dianesorg. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var photo: NSDictionary!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var photoURL = photo.valueForKeyPath("images.low_resolution.url") as String
        
        self.imageView.setImageWithURL(NSURL(string: photoURL))

       
        // Do any additional setup after loading the view.
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
