//
//  Model.swift
//  GymApp
//
//  Created by Виталик Молоков on 04.04.2024.
//

import Foundation

struct Exercise: Decodable {
    let name: String
    let type: String
    let muscle: String
    let difficulty: String
}

