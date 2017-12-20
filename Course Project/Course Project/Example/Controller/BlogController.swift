//
//  BlogController.swift
//  Course Project
//
//  Created by Marcel Harvan on 2017-12-20.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation

import SystemConfiguration
import Foundation


final class BlogController {
    public private(set) var list : [Blog]
    public static let sharedInstance = BlogController()
    public var selectedUser: Blog? = nil
    private let url: String = "https://blog.marcelharvan.com/wp-json/wp/v2/posts"
    
    private init() {
        self.list = [Blog]()
    }
    
    func fetchListInfo(onSuccess: @escaping SuccessScenario, onFail: @escaping FailScenario) {
        guard let urlRequest = URL(string: url) else {
            onFail("Not possible to create the URL object")
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                onFail(error.localizedDescription)
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                    else {
                        onFail("Error on fetch.")
                        return
                }
                
                if let data = data {
                    self.list = try! self.convertToBlog(withData: data)
                    onSuccess()
                } else {
                    onFail("Data is null")
                }
            }
        })
        
        task.resume()
    }
    
      private func convertToBlog(withData data: Data) throws -> [Blog] {
        var tempList = [Blog]()
       
        
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)

        
        
        if let results = json as? [Dictionary<String,AnyObject>] {
            for jsonBlog in results {
                
                guard let date = jsonBlog["date"] as? String,
                let link = jsonBlog["link"] as? String,
                let title = jsonBlog["title"] as? [String:Any],
                let title1 = title["rendered"] as? String
                
                    else {
                        print("Not possible to find the Blog.")
                        break
                }
                
                tempList.append(Blog(title: title1, dateReleased: date, link: link))
                print("\(tempList)")
                print("\(title1)")
                print("The date is \(date)")
                print("The link is \(link)")
                
            }
        } else {
        
        print("No results tag found in response JSON.")
        }
          
        return tempList
            }
        
     
}









