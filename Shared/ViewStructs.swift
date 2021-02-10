//
// Created by Obverser on 2/7/21.
//

import Foundation
import SwiftUI
import Sword

struct settingsView: View {
    @EnvironmentObject var bot: botObj
    var body: some View {
        Form {
            VStack {
                Toggle(isOn: $bot.isOn.didSet { (state) in
                    changeBotStatus(state)
                }) {
                    Text("Bot Status")
                }
                TextField("Token", text: $bot.token)
            }
        }
    }
    func printFake(_ text: String) {
        bot.consoleInput = "\(bot.consoleInput)\n\(text)"
    }
    func changeBotStatus(_ state: Bool) {
        if state == true {
            if (bot.token == "") {
                bot.isOn = false
                return
            }
            printFake("Connecting bot...")
            bot.tokenFinish()
            bot.client?.connect()
            bot.client?.on(.ready) {_ in
                printFake("Connected")
            }
            bot.client?.on(.messageCreate) {data in
                let msg = data as! Message
                if msg.content == "!yee" {
                    msg.channel.send("Yee")
                    printFake("'!yee' ran by user: \(msg.author?.username ?? "UNWRAP_USER_NAME") (\(msg.author?.id ?? 00000))")
                    print("Ran!")
                }
            }
        } else {
                printFake("Disconnecting bot...")
                bot.prepareDisconnect()
                printFake("Disconnected")
        }
    }
}

struct consoleView: View {
    @EnvironmentObject var bot: botObj
    @State var isCommand = ""
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                    .overlay(
                            ScrollView {
                                Text(bot.consoleInput)
                                        .colorInvert()
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                        .padding()
                            }
                    )
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            HStack {
                TextField("Type a command", text: $isCommand).padding()
                Button(action: {
                    printFake("> \(isCommand)")
                    isCommand = ""
                }, label: {
                    Text("Send")
                }).padding()
            }
        }
    }
    func printFake(_ text: String) {
        bot.consoleInput = "\(bot.consoleInput)\n\(text)"
    }
}

struct commandsView: View {
    var body: some View {
        Text("ToDo")
        //Todo
    }
}
