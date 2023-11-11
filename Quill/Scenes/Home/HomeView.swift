//
//  HomeView.swift
//  Quill
//
//  Created by Casper Daris on 13/07/2023.
//

import SwiftUI
import Factory

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()

    /// We keep track of this value to update the opacity of the safeArea.top overlay
    /// Once a certain point is reached (-100) we overlay the safeArea.top with Color.background to hide the Notes displaying beyond the SelectorView
    @State private var headerViewOffset: CGFloat = 0
    
    /// This state will indicate if the options menu is displayed
    @State private var menuIsDisplayed = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            /// Outer Geometry will handle the safeArea
            GeometryReader { outerGeometry in
                ScrollView {
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        /// innerGeometry will keep track of the amount (offset) that is scrolled in the ScrollView
                        GeometryReader { innerGeometry -> AnyView in
                            let offset = innerGeometry.frame(in: .global).minY
                            if -offset >= 0 {
                                Task { headerViewOffset = offset }
                            }
                            return AnyView(
                                HeaderView()
                            )
                        }
                        .frame(height: 100)
                        /// Section header will stick to the top of the View
                        Section(header: SelectorView()) {
                            NotesView()
                        }
                    }
                }
                .overlay(
                    /// Overlay for the safeArea.top, only visable when the HeaderView is scrolled far enough
                    Color.background
                        .frame(height: outerGeometry.safeAreaInsets.top)
                        .ignoresSafeArea(.all, edges: .top)
                        .opacity(headerViewOffset < -100 ? 1 : 0)
                    , alignment: .top
                )
            }
            .overlay {
                NewBookNoteButton()
            }
        }
        .overlay(alignment: .topTrailing) {
            if menuIsDisplayed {
                DropdownMenu(options: viewModel.getMenuOptions()) { option in
                    Task { await menuOptionSelected(option) }
                }
                .offset(x: -10, y: 80)
            }
        }
        .onAppear {
            viewModel.setGreetingsMessage()
        }
    }
    
    /// VStack with welcome message and user profile picture
    @ViewBuilder private func HeaderView() -> some View {
        VStack(alignment: .trailing) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 64))
                VStack(alignment: .leading, spacing: -4) {
                    Text(LocalizedStringKey(viewModel.greetingsMessage))
                        .modifier(TextAppTitle(style: .extraLight, size: 20, color: .gray))
                    Text(viewModel.username)
                        .modifier(TextAppTitle(size: 20))
                }
                Spacer()
                HamburgerMenuButton(size: 24, menuIsOpen: $menuIsDisplayed)
            }
            .padding(20)
            .background(Color.background)
        }
    }
    
    /// ScrollView to display all the Books available from the VM
    @ViewBuilder private func SelectorView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // TODO: Add section for all notes
                ForEach(viewModel.books) { book in
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(Color.textTitle, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 30)
                            .fill(book == viewModel.books[viewModel.selectedBookIndex] ? Color.primaryAccentBrown : Color.background)
                        )
                        .frame(width: 180, height: 44)
                        .overlay(Text(book.title)
                            .modifier(TextNoteBody(color: book == viewModel.books[viewModel.selectedBookIndex] ? Color.background : Color.textBody))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                        )
                        .onTapGesture {
                            guard let book = viewModel.books.firstIndex(of: book) else { return }
                            viewModel.selectedBookIndex = book
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(Color.background)
    }
    
    /// VStack to display all the Notes for a sertain Book
    @ViewBuilder private func NotesView() -> some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.books[viewModel.selectedBookIndex].notes) { note in
                VStack(alignment: .leading) {
                    Button {
                        print(note.creationDate)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(note.title)
                                .modifier(TextNoteTitle())
                            Text(note.note)
                                .modifier(TextNoteBody())
                        }
                        .background(Color.background)
                        .multilineTextAlignment(.leading)
                    }
                    .buttonStyle(ScaleDownButtonStyle())
                    if viewModel.books[viewModel.selectedBookIndex].notes.last != note {
                        Divider()
                            .padding(.vertical, 20)
                    } else {
                        Spacer().frame(height: 60)
                    }
                }
            }
        }
        .padding(20)
    }
    
    @ViewBuilder private func NewBookNoteButton() -> some View {
        /// Overlay for the New note button
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    viewModel.routeToNewBookNote()
                } label: {
                    Text("")
                        .modifier(IconButton(width: 60,
                                             height: 60,
                                             backgroundColor: .primaryAccentBrown,
                                             iconName: "plus"))
                        .shadow(color: Color.black.opacity(0.2),
                                radius: 20)
                }
            }
        }
        .padding(20)
    }
    
    private func menuOptionSelected(_ option: MenuItem) async {
        switch option {
            case .separator:
                break
            case .signOut:
                await viewModel.signOutUser()
            case .signIn:
                viewModel.routeToSignIn()
            case .filterNotes:
                print("Todo")
            case .sortNotes:
                print("Todo")
            case .addNewBook:
                viewModel.routeToNewBook()
            case .filterBooks:
                print("Todo")
            case .sortBooks:
                print("Todo")
        }
        withAnimation {
            menuIsDisplayed.toggle()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.setupMocks()
        return HomeView()
//            .previewDevice("iPhone 14")
//            .previewDisplayName("iPhone 14")
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
