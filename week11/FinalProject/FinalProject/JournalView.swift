//
//  JournalView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//
import SwiftUI
import Foundation
//struct JournalView: View {
//    var body: some View {
//        Text("This is the Journal Page")
//            .font(.title2)
//            .padding()
//    }
//}


struct JournalView: View {
    @State private var selectedPrompt: String = "Choose a prompt"
    @State private var reflectionText: String = ""
    @State private var navigateToJView3 = false // Track navigation
    let prompts = [
        "What are you grateful for today?",
        "What made you smile today?",
        "What challenges did you overcome?",
        "What did you learn today?",
        "How can you make tomorrow even better?"
    ]
    
    var body: some View {
        ZStack {
            // Background Image
            Image("jview1") // Replace with your image asset name
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                // Title at the Top
                VStack(alignment: .center, spacing: 4) {
                    Text("today.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("a successful day")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.top, 50) // Add some space from the top

                Spacer()

                // Dropdown Menu (Prompt)
                VStack(alignment: .leading, spacing: 8) {
                    Picker("Choose a prompt", selection: $selectedPrompt) {
                        ForEach(prompts, id: \.self) { prompt in
                            Text(prompt).tag(prompt)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                // Text Editor for Reflection
                VStack(alignment: .leading, spacing: 8) {
                    TextEditor(text: $reflectionText)
                        .frame(height: 150)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden) // Fix background issue
                        .background(Color.black.opacity(0.2))
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)

                Button(action: {
                    print("Prompt: \(selectedPrompt)")
                    print("Reflection: \(reflectionText)")
                    navigateToJView3 = true // Trigger navigation
                }) {
                    NavigationLink(destination: JournalView3(), isActive: $navigateToJView3) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle()) // Ensure it looks like a single button
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal)
        }
    }
}
