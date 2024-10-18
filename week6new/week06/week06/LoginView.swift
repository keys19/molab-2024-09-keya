//
//  LoginView.swift
//  week06
//
//  Created by Keya Shah on 17/10/2024.
//



import SwiftUI
//for reading json file
struct AppUser: Codable {
    var username: String
    var password: String
    var favorites: [String]
}
//
//loading the JSON file
func loadUsersFrom() -> [AppUser] {
    if let path = Bundle.main.path(forResource: "user", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let users = try decoder.decode([AppUser].self, from: data)
            return users
        } catch {
            print("error loading users: \(error.localizedDescription)")
        }
    } else {
        print("file path not found")
    }
    return []
}

//
func writeUsersTo(users: [AppUser]) {
    // Get path to the document directory to store updated users.json
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent("user.json")
        
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: fileURL)
        } catch {
            print("error saving users: \(error.localizedDescription)")
        }
    }
}


struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showError: Bool = false
    @State private var users: [AppUser] = loadUsersFrom()
    @State private var currentUser: AppUser? = nil
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Button(action: {
                // load the list of users from the JSON file
                if let user = users.first(where: { $0.username == username && $0.password == password }) {
                    // if a matching user is found, log in and set currentUser
                    currentUser = user
                    isLoggedIn = true
                    showError = false
                } else {
                    // error if username or password is incorrect
                    showError = true
                }
            }) {
                Text("Login")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if showError {
                Text("Invalid username or password")
                    .foregroundColor(.red)
            }
            
            // navigation to MeditationSelectionView if login is successful
            if isLoggedIn, let currentUser = currentUser {
                NavigationLink(destination: MeditationSelectionView(currentUser: currentUser, users: users)) {
                    Text("Go to Meditation Menu")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
    }
}
//func getFileURL() -> URL? {
//    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//        return dir.appendingPathComponent("user.json")
//    }
//    return nil
//}
//
//
//func loadUsers() -> [AppUser] {
//    guard let fileURL = getFileURL() else {
//        print("Error getting file URL")
//        return []
//    }
//    
//    // Check if the file exists
//    if FileManager.default.fileExists(atPath: fileURL.path) {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            return try decoder.decode([AppUser].self, from: data)
//        } catch {
//            print("Error decoding users from file: \(error.localizedDescription)")
//            return []
//        }
//    } else {
//        // Return empty if the file doesn't exist yet
//        return []
//    }
//}
//
//func writeUsers(_ users: [AppUser]) {
//    guard let fileURL = getFileURL() else {
//        print("Error getting file URL")
//        return
//    }
//
//    do {
//        let data = try JSONEncoder().encode(users)
//        try data.write(to: fileURL)
//        print("Users saved successfully.")
//    } catch {
//        print("Error writing users to file: \(error.localizedDescription)")
//    }
//}
//
//struct LoginView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isLoggedIn: Bool = false
//    @State private var showError: Bool = false
//    @State private var users: [AppUser] = loadUsers()
//    @State private var currentUser: AppUser? = nil
//    
//    var body: some View {
//        VStack {
//            TextField("Username", text: $username)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//            
//            SecureField("Password", text: $password)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//            
//            Button(action: {
//                if let user = users.first(where: { $0.username == username && $0.password == password }) {
//                    currentUser = user
//                    isLoggedIn = true
//                    showError = false
//                } else {
//                    showError = true
//                }
//            }) {
//                Text("Login")
//                    .font(.title2)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//            
//            if showError {
//                Text("Invalid username or password")
//                    .foregroundColor(.red)
//            }
//            
//            if isLoggedIn, let currentUser = currentUser {
//                NavigationLink(destination: MeditationSelectionView(currentUser: currentUser, users: users)) {
//                    Text("Go to Meditation Menu")
//                        .font(.title2)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//        }
//        .padding()
//    }
//}
