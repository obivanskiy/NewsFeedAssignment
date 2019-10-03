//
//  NewsFeedPresenter.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/4/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation
import RealmSwift

class NewsFeedPresenter {

  init() {
    performArticleRequest()
  }
  
  private func performArticleRequest() {
    DispatchQueue.global(qos: .background).async {
      NetworkService.shared.performRequest(for: NetworkEndpoints.newsFeedUrl + NetworkEndpoints.apiKey)
    }
  }
  
  func fetchArticlesFromDatabase() -> Results<ArticleObject> {
    return ArticleObject.all()
  }
}
