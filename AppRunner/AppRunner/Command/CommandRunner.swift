//
//  📝CommandRunner.swift
//  🗄️AppRunner
//
//  Created🗜️ by Yurii Boiko👨‍💻 on 30.11.2020🗓️.
//
//
//  Copyright (c) 2020 Yurii Boiko
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
     

import Foundation
import os

struct CommandRunner {
    let commands: [Command]
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "\(CommandRunner.self)")
    
    func run(completion: @escaping (() -> Void)) {
        let filtered = commands.filter { $0.shouldExecute }
        if filtered.isEmpty {
            logger.notice("📝 -> Empty commands, aborting....")
            completion()
            return
        }
        runFiltered(commands: filtered) {
            completion()
        }
    }
    
    func runFiltered(commands: [Command], completion: @escaping (() -> Void)) {
        if let first = commands.first {
            runCommand(command: first) {
                runFiltered(commands: Array(commands.dropFirst()), completion: completion)
            }
        } else {
            completion()
        }
    }
    
    private func runCommand(command: Command, completion: @escaping (() -> Void)) {
        logger.notice("🏃‍♂️ -> Running \(command.path, align: .left(columns: 5), privacy: .public)")
        guard let commandFilePath = Bundle.main.path(forResource: command.path, ofType:"command") else {
            logger.fault("🧨 -> Unable to locate \(command.path, align: .left(columns: 5), privacy: .public)")
            return
        }
        let executableURL = URL(fileURLWithPath: "/bin/sh")
        let process = Process()
        process.executableURL = executableURL
        process.arguments = ["-c", "sh \(commandFilePath)"]
        process.terminationHandler = { terminatedProcess in
            if case .uncaughtSignal = terminatedProcess.terminationReason {
                logger.fault("🧨 -> \(commandFilePath, align: .left(columns: 5), privacy: .public), error: \(executableURL, privacy: .public)")
            }
            completion()
        }
        process.qualityOfService = .userInteractive
        do {
            try process.run()
        } catch let error {
            logger.fault("🧨 -> \(commandFilePath, align: .left(columns: 5), privacy: .public), error: \(error.localizedDescription, privacy: .public)")
        }
    }
}
