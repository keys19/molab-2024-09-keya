//
//   Model.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

import Foundation
import SwiftUI

struct Model: Codable {
    var users: [UserModel]
    
    // Default initializer
    init() {
        self.users = []
    }

    // Initializer to load users from JSON file in the app bundle
    init(JSONfileName fileName: String) {
        self.users = []
        if let path = Bundle.main.path(forResource: fileName, ofType: nil) {
            print("Found JSON file at path: \(path)")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedModel = try JSONDecoder().decode(Model.self, from: data)
                self.users = decodedModel.users
                print("Users loaded successfully: \(self.users)")
            } catch {
                print("Error loading JSON: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }

    // Add a user to the model
    mutating func addUser(user: UserModel) {
        users.append(user)
    }
    
    // Update user information
    mutating func updateUser(user: UserModel) {
        if let index = findIndex(user.id) {
            users[index] = user
        }
    }
    
    // Delete a user by their ID
    mutating func deleteUser(id: UUID) {
        if let index = findIndex(id) {
            users.remove(at: index)
        }
    }

    // Find a user by their UUID
    func findIndex(_ id: UUID) -> Int? {
        return users.firstIndex { user in user.id == id }
    }

    // Save the users to a JSON file in the documents directory
    func saveAsJSON(fileName: String) {
        do {
            try saveJSON(fileName: fileName, val: self)
        } catch {
            fatalError("Model saveAsJSON error \(error)")
        }
    }
}

// Helper functions to handle JSON saving and loading

func saveJSON<T: Encodable>(fileName: String, val: T) throws {
    let filePath = try documentPath(fileName: fileName)
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let jsonData = try encoder.encode(val)
    try jsonData.write(to: filePath)
}

func loadJSON<T: Decodable>(_ type: T.Type, fileName: String) throws -> T {
    let filePath = try documentPath(fileName: fileName)
    let jsonData = try Data(contentsOf: filePath)
    return try JSONDecoder().decode(type, from: jsonData)
}

// Get the path for saving and loading files from the documents directory
func documentPath(fileName: String) throws -> URL {
    let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    return directory.appendingPathComponent(fileName)
}
