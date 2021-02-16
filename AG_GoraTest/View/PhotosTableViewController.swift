//
//  PhotosTableViewController.swift
//  AG_GoraTest
//
//  Created by iMac on 29.01.2021.
//

import UIKit

class PhotosTableViewController: UITableViewController, PhotosVCDelegate {
    
    
    @IBOutlet weak var photosTableView: UITableView!
    
    var currentUserID: Int = 0
    var photosAndURLs: [Photo] = []
    var flag = false
    var presenter: PhotosPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = PhotosPresenter()
        self.presenter.delegate = self

        let queue = DispatchQueue.global(qos: .default)
        
        queue.async { [unowned self] in
            
            self.presenter.getAlbumsId(forUsersId: self.currentUserID) { [unowned self] (albumsID) in
                
                queue.sync {
                    
                    self.presenter.getPhotos(forAlbumsID: albumsID) { (photosAndURLs) in
                        
                        displayData(photos: photosAndURLs)
                   }
               }
            }
        }

    }
    
    
    //MARK: PhotosVCDelegate ====================================================================================================
    func displayData(photos: [Photo]) {
        
        self.photosAndURLs = photos
        
        DispatchQueue.main.async {
            self.flag = true
            self.photosTableView.reloadData()
        }
        
    }
    
    //PhotosVCDelegate ====================================================================================================
 
        
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photosAndURLs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "photo_cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotoTableViewCell


        if flag {
            let urlString = self.photosAndURLs[indexPath.row].url

            cell.photoImageURL = URL(string: urlString)
            let text = self.photosAndURLs[indexPath.row].title
            cell.titleLabel.text      = text
            cell.titleLabel.numberOfLines = 0
            cell.titleLabel.lineBreakMode = .byWordWrapping
        } 

        return cell
    }

}
