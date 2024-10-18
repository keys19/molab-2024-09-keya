//
//  MeditationPlayerView.swift
//  week06
//
//  Created by Keya Shah on 17/10/2024.
//

import Foundation
import SwiftUI


import SwiftUI
import AVFoundation

struct MeditationPlayerView: View {
    let meditationType: String
    let audioFileName: String
    let backgroundImage: String
    
    @Binding var currentUser: AppUser
    @Binding var users: [AppUser]
    
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
            isFavorited = currentUser.favorites.contains(meditationType)
        }
    }

 

    
    func toggleFavorite() {
        isFavorited.toggle()
        
        // Update the user's favorites
        if isFavorited {
            currentUser.favorites.append(meditationType)
        } else {
            currentUser.favorites.removeAll { $0 == meditationType }
        }

        if let index = users.firstIndex(where: { $0.username == currentUser.username }) {
            users[index] = currentUser
        }
        
        // write the updated users list to the file
        writeUsersToFile(users: users)
    }
    
    // function to play the audio
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


func loadUsersFromFile() -> [AppUser] {

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent("user.json")
        
       
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                return try decoder.decode([AppUser].self, from: data)
            } catch {
                print("Error loading users from file: \(error.localizedDescription)")
            }
        }
    }
    
    // If the file doesn't exist, load the default data from the app bundle
    if let path = Bundle.main.path(forResource: "user", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            return try decoder.decode([AppUser].self, from: data)
        } catch {
            print("Error loading users from bundle: \(error.localizedDescription)")
        }
    }
    
    return []
}

func writeUsersToFile(users: [AppUser]) {
   
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent("user.json")
        
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: fileURL)
            print("Users saved to file at \(fileURL)")
        } catch {
            print("Error saving users: \(error.localizedDescription)")
        }
    }
}
