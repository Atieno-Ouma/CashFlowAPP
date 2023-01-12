//
//  BottomErrorBannerr.swift
//  MoneyFlow
//
//  Created by Marco Gomiero on 28.12.21.
//

import SwiftUI

struct Snackbar: View {

    @Binding var snackbarData: SnackbarData

    @State private var showBanner: Bool = false

    var body: some View {

        VStack(alignment: .leading, spacing: AppMargins.xSmall) {

            Text(snackbarData.title)
                .font(AppFonts.subtitle1)
                .foregroundColor(Color.popupText)

            if let subtitle = snackbarData.subtitle {
                Text(subtitle)
                    .font(AppFonts.caption)
                    .foregroundColor(Color.popupText)
            }
        }
        .padding(.vertical, AppMargins.regular)
        .padding(.horizontal, AppMargins.medium)
        .background(Color.popupBackground)
        .shadow(radius: 10)
        .cornerRadius(8)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { _ in
                    withAnimation {
                        showBanner = false
                    }
                }
        )
        .onChange(of: self.snackbarData) { value  in
            if !value.isEmpty() {
                withAnimation {
                    self.snackbarData = value
                    self.showBanner = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation {
                        showBanner = false
                    }
                }
            }
        }
        .padding(.bottom, AppMargins.regular)
        .zIndex(100)
        .offset(y: showBanner ? 0 : UIScreen.main.bounds.height)

    }
}
