//
//  ContentView.swift
//  Shared
//
//  Created by Obverser on 1/23/21.
//

import SwiftUI
import Sword

struct ContentView: View {
    @EnvironmentObject var bot: botObj
    @State var isCommand: String = ""
    @State var selectedView: String? = "Console"
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    NavigationLink(destination: consoleView(), tag: "Console", selection: $selectedView) {
                        Label("Console", systemImage: "display")
                    }
                    NavigationLink(destination: settingsView(), tag: "Settings", selection: $selectedView) {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink(destination: commandsView(), tag: "Commands", selection: $selectedView) {
                        Label("Commands", systemImage: "command")
                    }
                }
            }
        }
    }
    
    
    func changeBotStatus(_ state: Bool) {
        if state == true {
            printFake("Connecting bot...")
            bot.tokenFinish()
            bot.client?.connect()
            bot.client?.on(.ready) { _ in
                printFake("Connected")
            }
            bot.client?.on(.messageCreate) { data in
                let msg = data as! Message
                if msg.content == "!yee" {
                    msg.channel.send("Yee")
                    printFake("'!yee' ran by user: \(msg.author?.username ?? "UNWRAP_USER_NAME") (\(msg.author?.id ?? 00000))")
                }
            }
        } else {
                printFake("Disconnecting bot...")
                bot.prepareDisconnect()
                printFake("Disconnected")
        }
    }
    func printFake(_ text: String) {
        bot.consoleInput = "\(bot.consoleInput)\n\(text)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
extension Binding {
    func didSet(execute: @escaping (Value) -> Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                self.wrappedValue = $0
                execute($0)
            }
        )
    }
}

