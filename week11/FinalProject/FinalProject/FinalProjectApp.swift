//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Keya Shah on 17/11/2024.
//


import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FinalProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
