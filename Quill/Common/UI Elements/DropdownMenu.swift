//
//  DropdownMenu.swift
//  Quill
//
//  Created by Casper Daris on 01/09/2023.
//

import SwiftUI

struct DropdownMenu: View {
    
    // TODO: selectedOption ergens anders opslaan
    @State private var selectedOption: MenuItem?
    
    let options: [MenuItem]
    var optionIsSelected: (MenuItem) -> ()
    
    var body: some View {
        VStack {
            ForEach(options, id: \.id) { option in
                if option == .separator {
                    Divider()
                        .frame(width: 140)
                } else {
                    Button {
                        select(option)
                    } label: {
                        if option == selectedOption {
                            Text(LocalizedStringKey(option.title))
                                .frame(width: 140, alignment: .leading)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .modifier(TextAccentButton())
                                .background(Color.secondaryAccentBrown)
                                .cornerRadius(12)
                        } else {
                            Text(LocalizedStringKey(option.title))
                                .frame(width: 140, alignment: .leading)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .modifier(TextNoteBody())
                                .background(.clear)
                                .cornerRadius(12)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 6)
    }
    
    private func select(_ item: MenuItem) {
        selectedOption = (selectedOption == item) ? nil : options.first { $0 == item }
        optionIsSelected(item)
    }
}

struct DropdownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenu(options: [.addNewBook,
                               .separator,
                               .sortNotes,
                               .filterNotes,
                               .separator,
                               .signIn,
                               .signOut]) { item in
                                   print(item)
                               }
    }
}
