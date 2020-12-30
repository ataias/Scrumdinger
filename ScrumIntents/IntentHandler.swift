//
//  IntentHandler.swift
//  ScrumIntents
//
//  Created by Ataias Pereira Reis on 30/12/20.
//

import Intents
import SwiftUI

public enum Constants {
    static let storage = "demostorage"
    static let group = "br.com.ataias.Scrumdinger"
}

class IntentHandler: INExtension {
    @AppStorage(Constants.storage, store: UserDefaults(
                    suiteName: Constants.group)) var store: String = "ORIGINAL"

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.

        store = "CALLED AT \(Date())"
        return ScrumIntentHandler()
    }
    
}
