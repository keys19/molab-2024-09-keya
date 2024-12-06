//
//  ChestView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.
//

import Foundation
import SwiftUI

struct ChestView: View {
    @State private var thoughts: String = "" // Holds the user's input
    @State private var isSkipped: Bool = false // Tracks if the user skipped the step

    var body: some View {
        ZStack {
            // Background color (adjust if needed)
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.yellow.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Title
                Text("Get It Out")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .padding(.top, 30)

                // Description
                Text("""
                Write a list of what’s on your mind in this chest. Pretend that once you write it down it’s locked. No more thinking about it... for tonight at least.
                """)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 10)

                Spacer()

                // Chest with Text Input
                ZStack {
                    // Chest Image
                    Image("chest1") // Replace with your "chest.png"
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)

                    // Text Input Box
                    VStack {
                        TextEditor(text: $thoughts)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .opacity(0.9)
                            .frame(height: 120)
                            .padding(.horizontal, 30)
                    }
                }

                Spacer()

                // Action Buttons
                HStack(spacing: 20) {
                    // Skip Button
                    Button(action: {
                        isSkipped = true
                        print("User skipped writing in the chest.")
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                    }

                    // Submit Button
                    Button(action: {
                        print("User submitted: \(thoughts)")
                        thoughts = "" // Clear the input after submission
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

// Preview
struct ChestView_Previews: PreviewProvider {
    static var previews: some View {
        ChestView()
    }
}
