//
//  ArticleViewController.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/3/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
  
  @IBOutlet weak var hyperlinkTextView: UITextView!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var articleText: UILabel!
  @IBOutlet weak var publicationDate: UILabel!
  @IBOutlet weak var articleSource: UILabel!
  @IBOutlet weak var articleScrollView: UIScrollView!
  
  var articleDetails: ArticleObject?
  
  override func viewDidLoad() {
    setUpUIData()
    hyperlinkTextView.delegate = self
  }
  
  private func setUpUIData() {
    guard let article = articleDetails else { return }
    
    navigationItem.title = article.title
    
    articleTitle.text = article.title
    
    if let content = article.content, !content.isEmpty {
      articleText.text = content.replaceSpaces()
      print(content)
    } else {
      articleText.text = article.articleDescription
    }
    
    articleSource.text = article.author
    publicationDate.text = article.publishedAt?.formatDate()
    articleImage.fetchImage(with: article.urlToImage)
    setHyperlink(from: article.url)
  }
  
  private func setHyperlink(from string: String?) {
    
    guard let url = URL(string: string!) else { return }
    let attributedString = NSMutableAttributedString(string: Identifiers.hyperlink)
    attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: attributedString.length))
    
    hyperlinkTextView.attributedText = attributedString
  }
  
}

extension ArticleViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    UIApplication.shared.open(URL)
    return false
  }
}



