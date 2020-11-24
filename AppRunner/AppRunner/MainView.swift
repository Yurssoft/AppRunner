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

struct MainView: View {
    @State private var isRunning = false
    var body: some View {
        VStack {
            Text("AppRunner")
                .font(.largeTitle)
                .padding()
            Text("Lets you run lots of great stuff for app development")
                .font(.body)
                .padding()
            Button(action: { runTerminal() }) {
                Text("Run!")
            }
            .disabled(isRunning)
            .padding(.trailing)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func runTerminal() {
        guard let path = Bundle.main.path(forResource: "RunScript",ofType:"command") else {
          print("Unable to locate BuildScript.command")
          return
        }
        let executableURL = URL(fileURLWithPath: "/bin/sh")
        self.isRunning = true
        try! Process.run(executableURL,
                         arguments: ["-c", "sh \(path)"],
                         terminationHandler: { _ in 
                            self.isRunning = false
                         })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
