//
//  Article.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Realm
import RealmSwift


class ArticleObject: Object, Codable {
  @objc dynamic var id = UUID().uuidString
  
  override class func primaryKey() -> String? {
    return "title"
  }
  
  @objc dynamic var author: String?
  @objc dynamic var articleDescription: String?
  @objc dynamic var title: String?
  @objc dynamic var url: String?
  @objc dynamic var urlToImage: String?
  @objc dynamic var content: String?
  @objc dynamic var publishedAt: String?
  
  static func all(in realm: Realm = try! Realm()) -> Results<ArticleObject> {
    return realm.objects(ArticleObject.self)
      .sorted(byKeyPath: ArticleObject.primaryKey()!)
  }
  
  required init() {
    super.init()
  }
  
  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }
  
  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
  
  public enum CodingKeys: String, CodingKey {
    case author, title, url
    case articleDescription = "description"
    case urlToImage, publishedAt, content
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(author, forKey: .author)
    try container.encode(title, forKey: .title)
    try container.encode(articleDescription, forKey: .articleDescription)
    try container.encode(url, forKey: .url)
    try container.encode(urlToImage, forKey: .urlToImage)
    try container.encode(publishedAt, forKey: .publishedAt)
    try container.encode(content, forKey: .content)
  }
  
  
  required init(from decoder: Decoder) throws {
    super.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription) ?? ""
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
    publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
    content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
  }
}


