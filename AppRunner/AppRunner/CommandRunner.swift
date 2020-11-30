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

struct CommandRunner {
    let commands: [Command]
    
    func run(completion: @escaping (() -> Void)) {
        let filtered = commands.filter { $0.shouldExecute }
        if filtered.isEmpty {
            completion()
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
        guard let commandFilePath = Bundle.main.path(forResource: command.path, ofType:"command") else {
            print("Unable to locate \(command.path).command")
            return
        }
        let executableURL = URL(fileURLWithPath: "/bin/sh")
        _ = try? Process.run(executableURL,
                             arguments: ["-c", "sh \(commandFilePath)"],
                             terminationHandler: { _ in
                                completion()
                             })
    }
}
