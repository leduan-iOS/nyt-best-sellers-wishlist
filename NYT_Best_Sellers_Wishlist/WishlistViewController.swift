//
//  WishlistViewController.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/25/21.
//

import UIKit
import Parse

class WishlistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblNavWishlist: UINavigationItem!
    
    
    var store: BookStore!
    var books = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        store = BookStore()
        
        let username = PFUser.current()!.username
        
        lblNavWishlist.title = "\(username!)'s Wishlist"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // To make below code work, change 'estimate size' of 'Collection View' in storyboard
        // to 'None'. It is 'Automatic' by default. Select 'Collection View' > 'Size Inspector' > 'Estimate Size' > 'None'
        
        // Also, use autolayout on the image to make it grow and shrink with the collection item
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // control space in between the rows
        layout.minimumLineSpacing = 10
        // control space in between the columns
        layout.minimumInteritemSpacing = 10

        // Finally, specify item size
        // view.frame.size.width --> width of the phone
        // if we want 3 items per row --> (phoneWidth - interimItemSpace * 2) / 3   --> (interimItemSpace * 2) bc there will be two column separations if there are going to be 3 items: |item<->item<->item|
        // if we want 4 items per row --> (phoneWidth - interimItemSpace * 3) / 4   --> |item<->item<->item<->item|
        // etc
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 1) / 2

        layout.itemSize = CGSize(width: width, height: width * 3/2)     // here height is a function of width (3/2 times larger)
        
//        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.current()!
        let query = PFQuery(className: "Books")
        query.whereKey("nytUser", equalTo: user)
        query.includeKey("nytUser")     // this line includes the actual object instead of the reference
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) in
            
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) books.")
                // Do something with the found objects
                self.books = objects
                self.collectionView.reloadData()
//                for object in objects {
//                    print(object.objectId as Any)
//                }
            }
        }
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        // making delegate available for use
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ,let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginVC
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishlistBook", for: indexPath) as! BookCollectionViewCell
        
        let book = books[indexPath.row]
        let imageURL = book["book_image"] as! String
        let url = URL(string: imageURL)
        
        store.fetchBookImage(withURL: url) {
            (imageResult) in

            switch imageResult {
            case let .success(image):
                cell.bookImage.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let book = books[indexPath.item]
        
        let bookDetailsVC = segue.destination as! BookDetailsViewController
        
        bookDetailsVC.bookTitle = book["title"] as! String
        bookDetailsVC.bookAuthor = book["author"] as! String
        bookDetailsVC.bookDescription = book["description"] as! String
        bookDetailsVC.bookImageURL = book["book_image"] as! String
        bookDetailsVC.bookAmazonURL = book["amazon_product_url"] as! String
        
//        collectionView.deselectItem(at: IndexPath, animated: true)
    }
    

}
