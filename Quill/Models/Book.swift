//
//  Book.swift
//  Quill
//
//  Created by Casper Daris on 14/07/2023.
//

import Foundation
 
struct Book: Identifiable {
    let id: String
    let creationDate: Date
    var title: String
    var authors: [String]
    var edition: String?
    var tags: [String]
    var notes: [BookNote]
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}

struct BookNote: Identifiable {
    let id: String
    var title: String
    var note: String
    var creationDate: Date
    var isPrivate: Bool
    var tags: [String]
}

extension BookNote: Equatable {
    static func == (lhs: BookNote, rhs: BookNote) -> Bool {
        return lhs.id == rhs.id
    }
}
