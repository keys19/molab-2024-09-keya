//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Keya Shah on 17/11/2024.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAppCheck


@main
struct FinalProjectApp: App {
    init() {
        FirebaseApp.configure()
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
