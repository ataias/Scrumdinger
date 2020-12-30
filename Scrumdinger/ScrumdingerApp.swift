//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ataias Pereira Reis on 23/12/20.
//

import SwiftUI
import Intents

@main
struct ScrumdingerApp: App {
    @ObservedObject private var data = ScrumData()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
                INPreferences.requestSiriAuthorization({ status in
                    switch status {
                    case .authorized:
                        print("Great! Authorized Siri Access")
                    default:
                        print("Siri access denied!")
                    }
                })
            }
        }
    }
}
