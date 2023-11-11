//
//  NewBookNoteView.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI

struct NewBookNoteView: View {
    
    @StateObject private var viewModel = NewBookNoteViewModel()
    
    var body: some View {
        Button {
            Task { await viewModel.handleLogout() }
        } label: {
            Text("Sign out")
        }
    }
}

struct NewBookNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookNoteView()
    }
}
