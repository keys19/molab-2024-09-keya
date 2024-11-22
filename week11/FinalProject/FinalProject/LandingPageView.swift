//
//  LandingPageView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//

import Foundation
import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Mindfulness App")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: JournalView()) {
                    Text("Journal")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: ReminderView()) {
                    Text("Reminder")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Mindfulness App")
        }
    }
}
