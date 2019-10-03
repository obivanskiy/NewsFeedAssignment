//
//  NetworkService.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation




class NetworkService {
  public static let shared = NetworkService()
  
  private init() { }
  
  func performRequest(for requestURL: String) {
    guard let url = URL(string: requestURL) else { return }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        print(error.localizedDescription)
    }
      
      if let response = response {
        print(response)
      }
      
      if let data = data {
        JSONSerializer.init().saveDecodedDataToDatabase(from: data, into: NewsFeed.self)  
      }
    }
    task.resume()
  }
}

