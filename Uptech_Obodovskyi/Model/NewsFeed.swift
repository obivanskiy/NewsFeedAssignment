//
//  NewsFeed.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation

class NewsFeed: Codable {
    
    var articles: [ArticleObject]?
    
    public enum CodingKeys: String, CodingKey {
      case articles
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(articles, forKey: .articles)
    }

    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      articles = try container.decodeIfPresent([ArticleObject].self, forKey: .articles) ?? []
    }
}
