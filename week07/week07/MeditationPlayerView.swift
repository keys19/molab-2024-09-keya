//
//  MeditationPlayerView.swift
//  week06
//
//  Created by Keya Shah on 17/10/2024.
//

//import Foundation
//import SwiftUI
//
//import AVFoundation
//
//struct MeditationPlayerView: View {
//    let meditationType: String
//    let audioFileName: String
//    let backgroundImage: String
//    
//    
//    @EnvironmentObject var document: Document  // Use the environment object
//        @Binding var currentUser: UserModel
//    @State private var isPlaying = false
//    @State private var isFavorited: Bool = false
//    @State private var player: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            Image(backgroundImage)
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                Text(meditationType)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()
//
//                // heart button to favorite/unfavorite
//                Button(action: {
//                    toggleFavorite()
//                }) {
//                    Image(systemName: isFavorited ? "heart.fill" : "heart")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.red)
//                }
//                .padding()
//
//                // play/Pause button
//                Button(action: {
//                    if isPlaying {
//                        player?.pause()
//                    } else {
//                        playAudio()
//                    }
//                    isPlaying.toggle()
//                }) {
//                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .foregroundColor(.white)
//                }
//                .padding()
//            }
//        }
//        .onAppear {
//            // Load if this meditation is favorited
//            isFavorited = (currentUser.favoriteMeditation == meditationType)
//        }
//    }
//
//    // Function to toggle the favorite state
//    func toggleFavorite() {
//        isFavorited.toggle()
//        
//        // Update the user's favorite meditation
//        if isFavorited {
//            currentUser.favoriteMeditation = meditationType
//        } else {
//            currentUser.favoriteMeditation = nil
//        }
//        
//        // Save the updated user data
//        saveUserData()
//    }
//
//    // Function to save user data
//    func saveUserData() {
//        document.model.updateUser(user: currentUser)
//        document.model.saveAsJSON(fileName: "UserData.json")
//    }
//
//    // Function to play the audio
//    func playAudio() {
//        guard let path = Bundle.main.path(forResource: audioFileName, ofType: "mp3") else {
//            print("Audio file not found")
//            return
//        }
//
//        do {
//            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//            player?.play()
//        } catch {
//            print("Error playing audio: \(error.localizedDescription)")
//        }
//    }
//}

import Foundation
import SwiftUI
import AVFoundation
//
//struct MeditationPlayerView: View {
//    let meditationType: String
//    let audioFileName: String
//    let backgroundImage: String
//    
//    @EnvironmentObject var document: Document
//    @Binding var currentUser: UserModel
//    
//    @State private var isPlaying = false
//    @State private var isFavorited: Bool = false
//    @State private var player: AVAudioPlayer?
//    
//    var body: some View {
//        ZStack {
//            Image(backgroundImage)
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                Text(meditationType)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()
//
//                // heart button to favorite/unfavorite
//                Button(action: {
//                    toggleFavorite()
//                }) {
//                    Image(systemName: isFavorited ? "heart.fill" : "heart")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.red)
//                }
//                .padding()
//
//                // play/Pause button
//                Button(action: {
//                    if isPlaying {
//                        player?.pause()
//                    } else {
//                        playAudio()
//                    }
//                    isPlaying.toggle()
//                }) {
//                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .foregroundColor(.white)
//                }
//                .padding()
//            }
//        }
//        .onAppear {
//            // Load if this meditation is favorited
//            isFavorited = (currentUser.favoriteMeditation == meditationType)
//        }
//    }
//
//    // Function to toggle the favorite state
//    func toggleFavorite() {
//        isFavorited.toggle()
//        
//        // Update the user's favorite meditation
//        if isFavorited {
//            currentUser.favoriteMeditation = meditationType
//        } else {
//            currentUser.favoriteMeditation = nil
//        }
//        
//        // Save the updated user data
//        saveUserData()
//    }
//
//    // Function to save user data
//    func saveUserData() {
//        document.model.updateUser(user: currentUser)
//        document.model.saveAsJSON(fileName: "UserData.json")
//    }
//
//    // Function to play the audio
//    func playAudio() {
//        guard let path = Bundle.main.path(forResource: audioFileName, ofType: "mp3") else {
//            print("Audio file not found")
//            return
//        }
//
//        do {
//            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//            player?.play()
//        } catch {
//            print("Error playing audio: \(error.localizedDescription)")
//        }
//    }
//}


struct MeditationPlayerView: View {
    let meditationType: String
    let audioFileName: String
    let backgroundImage: String
    
    @EnvironmentObject var document: Document  // Use the environment object
    @Binding var currentUser: UserModel
    
    @State private var isPlaying = false
    @State private var isFavorited: Bool = false
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(meditationType)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // heart button to favorite/unfavorite
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
                .padding()

                // play/Pause button
                Button(action: {
                    if isPlaying {
                        player?.pause()
                    } else {
                        playAudio()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .onAppear {
            // load if this meditation is favorited
            isFavorited = (currentUser.favoriteMeditation == meditationType)
        }
    }

    // Function to toggle the favorite state
    func toggleFavorite() {
        isFavorited.toggle()
        
        // Update the user's favorite meditation
        if isFavorited {
            currentUser.favoriteMeditation = meditationType
        } else {
            currentUser.favoriteMeditation = nil
        }
        
        // Save the updated user data
        saveUserData()
    }

    // Function to save user data
    func saveUserData() {
        document.model.updateUser(user: currentUser)
        document.model.saveAsJSON(fileName: "UserData.json")
    }

    // Function to play the audio
    func playAudio() {
        guard let path = Bundle.main.path(forResource: audioFileName, ofType: "mp3") else {
            print("Audio file not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}
