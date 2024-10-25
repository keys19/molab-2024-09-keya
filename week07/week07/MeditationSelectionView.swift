//
//  MeditationSelectionView.swift
//  week06
//
//  Created by Keya Shah on 17/10/2024.
//



import Foundation
import SwiftUI

struct MeditationSelectionView: View {
    @EnvironmentObject var document: Document
    @State var currentUser: UserModel
    @State private var selectedMeditation: String = ""
    @State private var showFaceCheck = false  // State to toggle face check view
    @State private var analysis: String = ""  // Face analysis result

    // Initializer
    init(currentUser: UserModel) {
        self._currentUser = State(initialValue: currentUser)
    }

    var body: some View {
        VStack {
            List {
                // Favorites section
                if let favorites = currentUser.favoriteMeditation {
                    Section(header: Text("Favorites")) {
                        NavigationLink(destination: MeditationPlayerView(
                            meditationType: favorites,
                            audioFileName: getAudioFileName(for: favorites),
                            backgroundImage: getBackgroundImage(for: favorites),
                            currentUser: $currentUser)) {
                            Text(favorites)
                        }
                    }
                }

                // All meditations section
                Section(header: Text("All Meditations")) {
                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Gratitude",
                        audioFileName: "autumnsky",
                        backgroundImage: "gt",
                        currentUser: $currentUser)) {
                        Text("Gratitude")
                    }

                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Tibetan Bowl",
                        audioFileName: "tibetian",
                        backgroundImage: "tbowl",
                        currentUser: $currentUser)) {
                        Text("Tibetan Bowl")
                    }

                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Sleep",
                        audioFileName: "sleep",
                        backgroundImage: "sleep_image",
                        currentUser: $currentUser)) {
                        Text("Sleep")
                    }

                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Bodhi Melodies",
                        audioFileName: "bm",
                        backgroundImage: "bmtree",
                        currentUser: $currentUser)) {
                        Text("Bodhi Melodies")
                    }

                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Angelic",
                        audioFileName: "angelic",
                        backgroundImage: "angel",
                        currentUser: $currentUser)) {
                        Text("Angelic")
                    }

                    NavigationLink(destination: MeditationPlayerView(
                        meditationType: "Zen",
                        audioFileName: "zen",
                        backgroundImage: "zeny",
                        currentUser: $currentUser)) {
                        Text("Zen")
                    }
                }
            }
            .navigationTitle("Meditation Types")

            // Face Check Button
            Button(action: {
                showFaceCheck.toggle()  // Show face check when button is pressed
            }) {
                Text("Are you ready to meditate?")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showFaceCheck) {
                FaceCheckView(analysis: $analysis)
            }

            // Display the face analysis result, if available
            if !analysis.isEmpty {
                Text(analysis)
                    .font(.title3)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
        }
    }

    // Helper function to get the audio file name for a given meditation
    func getAudioFileName(for meditation: String) -> String {
        switch meditation {
        case "Gratitude":
            return "autumnsky"
        case "Tibetan Bowl":
            return "tibetian"
        case "Sleep":
            return "sleep"
        case "Bodhi Melodies":
            return "bm"
        case "Angelic":
            return "angelic"
        case "Zen":
            return "zen"
        default:
            return "1"
        }
    }

    // Helper function to get the background image for a given meditation
    func getBackgroundImage(for meditation: String) -> String {
        switch meditation {
        case "Gratitude":
            return "gt"
        case "Tibetan Bowl":
            return "tbowl"
        case "Sleep":
            return "sleep_image"
        case "Bodhi Melodies":
            return "bmtree"
        case "Angelic":
            return "angel"
        case "Zen":
            return "zeny"
        default:
            return "4"
        }
    }
}
