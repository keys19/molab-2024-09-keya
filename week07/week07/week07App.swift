//
//  week07App.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

import SwiftUI

@main
struct week07App: App {
    @StateObject private var document = Document()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(document)
        }
    }
}

