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
  
  public func initializeRealm() {
    let realm = try! Realm()
    
    guard realm.isEmpty else { return }
    
    try! realm.write {
      realm.add(ArticleObject())
    }
  }
}
