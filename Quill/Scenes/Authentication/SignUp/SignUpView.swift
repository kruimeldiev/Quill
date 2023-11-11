//
//  SignUpView.swift
//  Quill
//
//  Created by Casper Daris on 08/09/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            Color.background
            VStack(spacing: UIScreen.main.bounds.height > 700 ? 20 : 10) {
                Text(LocalizedStringKey("sign_up"))
                    .modifier(TextAppTitle())
                VStack(alignment: .trailing) {
                    AuthenticationTextField(style: .email,
                                            userInput: $viewModel.userInput.email,
                                            displayingError: $viewModel.showEmailInputError)
                        .onChange(of: viewModel.userInput.email) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                    AuthenticationTextField(style: .username,
                                            userInput: $viewModel.userInput.username,
                                            displayingError: $viewModel.showUsernameInputError)
                        .onChange(of: viewModel.userInput.username) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                    AuthenticationTextField(style: .password,
                                            userInput: $viewModel.userInput.password,
                                            displayingError: $viewModel.showPasswordInputError)
                        .onChange(of: viewModel.userInput.password) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                    AuthenticationTextField(style: .confirmPassword,
                                            userInput: $viewModel.userInput.passwordVerify,
                                            displayingError: $viewModel.showPasswordVerifyInputError)
                        .onChange(of: viewModel.userInput.passwordVerify) { _ in
                            viewModel.updateButtonAndErrorState()
                        }
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .modifier(TextNoteBody(color: .textError))
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task {
                        await viewModel.handleSignUp()
                    }
                } label: {
                    Text(LocalizedStringKey("sign_up"))
                        .frame(maxWidth: .infinity)
                        .modifier(AppPrimaryButton(buttonIsEnabled: $viewModel.signUpButtonIsEnabled))
                }
                .disabled(!viewModel.signUpButtonIsEnabled)
                
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
                
                Button {
                    // TODO: Login with Apple
                    
                } label: {
                    HStack {
                        Image(systemName: "apple.logo")
                        Text(LocalizedStringKey("sign_up_with_apple"))
                    }
                    .frame(maxWidth: .infinity)
                    .modifier(AppPrimaryButton(backgroundColor: .background,
                                               foregroundColor: .textTitle,
                                               withBorder: true))
                }
                
                HStack(alignment: .bottom) {
                    Text(LocalizedStringKey("sign_up_already_account"))
                        .modifier(TextCaption())
                    Button {
                        viewModel.routeToSignIn()
                    } label: {
                        Text(LocalizedStringKey("sign_in"))
                            .modifier(TextAccentButton())
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ScaleUpBackButton(withScaleEffect: false)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}
