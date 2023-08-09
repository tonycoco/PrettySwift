//
//  PrettySwiftError.swift
//  PrettySwift
//
//  Created by Tony Coconate on 8/10/23.
//

import Foundation

enum PrettySwiftError: Error {
  case notSwift

  public var description: String {
    switch self {
    case .notSwift:
      return "Not a Swift source file."
    }
  }
}
