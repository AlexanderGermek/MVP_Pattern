//
//  PhotosPresenterVC.swift
//  AG_GoraTest
//
//  Created by iMac on 16.02.2021.
//

import Foundation


protocol PhotosVCDelegate {
    
    func displayData(photos: [Photo])
}


class PhotosPresenter: NSObject {
    
    var delegate: PhotosVCDelegate!

    func getAlbumsId(forUsersId userID: Int, completion: @escaping (_ albumsId: [Int]) -> ()){
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print("error = \(error!)")
                return
            }
            
            let decoder = JSONDecoder()
            if let data = data, let albumsId = try? decoder.decode([Album].self, from: data){
                
                let albumsForUserId = albumsId.filter { $0.userId == userID}
                
                let albumsIdForUserId = albumsForUserId.map{$0.id}
                
                completion(albumsIdForUserId)
            }
        }.resume()
        
    }
    
    func getPhotos(forAlbumsID albumsId: [Int], completion: @escaping(_ photos: [Photo]) -> ()){
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print("error = \(error!)")
                return
            }
            
            let decoder = JSONDecoder()
            if let data = data, let allPhotos = try? decoder.decode([Photo].self, from: data){
                //dump(allPhotos)
                let photosForAlbumsId    = allPhotos.filter{ albumsId.contains($0.albumId)}
                completion(photosForAlbumsId)
            }
        
        }.resume()
    }
    
}// class
