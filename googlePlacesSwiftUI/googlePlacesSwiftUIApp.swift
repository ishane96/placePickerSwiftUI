//
//  googlePlacesSwiftUIApp.swift
//  googlePlacesSwiftUI
//
//  Created by Achintha Kahawalage on 2021-07-21.
//

import SwiftUI
import GooglePlaces

@main
struct googlePlacesSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyDj1QJpCZ_1JogD3bhnkXHqJnj3A9UgjM8")
         return true
     }
 }
