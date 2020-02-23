//
//  FeedViewController.swift
//  TheGram
//
//  Created by Hugh Bromund on 2/17/20.
//  Copyright © 2020 Hugh Bromund. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let orange = UIColor(red:1.00, green:0.45, blue:0.08, alpha:1.0)
    let white = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    let grey = UIColor(red:0.23, green:0.21, blue:0.21, alpha:1.0)
    let darkGrey = UIColor(red:0.14, green:0.13, blue:0.13, alpha:1.0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UINavigationItem!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = darkGrey
        tableView.backgroundColor = darkGrey

        navigationController?.navigationBar.barTintColor = grey
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: orange]
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            } else {
                print("Error querying posts")
                print(error!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        cell.commentLabel.text = post["caption"] as! String
        
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.postImageView?.af_setImage(withURL: url)
        
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
