//
//  Entry.swift
//  quarterhour
//
//  Created by Arnav Chauhan on 7/1/25.
//

import Foundation

struct Entry:Identifiable, Codable {
    var id=UUID()
    var timestamp:Date
    var text:String
}
