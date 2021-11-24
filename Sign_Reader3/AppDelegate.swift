//
//  AppDelegate.swift
//  Sign_Reader3
//
//  Created by Joseph Tooker on 9/22/21.
//

import UIKit
import AWSCore
import GooglePlaces
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //AWS Rekognition Credentials
        let credentialsProvider = AWSCognitoCredentialsProvider (
            regionType: .USEast2,
            identityPoolId: "us-east-2:afce9045-22d8-4815-bf25-94d7c2503b90")
        let configuration = AWSServiceConfiguration (
            region: .USEast2,
            credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        //Google Credentials
        GMSPlacesClient.provideAPIKey("AIzaSyCrnoUisImqGo7Dxvv4kF713SGoPt5vH0Y")
        GMSServices.provideAPIKey("AIzaSyC7CbcI18W_Z_Ti6DeupIC46tadlYNDVCo")
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

