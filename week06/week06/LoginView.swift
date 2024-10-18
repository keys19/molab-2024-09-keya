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

func getFileURL() -> URL? {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        return dir.appendingPathComponent("user.json")
    }
    return nil
}


func loadUsers() -> [AppUser] {
    guard let fileURL = getFileURL() else {
        print("Error getting file URL")
        return []
    }
    
    // checking if the file exists
    if FileManager.default.fileExists(atPath: fileURL.path) {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([AppUser].self, from: data)
        } catch {
            print("Error decoding users from file: \(error.localizedDescription)")
            return []
        }
    } else {
        //if file doesnt exist
        return []
    }
}

func writeUsers(_ users: [AppUser]) {
    guard let fileURL = getFileURL() else {
        print("Error getting file URL")
        return
    }

    do {
        let data = try JSONEncoder().encode(users)
        try data.write(to: fileURL)
        print("Users saved successfully.")
    } catch {
        print("Error writing users to file: \(error.localizedDescription)")
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showError: Bool = false
    @State private var users: [AppUser] = loadUsers()
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
                if let user = users.first(where: { $0.username == username && $0.password == password }) {
                    currentUser = user
                    isLoggedIn = true
                    showError = false
                } else {
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
