//
//  String+ReplaceNewlines.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/4/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation

extension String {
  func replaceSpaces() -> String {
    return self.components(separatedBy: .newlines).joined()
  }
}
