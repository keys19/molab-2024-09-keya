////
////  SignupView.swift
////  week06
////
////  Created by Keya Shah on 17/10/2024.
////
//
//import Foundation
//import SwiftUI
//
//struct User: Codable {
//    var username: String
//    var password: String
//}
//
//// Load the JSON file from the app bundle
////func loadUsersFromFile() -> [User] {
////    if let path = Bundle.main.path(forResource: "users", ofType: "json") {
////        do {
////            let data = try Data(contentsOf: URL(fileURLWithPath: path))
////            let decoder = JSONDecoder()
////            return try decoder.decode([User].self, from: data)
////        } catch {
////            print("Error loading users: \(error.localizedDescription)")
////        }
////    }
////    return []
////}
//
//// Write the updated list of users back to the file (for testing, we should write back to Documents directory)
////func writeUsersToFile(users: [User]) {
////    // Get path to the document directory to store updated users.json
////    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////        let fileURL = dir.appendingPathComponent("users.json")
////        
////        do {
////            let data = try JSONEncoder().encode(users)
////            try data.write(to: fileURL)
////        } catch {
////            print("Error saving users: \(error.localizedDescription)")
////        }
////    }
////}
//
//struct SignupView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isSignedUp: Bool = false
//    @State private var showError: Bool = false
//    
//    var body: some View {
//        VStack {
//            TextField("Enter Username", text: $username)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//            
//            SecureField("Enter Password", text: $password)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//            
//            Button(action: {
//                // Load the current list of users
//                var users = loadUsersFromFile()
//                
//                // Check if the username already exists
//                if users.contains(where: { $0.username == username }) {
//                    showError = true
//                } else {
//                    // Add the new user
//                    let newUser = User(username: username, password: password)
//                    users.append(newUser)
//                    writeUsersToFile(users: users)
//                    isSignedUp = true
//                    showError = false
//                }
//            }) {
//                Text("Sign Up")
//                    .font(.title2)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//            
//            if showError {
//                Text("Username already exists")
//                    .foregroundColor(.red)
//            }
//            
//            if isSignedUp {
//                Text("Sign Up Successful!")
//                    .foregroundColor(.green)
//            }
//        }
//        .padding()
//    }
//}
