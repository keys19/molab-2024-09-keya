//
//  tibetian.swift
//  week05
//
//  Created by Keya Shah on 10/10/2024.
//

import Foundation
import SwiftUI
import AVFoundation
struct MeditationPlayerView: View {
    let meditationType: String          // The type of meditation (e.g., Gratitude, Tibetan Bowl)
    let audioFileName: String           // The name of the audio file to play
    let backgroundImage: String         // The name of the background image
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            // Background image for the meditation
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(meditationType)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Play/Pause button
                Button(action: {
                    if isPlaying {
                        player?.pause()
                    } else {
                        playAudio()  // Play the audio
                    }
                    isPlaying.toggle()  // Toggle the play/pause state
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
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
