//
//  ExperienceView.swift
//  week04
//
//  Created by Keya Shah on 03/10/2024.
//

import Foundation
import SwiftUI
import AVFoundation

struct ExperienceView: View {
    var selectedDuration: Int
    @State private var currentPage: Int = 0
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = true //  track playback status

    let backgroundImages = ["1", "7", "4", "3"]
    let sounds = ["3min", "5min", "10min"]

    var body: some View {
        ZStack {
            if currentPage < backgroundImages.count {
                Image(backgroundImages[currentPage])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .offset(x: -30)
            }
            
            VStack {
                Spacer()
                
                Button(action: nextPage) {
                    Text("Change Background")
                        .font(.title)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: togglePlayback) {
                    Text(isPlaying ? "Pause" : "Play")
                        .font(.title)
                        .padding()
                        .background(isPlaying ? Color.black : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            playSoundForSelectedDuration()
        }
        .onDisappear {
            stopBackgroundMusic()
        }
    }
    
    func nextPage() {
    
        if currentPage < backgroundImages.count - 1 {
            currentPage += 1
        } else {
            currentPage = 0
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func playSoundForSelectedDuration() {
        let soundName: String
        
        switch selectedDuration {
        case 3:
            soundName = "3min"
        case 5:
            soundName = "5min"
        case 10:
            soundName = "10min"
        default:
            return 
        }
        
        playSound(named: soundName)
    }
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
}


//references:
//audios from : https://www.freemindfulness.org/download, https://pixabay.com/music/search/alpha%20waves%20meditation/
//images from: https://www.pinterest.com/search/pins/?q=mindfulness%20backgrounds&rs=rs&eq=&etslf=1223
//tutorials: https://www.youtube.com/watch?v=707R32sK6v0,
