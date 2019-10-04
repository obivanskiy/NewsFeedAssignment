//
//  RealmManager.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import RealmSwift

class RealmManager {
   
  public static let shared = RealmManager()
  
  private init() { }
  
  public func fetchArticleObjectsFromDB() -> Results<ArticleObject> {
    return ArticleObject.all()
  }

  public func saveArticleObjects(object: NewsFeed?) {
    let realm = try! Realm()
    
    guard let articles = object?.articles else { return }
    
    do {
      try articles.forEach { article in
        try realm.write {
          realm.add(article, update: .modified)
        }
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
