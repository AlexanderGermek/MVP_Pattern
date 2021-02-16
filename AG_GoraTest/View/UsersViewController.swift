//
//  ViewController.swift
//  AG_GoraTest
//
//  Created by iMac on 29.01.2021.
//

import UIKit

class ViewController: UITableViewController, UsersVCDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var presenter: UsersPresenterVC!
    
    var myUsers:   [User] = []
    var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = UsersPresenterVC(delegate: self)

    }
    
    //MARK: UITableViewDelegate ===============================================================================
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "user_cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let user = myUsers[indexPath.row]
        cell.textLabel?.text = user.name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    //UITableViewDelegate =====================================================================================
    
    
    //MARK: My functions ======================================================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.myTableView.indexPathForSelectedRow!
        
        let vc = segue.destination as! PhotosTableViewController
        vc.currentUserID = myUsers[indexPath.row].id
    }
    //My functions ============================================================================================
    
    
    //MARK: UsersVCDelegate ===================================================================================
    func startIndicator() {
        
        self.indicator = UIActivityIndicatorView(style: .large)
        self.indicator.startAnimating()
        self.indicator.hidesWhenStopped = true
        
        self.myTableView.backgroundView = indicator
    }
    
    func stopIndicatorAndDisplayData(data: [User]) {
        
        self.myUsers = data
        self.myTableView.reloadData()
        self.indicator.stopAnimating()
    }
    //UsersVCDelegate =========================================================================================

}

