//
//  BlogViewController.swift
//  Course Project
//
//  Created by Marcel Harvan on 2017-12-19.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit
import Foundation

class BlogViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var blog: Blog!
    var dataService = BlogController.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        BlogController.sharedInstance.fetchListInfo(onSuccess: onSuccessScenario, onFail: onFailScenario)
    }
    
    private func onSuccessScenario() {
        // Call the main thread to do the next line code to avoid any thread conflict
        DispatchQueue.main.async {
            // Force reload the table view data
            self.tableView.reloadData()
        }
    }
    
    private func onFailScenario(errorMessage: String) {
        print(errorMessage)
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return BlogController.sharedInstance.list.count
        }
        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////            let blog = BlogController.sharedInstance.list[indexPath.row]
////            let rawCell = Bundle.main.loadNibNamed("BlogCell", owner: BlogCell, options: <#T##[AnyHashable : Any]?#>)
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as? BlogCell {
//                cell.configureCell(blog: dataService.list[indexPath.row])
//                return cell
//            } else {
//                return UITableViewCell()
//            }
//
//        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blog = BlogController.sharedInstance.list[indexPath.row]
        
        guard let blogCell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as? BlogCell else {
               // TODO: Handle error scenario
               return UITableViewCell()
        }
        
        blogCell.configureCell(blog: blog)
        
        return blogCell
    }

        
//      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let blog = BlogController.sharedInstance.list[indexPath.row]
//
//        }
    
    
}





    
//    // This method will be called when fetchListInfo from Controller is finished with fail scenario
//    private func onFailScenario(errorMessage: String) {
//        print(errorMessage)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return TableView.cellForRow(at: indexPath)!
//    }
//
//}

