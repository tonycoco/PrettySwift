//
//  LintCommand.swift
//  PrettySwift
//
//  Created by Tony Coconate on 8/9/23.
//

import Foundation
import SwiftFormat
import SwiftFormatConfiguration
import XcodeKit

class LintCommand: NSObject, XCSourceEditorCommand {
  func perform(
    with invocation: XCSourceEditorCommandInvocation,
    completionHandler: @escaping (Error?) -> Void
  ) {
    if !supportedContentUTIs.contains(invocation.buffer.contentUTI) {
      return completionHandler(nil)
    }

    let input = invocation.buffer.completeBuffer
    let config = Configuration()
    let lines = invocation.buffer.lines
    let linter = SwiftLinter(configuration: config) { finding in
      var pragma = ""
      pragma.append("; #\(finding.severity)")
      pragma.append("(\"")
      pragma.append("[\(finding.category)] \(finding.message)")

      if !finding.notes.isEmpty {
        let findingNotes = finding.notes.map { $0.message.description }
        pragma.append("\n\n\(findingNotes.joined(separator: "\n\n"))")
      }

      pragma.append("\")")

      let findingLocation = finding.location!.line
      let existingLine = lines[findingLocation - 1] as! String
      let replacementLine = "\(existingLine.dropLast())\(pragma)\n"

      lines.replaceObject(at: findingLocation - 1, with: replacementLine)
    }

    do {
      try linter.lint(source: input, assumingFileURL: URL(fileURLWithPath: "<stdin>"))
    } catch {
      return completionHandler(error)
    }

    return completionHandler(nil)
  }
}
