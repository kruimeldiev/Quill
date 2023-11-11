//
//  OnboardingView.swift
//  Quill
//
//  Created by Casper Daris on 11/08/2023.
//

import SwiftUI
import Factory

struct OnboardingView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var carrouselOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                VStack(spacing: 30) {
                    ImageCarrousel()
                    VStack {
                        Text(LocalizedStringKey("onboarding_welcome"))
                            .modifier(TextAppTitle(size: 26))
                        Text(LocalizedStringKey("onboarding_description"))
                            .multilineTextAlignment(.center)
                            .modifier(TextCaption(color: .textBody))
                            .padding(.horizontal, 20)
                            .padding(.top, 1)
                    }
                    VStack(spacing: 12) {
                        Button {
                            Task { await viewModel.handleAnonymousSignIn() }
                        } label: {
                            Text(LocalizedStringKey("continue"))
                                .frame(maxWidth: .infinity)
                                .modifier(AppPrimaryButton())
                        }
                        Button {
                            viewModel.routeToSignIn()
                        } label: {
                            Text(LocalizedStringKey("sign_in"))
                                .frame(maxWidth: .infinity)
                                .modifier(AppPrimaryButton(backgroundColor: .background,
                                                           foregroundColor: .textTitle,
                                                           withBorder: true))
                        }
                    }
                    .padding(.vertical, 10)
                }
                .padding()
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder private func ImageCarrousel() -> some View {
        ZStack {
            HStack(spacing: 30) {
                Image("img_onboarding_2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(20)
                Image("img_onboarding_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .cornerRadius(20)
            }
            .offset(x: carrouselOffset / 4)
            Image("img_onboarding_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.background, lineWidth: 10)
                }
                .offset(x: carrouselOffset / 2)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let x = value.translation.width
                    if (x <= 100 && x >= -100) {
                        withAnimation(.easeOut) {
                            self.carrouselOffset = x
                        }
                    }
                }
                .onEnded { value in
                    withAnimation(.easeOut) {
                        self.carrouselOffset = 0
                    }
                }
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.setupMocks()
        return OnboardingView()
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14")
//            .previewDevice("iPhone SE (3rd generation)")
//            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
