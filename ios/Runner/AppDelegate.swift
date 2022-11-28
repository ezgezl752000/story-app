import UIKit
import Firebase
import FBSDKCoreKit
import FirebaseMessaging
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   
         if FirebaseApp.app() == nil {
                       FirebaseApp.configure()
                   }
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application,		 didFinishLaunchingWithOptions: launchOptions)
  }
    // 👇 this block
     override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       // NOTE: For logging
       // let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
       // print("==== didRegisterForRemoteNotificationsWithDeviceToken ====")
       // print(deviceTokenString)
       Messaging.messaging().apnsToken = deviceToken
     }
}
