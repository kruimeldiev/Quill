//
//  NewBookView.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI

struct NewBookView: View {
    
    @Environment(\.dismiss) private var dismissSheet
    
    @StateObject private var viewModel = NewBookViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismissSheet()
                } label: {
                    Text("Cancel")
                }
            }
            Divider()
            HStack {
                Text("Date here")
                Spacer()
                Text("Extra text")
            }
            TextField("Book title", text: $viewModel.newBookTitle)
            TextField("Book edition", text: $viewModel.newBookEdition)
            // TODO: Add fields for authors
        }
        .padding()
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
