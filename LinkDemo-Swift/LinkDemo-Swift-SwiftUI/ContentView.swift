//
//  LinkKitSwiftUISupport.swift
//  LinkDemo-Swift
//
//  Copyright © 2020 Plaid Inc. All rights reserved.
//
import LinkKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background
            Color(
                red: 247 / 256,
                green: 249 / 256,
                blue: 251 / 256,
                opacity: 1
            )
            .ignoresSafeArea()
            // Information
            VStack(alignment: .leading, spacing: 12) {
                // Information
                Text("WELCOME")
                    .foregroundColor(OpenLinkButton.color)
                    .font(.system(size: 12, weight: .bold))
                Text("Plaid Link SDK\nSwiftUI Example")
                    .font(.system(size: 32, weight: .light))
                versionInformation()
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: 48,
                    leading: 32,
                    bottom: 0,
                    trailing: 0
                )
            )
            .fill(alignment: .topLeading)

            // Button Tray
            let shadowColor = #colorLiteral(red: 0.01176470588, green: 0.1921568627, blue: 0.337254902, alpha: 0.1)
            VStack {
                Spacer()
                VStack(alignment: .center) {
                    OpenLinkButton()
                        .frame(
                            width: 312,
                            height: 56
                        )
                        .offset(x: 0, y: -24)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 170,
                    alignment: .center
                )
                .background(Color.white)
                .shadow(
                    color: .init(shadowColor),
                    radius: 2,
                    x: 0,
                    y: -1
                )
            }
            .ignoresSafeArea()
        }

    }

    private func versionInformation() -> some View {
        let linkKitBundle  = Bundle(for: PLKPlaid.self)
        let linkKitVersion = linkKitBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let linkKitBuild   = linkKitBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String)!
        let linkKitName    = linkKitBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String)!
        let versionText = "Swift 5 — \(linkKitName) \(linkKitVersion)+\(linkKitBuild)"

        return Text(versionText)
            .foregroundColor(
                Color(
                    red: 139 / 256,
                    green: 167 / 256,
                    blue: 189 / 256,
                    opacity: 1
                )
            )
            .font(.system(size: 12))
    }
}

extension View {
    func fill(alignment: Alignment) -> some View {
        AnyView(
            self
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: alignment
                )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
