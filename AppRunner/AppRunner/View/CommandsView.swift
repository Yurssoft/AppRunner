//
//  📝CommandsView.swift
//  🗄️AppRunner
//
//  Created🗜️ by Yurii Boiko👨‍💻 on 26.01.2021🗓️.
//
//
//  Copyright (c) 2021 Yurii Boiko
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

import SwiftUI
import Combine
import os
     
struct CommandsView: View {
    @State private var isRunning = false
    @State private var commands = Command.standartList
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "\(CommandsView.self)")
    
    var body: some View {
        VStack {
            Text("Het Up This Mac")
                .font(.largeTitle)
                .padding()
            
            Button(action: { runAllCommands() }) {
                Text("Commands!")
            }
            .disabled(isRunning)
            .padding(.trailing)
            
            Button(action: { }) {
                Text("Stop!")
            }
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func runAllCommands() {
        logger.notice("📝 -> Starting running commands")
        isRunning = true
        CommandRunner(commands: commands)
            .run { isRunning = false }
    }
}

struct CommandsView_Previews: PreviewProvider {
    static var previews: some View {
        CommandsView()
    }
}
