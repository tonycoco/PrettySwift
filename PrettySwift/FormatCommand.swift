//
//  FormatCommand.swift
//  PrettySwift
//
//  Created by Tony Coconate on 8/9/23.
//

import Foundation
import SwiftFormat
import SwiftFormatConfiguration
import XcodeKit

class FormatCommand: NSObject, XCSourceEditorCommand {
  func perform(
    with invocation: XCSourceEditorCommandInvocation,
    completionHandler: @escaping (Error?) -> Void
  ) {
    if !supportedContentUTIs.contains(invocation.buffer.contentUTI) {
      return completionHandler(nil)
    }

    let input = invocation.buffer.completeBuffer
    let config = Configuration()
    let formatter = SwiftFormatter(configuration: config)
    var stream = PrettySwiftOutputStream()
    let originalSelections = invocation.buffer.selections as! [XCSourceTextRange]

    do {
      try formatter.format(source: input, assumingFileURL: nil, to: &stream)
    } catch {
      return completionHandler(error)
    }

    let output = stream.output

    if output == input {
      return completionHandler(nil)
    }

    invocation.buffer.completeBuffer = output ?? input

    invocation.buffer.selections.removeAllObjects()
    for selection in originalSelections {
      invocation.buffer.selections.add(selection)
    }

    return completionHandler(nil)
  }
}
