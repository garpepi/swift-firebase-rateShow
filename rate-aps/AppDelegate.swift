//
//  AppDelegate.swift
//  rate-aps
//
//  Created by Garpepi Aotearoa on 15/08/22.
//

import UIKit
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self

              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
            }

            application.registerForRemoteNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// MARK: - Firebase
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func setupFirebase(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { isSuccess, error in
            if let error = error {
                print("error authorization firebase = \(error.localizedDescription)")
            }
            if isSuccess {
                print("success authorization firebase")
            }
        })
        application.registerForRemoteNotifications()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("userInfo = \(userInfo)")
        guard let userInfo = userInfo["google.c.a.c_l"] as? String else {return}

        if userInfo == "rateApp" {
            StoreKitHelper.displayStoreKit()
        }
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)

        handleRouting(from: userInfo)

        completionHandler()
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
    }
}

// MARK: - Firebase Handle Routing
private extension AppDelegate {
    func handleRouting(from userInfo: [AnyHashable: Any]) {
        print("NOTIF!", userInfo)
        guard let isMarcomNews = userInfo["isMarcomNews"] as? String else { return }
        let state = UIApplication.shared.applicationState
        switch state {
        case .background, .active, .inactive:
            print("isMarcomNews", isMarcomNews)
        default:
            break
        }
    }
}
