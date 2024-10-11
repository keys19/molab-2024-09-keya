//
//  MeditationSelectionView.swift
//  week05
//
//  Created by Keya Shah on 10/10/2024.
//

import Foundation
import SwiftUI
struct MeditationSelectionView: View {
    var body: some View {
        List {
            // NavigationLink for Gratitude meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Gratitude",
                audioFileName: "autumnsky",
                backgroundImage: "gt")) {
                Text("Gratitude")
            }
            
            // NavigationLink for Tibetan Bowl meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Tibetan Bowl",
                audioFileName: "tibetian",
                backgroundImage: "tbowl")) {
                    Text("Tibetan Bowl")
            }
            
            // NavigationLink for Sleep meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Sleep",
                audioFileName: "sleep",
                backgroundImage: "sleep_image")) {
                Text("Sleep")
            }
            
            // NavigationLink for Chakras meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Bodhi Medlodies",
                audioFileName: "bm",
                backgroundImage: "bmtree")) {
                Text("Bodhi Medlodies")
            }
            
            // NavigationLink for Om meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Angelic",
                audioFileName: "angelic",
                backgroundImage: "angel")) {
                Text("Angelic")
            }
            
            // NavigationLink for Om meditation
            NavigationLink(destination: MeditationPlayerView(
                meditationType: "Zen",
                audioFileName: "zen",
                backgroundImage: "zeny")) {
                Text("Zen")
            }
        }
        .navigationTitle("Meditation Types")
    }
}
