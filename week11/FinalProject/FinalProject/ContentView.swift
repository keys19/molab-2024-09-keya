//
//  ContentView.swift
//  FinalProject
//
//  Created by Keya Shah on 17/11/2024.
//


import SwiftUI
import Firebase
import FirebaseFirestore

//struct ContentView: View {
//    var body: some View {
//        Text("Testing Firebase!")
//            .onAppear {
//                testFirestore()
//            }
//    }
//    
//    func testFirestore() {
//        let db = Firestore.firestore()
//        db.collection("testCollection").addDocument(data: ["name": "Test User"]) { error in
//            if let error = error {
//                print("Error writing to Firestore: \(error)")
//            } else {
//                print("Firestore write successful!")
//            }
//        }
//    }
//}

struct ContentView: View {
    var body: some View {
        LandingPageView()
    }
}


#Preview {
    ContentView()
}
