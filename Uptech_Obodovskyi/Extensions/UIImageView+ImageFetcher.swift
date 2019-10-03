//
//  UIImageView+ImageFetcher.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/3/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  func fetchImage(with urlString: String?) {
    guard let urlStr = urlString else { return }
    guard let url = URL(string: urlStr) else { return }
    
    DispatchQueue.main.async { [weak self] in
      self?.kf.setImage(with: url)
    }
  }
}
