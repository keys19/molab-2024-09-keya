//
//  JournalView3.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//

//import Foundation
//import SwiftUI
//struct JournalView3: View {
//    @State private var selectedMood: String? = nil
//    @State private var navigateToMandala = false
//    
//    let moods = [
//        "Calm",
//        "Happy",
//        "Stressed",
//        "Energetic"
//    ]
//    
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea() // Background
//            
//            VStack {
//                // Title
//                Text("Pick Your Mood")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 50)
//                
//                Spacer()
//                
//                // Mood Options
//                ForEach(moods, id: \.self) { mood in
//                    Button(action: {
//                        selectedMood = mood
//                        navigateToMandala = true
//                    }) {
//                        Text(mood)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.white, lineWidth: 1)
//                            )
//                            .padding(.horizontal)
//                    }
//                }
//                
//                Spacer()
//                
//                // Navigation
//                NavigationLink(destination: InteractiveMandalaView(mood: selectedMood ?? ""), isActive: $navigateToMandala) {
//                    EmptyView()
//                }
//            }
//        }
//    }
//}


import SwiftUI

struct JournalView3: View {
    @State private var selectedMood: String? = nil
    @State private var navigateToMandala = false

    let moods = [
        "Calm",
        "Happy",
        "Stressed",
        "Energetic"
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Background

            VStack {
                // Title
                Text("Pick Your Mood")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)

                Spacer()

                // Mood Options
                ForEach(moods, id: \.self) { mood in
                    Button(action: {
                        selectedMood = mood
                        navigateToMandala = true
                    }) {
                        Text(mood)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .padding(.horizontal)
                    }
                }

                Spacer()

                // Navigation
                NavigationLink(
                    isActive: $navigateToMandala
                ) {
                    MandalaEditor(
                        svgName: "\(selectedMood ?? "default").svg",
                        palettes: getPalettes(for: selectedMood ?? "Calm")
                    )
                } label: {
                    EmptyView()
                }
            }
        }
    }

    // Function to get palettes based on mood
    func getPalettes(for mood: String) -> [UIColor] {
        switch mood {
        case "Calm":
            return [UIColor.blue, UIColor.green, UIColor.systemTeal]
        case "Happy":
            return [UIColor.yellow, UIColor.orange, UIColor.systemPink]
        case "Stressed":
            return [UIColor.purple, UIColor.systemMint, UIColor.white]
        case "Energetic":
            return [UIColor.red, UIColor.orange, UIColor.yellow]
        default:
            return [UIColor.gray]
        }
    }
}
