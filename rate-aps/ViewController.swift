//
//  ViewController.swift
//  rate-aps
//
//  Created by Garpepi Aotearoa on 15/08/22.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonTrigger: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("test")

//        guard let scene = UIApplication.shared.foregroundActiveScene else { return }
//        SKStoreReviewController.requestReview(in: scene)
    }

    // MARK: RATE-APPS
    func requestReviewManually() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    @IBAction func triggered(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
}


