//
//  MeditationSelectionView.swift
//  week06
//
//  Created by Keya Shah on 17/10/2024.
//

import Foundation
import SwiftUI


struct MeditationSelectionView: View {
    @State var currentUser: AppUser
    @State var users: [AppUser]

    var body: some View {
        List {
            //favorites section
            if !currentUser.favorites.isEmpty {
                Section(header: Text("Favorites")) {
                    ForEach(currentUser.favorites, id: \.self) { meditation in
                        NavigationLink(destination: MeditationPlayerView(
                            meditationType: meditation,
                            audioFileName: getAudioFileName(for: meditation),
                            backgroundImage: getBackgroundImage(for: meditation),
                            currentUser: $currentUser,
                            users: $users)) {
                            Text(meditation)
                        }
                    }
                }
            }

            // All meditations section
            Section(header: Text("All Meditations")) {
                //Gratitude meditation
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Gratitude",
                    audioFileName: "autumnsky",
                    backgroundImage: "gt",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Gratitude")
                }
                
                // Tibetan Bowl meditation
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Tibetan Bowl",
                    audioFileName: "tibetian",
                    backgroundImage: "tbowl",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Tibetan Bowl")
                }
                
                // Sleep meditation
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Sleep",
                    audioFileName: "sleep",
                    backgroundImage: "sleep_image",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Sleep")
                }
                
                // (Bodhi Melodies)
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Bodhi Melodies",
                    audioFileName: "bm",
                    backgroundImage: "bmtree",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Bodhi Melodies")
                }
                
                // Angelic meditation
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Angelic",
                    audioFileName: "angelic",
                    backgroundImage: "angel",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Angelic")
                }
                
                // Zen meditation
                NavigationLink(destination: MeditationPlayerView(
                    meditationType: "Zen",
                    audioFileName: "zen",
                    backgroundImage: "zeny",
                    currentUser: $currentUser,
                    users: $users)) {
                    Text("Zen")
                }
            }
        }
        .navigationTitle("Meditation Types")
    }
    
    // Function to get the audio file name based on meditation type (for favorites)
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
    
    // to get the background image based on meditation type (for favorites)
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


