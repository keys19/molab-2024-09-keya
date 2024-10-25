//
//  ContentView.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

//import SwiftUI
//
//
//struct ContentView: View {
//    @EnvironmentObject var document: Document
//    @State private var isAuthenticated = false
//    @State private var currentUser: UserModel?
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if isAuthenticated, let user = currentUser {
//                    NavigationLink(destination: MeditationSelectionView(currentUser: user), isActive: $isAuthenticated) {
//                        EmptyView()
//                    }
//                } else {
//                    LoginView(isAuthenticated: $isAuthenticated, currentUser: $currentUser)
//                }
//            }
//            .navigationTitle("Welcome")
//        }
//    }
//}
//
//struct LoginView: View {
//    
//    @EnvironmentObject var document: Document
//    @Binding var isAuthenticated: Bool
//    @Binding var currentUser: UserModel?
//
//    @State private var username: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//    
//        VStack {
//            TextField("Username", text: $username)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            SecureField("Password", text: $password)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            Button("Login") {
//                print("Loaded users: \(document.model.users)")
//                print("Attempting login with Username: \(username), Password: \(password)")
//                print("Loaded users: \(document.model.users)")
//                
//                if let user = document.model.users.first(where: { $0.username == username && $0.password == password }) {
//                    isAuthenticated = true
//                    currentUser = user
//                    print("Login successful for user: \(username)")
//                } else {
//                    print("Login failed. User not found or incorrect password.")
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Login")
//    }
//}


import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var document: Document
    @State private var isAuthenticated = false
    @State private var currentUser: UserModel?
    @State private var showLandingPage = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var opacity = 0.0
    @State private var analysis = ""  // Assuming analysis may be used elsewhere

    var body: some View {
        NavigationView {
            if showLandingPage {
                // Show Landing Page
                ZStack {
                    // Background image
                    Image("4")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .offset(x: -20)

                    VStack {
                        Text("Mindful Minutes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()

                        // Real-time face expression feedback (if applicable)
                        if !analysis.isEmpty {
                            Text(analysis)
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(8)
                        }

                        // Gradient animation for mindfulness
                        RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(opacity), Color.white.opacity(0)]), center: .center, startRadius: 20, endRadius: 200)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                                    opacity = 1.0
                                }
                            }

                        // Button to navigate to LoginView
                        Button(action: {
                            showLandingPage = false
                        }) {
                            Text("Begin Your Calmness Journey")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .onAppear {
                        playBackgroundMusic() // Start background music on view appearance
                    }
                    .onDisappear {
                        stopBackgroundMusic() // Stop background music when the view disappears
                    }
                }
            } else {
                // Show Login or Meditation Selection Page after Landing Page is dismissed
                VStack {
                    if isAuthenticated, let user = currentUser {
                        NavigationLink(destination: MeditationSelectionView(currentUser: user), isActive: $isAuthenticated) {
                            EmptyView()
                        }
                    } else {
                        LoginView(isAuthenticated: $isAuthenticated, currentUser: $currentUser)
                    }
                }
                .navigationTitle("Welcome")
            }
        }
    }

    // Function to play background music
    func playBackgroundMusic() {
        guard let path = Bundle.main.path(forResource: "1", ofType: "mp3") else {
            print("Background music file not found")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    // Function to stop background music
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}

struct LoginView: View {
    @EnvironmentObject var document: Document
    @Binding var isAuthenticated: Bool
    @Binding var currentUser: UserModel?

    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login") {
                print("Loaded users: \(document.model.users)")
                print("Attempting login with Username: \(username), Password: \(password)")
                print("Loaded users: \(document.model.users)")
                
                if let user = document.model.users.first(where: { $0.username == username && $0.password == password }) {
                    isAuthenticated = true
                    currentUser = user
                    print("Login successful for user: \(username)")
                } else {
                    print("Login failed. User not found or incorrect password.")
                }
            }
            .padding()
        }
        .navigationTitle("Login")
    }
}

#Preview {
    ContentView()
}
