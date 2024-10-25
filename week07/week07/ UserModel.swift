//
//   UserModel.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id = UUID()
    var username: String
    var password: String
    var favoriteMeditation: String?
}
