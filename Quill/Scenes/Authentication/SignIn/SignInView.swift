//
//  SignInView.swift
//  Quill
//
//  Created by Casper Daris on 26/08/2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        ZStack {
            Color.background
            /// The spacing is depending on the screen size, so that all elements fit on all devices
            VStack(spacing: UIScreen.main.bounds.height > 700 ? 20 : 10) {
                VStack(spacing: 10) {
                    Text(LocalizedStringKey("sign_in"))
                        .modifier(TextAppTitle())
                    Text(LocalizedStringKey("sign_up_explanation"))
                        .modifier(TextCaption(color: .textBody))
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .trailing) {
                    AuthenticationTextField(style: .email,
                                            userInput: $viewModel.userInput.email,
                                            displayingError: $viewModel.showEmailInputError)
                        .onChange(of: viewModel.userInput.email) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                    AuthenticationTextField(style: .password,
                                            userInput: $viewModel.userInput.password,
                                            displayingError: $viewModel.showPasswordInputError)
                        .onChange(of: viewModel.userInput.password) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                    Button {
                        // TODO: Route to forgot
                    } label: {
                        Text(LocalizedStringKey("sign_in_forgot_password"))
                            .modifier(TextCaption())
                    }
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .modifier(TextNoteBody(color: .textError))
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task { await viewModel.handleUserSignIn() }
                } label: {
                    Text(LocalizedStringKey("continue"))
                        .frame(maxWidth: .infinity)
                        .modifier(AppPrimaryButton(buttonIsEnabled: $viewModel.continueButtonIsEnabled))
                }
                .disabled(!viewModel.continueButtonIsEnabled)
                    
                HStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(.textAccent.opacity(0.5))
                    Text(LocalizedStringKey("or"))
                        .modifier(TextCaption())
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(.textAccent.opacity(0.5))
                }
                
                VStack {
                    Button {
                        // TODO: Sign in with Apple
                        viewModel.errorMessage = ""
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                            Text(LocalizedStringKey("sign_in_with_apple"))
                        }
                        .frame(maxWidth: .infinity)
                        .modifier(AppPrimaryButton(backgroundColor: .background,
                                                   foregroundColor: .textTitle,
                                                   withBorder: true))
                    }
                    
                    if !viewModel.userIsAnonymouslySignedIn() {
                        Button {
                            // TODO: Login anonymous BUT NOT IF ALREADY LOGGED IN, ADD CHECK
                        } label: {
                            HStack {
                                Image("ic_incognito")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(LocalizedStringKey("sign_in_anonymous"))
                            }
                            .frame(maxWidth: .infinity)
                            .modifier(AppPrimaryButton(buttonIsEnabled: .constant(true),
                                                       backgroundColor: .background,
                                                       foregroundColor: .textTitle,
                                                       withBorder: true))
                        }
                    }
                }
                
                HStack(alignment: .bottom) {
                    Text(LocalizedStringKey("sign_in_no_account_yet"))
                        .modifier(TextCaption())
                    Button {
                        viewModel.routeToSignUp()
                    } label: {
                        Text(LocalizedStringKey("sign_up"))
                            .modifier(TextAccentButton())
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .toolbar {
            // TODO: Handle this via coordinator?
            if viewModel.userIsAnonymouslySignedIn() {
                ToolbarItem(placement: .navigationBarLeading) {
                    ScaleUpBackButton(withScaleEffect: false, iconName: "xmark")
                }
            } else {
                ToolbarItem(placement: .navigationBarLeading) {
                    ScaleUpBackButton()
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView()
        }
//        .previewDevice("iPhone SE (3rd generation)")
//        .previewDisplayName("iPhone SE (3rd generation)")
        .previewDevice("iPhone 14")
        .previewDisplayName("iPhone 14")
    }
}
