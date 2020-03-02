//
//  FeedViewController.swift
//  TheGram
//
//  Created by Hugh Bromund on 2/17/20.
//  Copyright © 2020 Hugh Bromund. All rights reserved.
//

import UIKit
import Parse
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    
    let orange = UIColor(red:1.00, green:0.45, blue:0.08, alpha:1.0)
    let white = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    let grey = UIColor(red:0.23, green:0.21, blue:0.21, alpha:1.0)
    let darkGrey = UIColor(red:0.14, green:0.13, blue:0.13, alpha:1.0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UINavigationItem!
    
    let commentBar = MessageInputBar()
    
    var showsCommentBar = false;
    
    var posts = [PFObject]()
    
    var selectedPost: PFObject!
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = darkGrey
        tableView.backgroundColor = darkGrey

        navigationController?.navigationBar.barTintColor = grey
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: orange]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        // Do any additional setup after loading the view.
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self as MessageInputBarDelegate
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    @IBAction func logoutDidClick(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let feedNavigationController = main.instantiateViewController(identifier: "LoginViewController")
        // let delegate = UIApplication.shared.delegate as! AppDelegate
        
        self.view.window?.rootViewController = feedNavigationController
        
        
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the Comment
        let comment = PFObject(className: "Comments")
        
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()

        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment Saved")
                self.tableView.reloadData()
            } else {
                print("Error")
                print(error!)
            }
        }
        
        // Clear and dismiss the comment bar
        
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        
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
        let post = posts[section]
        
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        // print(comments.count)
        return comments.count + 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            // Post Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
            
            let user = post["author"] as! PFUser
            
            cell.usernameLabel.text = "@" + (user.username ?? "NO_USERNAME")
            cell.commentLabel.text = post["caption"] as? String
            
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.postImageView?.af_setImage(withURL: url)
            
            return cell
        } else if indexPath.row <= comments.count {
            // Comment Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
            
            
            // print(indexPath.row - 1)
            
            
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            
            cell.usernameLabel.text = "-> @" + (user.username ?? "NO_USERNAME")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            cell.backgroundColor = darkGrey
            
            
            return cell
        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
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
