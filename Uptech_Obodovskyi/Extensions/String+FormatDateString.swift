//
//  String+FormatDateString.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/3/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation

extension String {
  func formatDate() -> String {
    let formatter = DateFormatter()

    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
    
    if let date = formatter.date(from: self) {
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    return ""
  }
}

