//
//  DreamEntry.swift
//  DreamJournal
//
//  Created by Jaivleen Kour on 2023-11-18.
//

import Foundation

struct DreamEntry: Codable {
    var documentID: String?
    var dream_id: Int
    var category: String
    var date: String
    var dream_description: String
    var feeling: String
    var imageURL: String
    var recurringDream: String
    var title: String
    var user_id: Int
}
