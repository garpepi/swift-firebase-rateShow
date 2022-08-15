//
//  StoreReviewController.swift
//  rate-aps
//
//  Created by Garpepi Aotearoa on 15/08/22.
//

import Foundation
import StoreKit

struct StoreKitHelper {
    static let numberOfTimesLaunchedKey = "numberOfTimesLaunched"

    static func displayStoreKit() {
        let numberOfTimesLaunched: Int = UserDefaults.standard.integer(forKey: StoreKitHelper.numberOfTimesLaunchedKey)
        if numberOfTimesLaunched < 3 {
            print("HIT BE HERE")
            SKStoreReviewController.requestReview()
            let numberOfTimesLaunched: Int = UserDefaults.standard.integer(forKey: StoreKitHelper.numberOfTimesLaunchedKey) + 1
            UserDefaults.standard.set(numberOfTimesLaunched, forKey: StoreKitHelper.numberOfTimesLaunchedKey)
        } else {
            print("Already 3 TIMES! TELL BE?")
            print("Relay to manual rate app?")
        }
    }
}
