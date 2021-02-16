//
//  UsersPresenterVC.swift
//  AG_GoraTest
//
//  Created by iMac on 16.02.2021.
//

import Foundation

protocol UsersVCDelegate {
    
    func startIndicator()
    func stopIndicatorAndDisplayData(data: [User])
}

class UsersPresenterVC: NSObject {
    
    var delegateUsers: UsersVCDelegate!
    
    init(delegate: UsersVCDelegate) {
        
        super.init()
        
        self.delegateUsers = delegate
        
        self.delegateUsers.startIndicator()
        
        getUsersFromServer { (users) in
            DispatchQueue.main.async {
                self.delegateUsers.stopIndicatorAndDisplayData(data: users)
            }
        }
        
    }
    
    
    func getUsersFromServer(completion: @escaping (_ users: [User]) -> ()){
        
            let url     = URL(string: "https://jsonplaceholder.typicode.com/users")!
            let session = URLSession.shared

            session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("error=\(error!)")
                    return
                }
                
                let decoder = JSONDecoder()
                if let data = data, let users = try? decoder.decode([User].self, from: data){
                    completion(users)
                }
            }.resume()
    }
    
    
}
