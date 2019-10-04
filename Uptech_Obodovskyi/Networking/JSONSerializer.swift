//
//  JSONSerializer.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/3/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation
import RealmSwift


protocol RequestTypeSerializer{
  func decodedData<T: Codable>(from data: Data, into model: T.Type) -> T?
}

class JSONSerializer: RequestTypeSerializer {
  func saveDecodedDataToDatabase(from data: Data, into model: NewsFeed.Type) {
    
    let decodedObject = decodedData(from: data, into: model)
    
    RealmManager.shared.saveArticleObjects(object: decodedObject)
    
    NotificationCenter.default.post(name: NotificationEndpoints.articleDataFetched, object: nil)
  }
  
  func decodedData<T: Codable>(from data: Data, into model: T.Type) -> T? {
    return try? JSONDecoder().decode(model, from: data)
  }
}
