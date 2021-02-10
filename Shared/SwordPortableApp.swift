//
//  botPortApp.swift
//  Shared
//
//  Created by Obverser on 1/23/21.
//

import SwiftUI
import Sword
@main
struct SwordPortableApp: App {
    var body: some Scene {
        WindowGroup {
            var bot: botObj = botObj()
            ContentView().environmentObject(bot)
        }
    }
}
class botObj: ObservableObject {
    @Published var token: String
    @Published var client: Sword?
    @Published var consoleInput: String
    @Published var isOn: Bool
    init() {
        self.token = ""
        self.client = nil
        self.consoleInput = "botPort - Version 0.1\n© Gabriel Linecker 2021"
        self.isOn = false
    }
    func prepareDisconnect() {
        self.client?.editStatus(to: "offline")
        self.client?.disconnect()
        self.client = nil
    }
    func tokenFinish() {
        self.client = Sword(token: token)
        print(token)
        client?.editStatus(to: "online", playing: "botPort")
    }
}

