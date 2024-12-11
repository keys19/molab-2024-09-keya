//
//  LandingPageView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//



import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

struct LandingPageView: View {
    @State private var isSignedIn = false // Tracks the user's authentication state

    var body: some View {
        NavigationView {
            if isSignedIn {
                ZStack {
                    // Background Image
                    Image("cover1")
                        .resizable()
                        .scaledToFill()
                        .offset(x: -20)
                        .ignoresSafeArea()

                   
                    VStack {
                        Spacer()

                        NavigationLink(destination: JournalView()) {
                            Text("Go to Journal")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color.white.opacity(0.8))
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }

                        Spacer()
                            .frame(height: 100)
                    }
                    .padding(.bottom, 100)
                }
                .navigationBarHidden(true)
            } else {
                AuthView(isSignedIn: $isSignedIn)
            }
        }
    }
}

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @Binding var isSignedIn: Bool
    @State private var showAnim = false

    var body: some View {
        ZStack {
            // Background Image
            Image("cover1")
                .resizable()
                .scaledToFill()
                .offset(x: -20)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Animated Image
                if showAnim {
                    Image("mf")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 450)
                        .offset(y: 20) // Position above the moon
                        .offset(x: 5)
                        .transition(.opacity.combined(with: .scale))
                        .animation(.easeInOut(duration: 4.5), value: showAnim)
                        .padding(.bottom, 10)
                }

                // Email and Password Fields with Buttons
                if showAnim {
                    VStack(spacing: 16) {
                        // Email TextField
                        TextField("Email", text: $email)
                            .padding(10)
                            .background(Color.black.opacity(0.4)) // Darker background
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .frame(width: 250)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)

                        // Password SecureField
                        SecureField("Password", text: $password)
                            .padding(10)
                            .background(Color.black.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .frame(width: 250)

                        // Sign-In Button
                        Button(action: {
                            signIn(email: email, password: password)
                        }) {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .frame(width: 250, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        // Sign-Up Button
                        Button(action: {
                            signUp(email: email, password: password)
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .frame(width: 250, height: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .animation(.easeInOut(duration: 6.5).delay(9.5), value: showAnim)
                }

                Spacer()

                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation {
                showAnim = true // Trigger animation on appear
            }
        }
    }

    // Firebase Auth Functions

    /// Sign-In Function
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isSignedIn = true
            }
        }
    }

    /// Sign-Up Function
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isSignedIn = true
            }
        }
    }
}

// Preview
struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
