//
//  MenuItems.swift
//  Quill
//
//  Created by Casper Daris on 03/09/2023.
//

import Foundation

enum MenuItem: Identifiable {
    
    case separator
    case signOut
    case signIn
    case filterBooks
    case sortBooks
    case filterNotes
    case sortNotes
    case addNewBook
    
    var id: UUID {
        return UUID()
    }
    
    var title: String {
        switch self {
            case .separator:
                return ""
            case .signOut:
                return "sign_out"
            case .signIn:
                return "sign_in"
            case .filterNotes:
                return "menu_filter_notes"
            case .sortNotes:
                return "menu_sort_notes"
            case .addNewBook:
                return "menu_add_book"
            case.filterBooks:
                return "menu_filter_books"
            case .sortBooks:
                return "menu_sort_books"
        }
    }
}
