//
//  IntentHandler.swift
//  ScrumIntents
//
//  Created by Ataias Pereira Reis on 30/12/20.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return ScrumIntentHandler()
    }
    
}
