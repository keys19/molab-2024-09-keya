//
//   Document.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

import Foundation
import SwiftUI

class Document: ObservableObject {
    @Published var model: Model
    
    init() {
        model = Model(JSONfileName: "UserData.json")
    }
}
