//
//  📝MainView.swift
//  🗄️AppRunner
//
//  Created🗜️ by Yurii Boiko👨‍💻 on 24.11.2020🗓️.
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
     
import SwiftUI
import Combine
import os

struct MainView: View {
    @State private var isRunning = false
    @State private var commands = Command.standartList
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "\(MainView.self)")
    
    var body: some View {
        VStack {
            Text("AppRunner")
                .font(.largeTitle)
                .padding()
            Text("Lets you run lots of great stuff for app development")
                .font(.body)
                .padding()
            Button(action: { runAllCommands() }) {
                Text("Run!")
            }
            .disabled(isRunning)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
