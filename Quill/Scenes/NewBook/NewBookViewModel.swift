//
//  NewBookViewModel.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI

class NewBookViewModel: ObservableObject {
    
//    @Published var newBook = Book(id: UUID().uuidString,
//                                  creationDate: Date.now,
//                                  title: "",
//                                  authors: [],
//                                  edition: "",
//                                  notes: [])
    
    @Published var newBookTitle = ""
    @Published var newBookEdition = ""
    
}
