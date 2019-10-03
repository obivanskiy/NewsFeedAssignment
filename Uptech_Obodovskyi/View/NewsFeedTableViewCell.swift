//
//  NewsFeedTableViewCell.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var articleDescription: UILabel!
  
  override func prepareForReuse() {
    articleImage.image = nil
    articleTitle.text = nil
    articleDescription.text = nil
  }
  
  func setUpCellData(from object: ArticleObject) {
    self.articleTitle.text = object.title
    self.articleDescription.text = object.articleDescription
    self.articleImage.fetchImage(with: object.urlToImage)
  }
}
