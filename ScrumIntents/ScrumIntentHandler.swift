//
//  ScrumIntentHandler.swift
//  ScrumIntents
//
//  Created by Ataias Pereira Reis on 30/12/20.
//

import Foundation
import Intents

class ScrumIntentHandler: NSObject, ScrumIntentHandling {
    func handle(intent: ScrumIntent, completion: @escaping (ScrumIntentResponse) -> Void) {
        if let name = intent.name {
            print("Processing intent")
            completion(ScrumIntentResponse.success(name: name))
        } else {
            completion(ScrumIntentResponse(code: .failure, userActivity: nil))
        }
    }

    func resolveName(for intent: ScrumIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        var result: INStringResolutionResult
        if let name = intent.name {
            // TODO check storage to see if name matches an existing scrum
            print(name)
            result = INStringResolutionResult.success(with: name)
        } else {
            result = INStringResolutionResult.needsValue()
        }

        completion(result)
    }

}
