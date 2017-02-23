//
//  SeshhFeedVC.swift
//  SeshhSocial
//
//  Created by User on 17/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import Firebase

class SeshhFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var seshhTableView: UITableView!
    
    var posts = [Post]()
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        seshhTableView.delegate = self
        seshhTableView.dataSource = self
        
        DataService.ds.REF_SESSHS.observe(.value, with: { (snapshot) in
            
            self.posts = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("CONNOR: SNAP \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(seshhPostKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.seshhTableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
        
            if let img = SeshhFeedVC.imageCache.object(forKey: post.seshhImgURL as NSString) {
                cell.configureCell(post: post, img: img)
            } else {
                cell.configureCell(post: post)
            }
            return cell
        } else {
            return PostCell()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
