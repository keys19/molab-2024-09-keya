//
//  JournalView3.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.


import Foundation
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
                    destination: MandalaView(mood: selectedMood ?? ""),
                    isActive: $navigateToMandala
                ) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
struct JournalView3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JournalView3()
        }
    }
}
