//
//  PrettySwiftOutputStream.swift
//  PrettySwift
//
//  Created by Tony Coconate on 8/10/23.
//

import Foundation

struct PrettySwiftOutputStream: TextOutputStream {
  var output: String?

  mutating func write(_ string: String) {
    output = string
  }
}
