//
//  ActorCardView.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 11.11.2022.
//

import SwiftUI

struct ActorCardView: View, CardView {
    @Environment(\.colorScheme) private var colorScheme
    var actor: Actor
    
    var body: some View {
        VStack {
            VStack {
                AnimatedAsyncImageView(path: actor.profileImagePath)
                HStack {
                    VStack(alignment: .leading) {
                        Text(actor.actorName)
                            .font(.system(size: 4.0.responsizeW, weight: .semibold))
                        if let roleName = actor.actorRoles?.roleName {
                            Text("(\(roleName))")
                                .font(.caption2)
                        }
                    }
                    Spacer()
                }.frame(height: 10.0.responsizeW)
                    .padding(.horizontal, 7)
            }.padding(.bottom, 7)
        }.frame(width: 40.0.responsizeW, height: 65.0.responsizeW)
            .background(cardBackground(overlayLinearGradient: overlayLinearGradient, colorScheme: colorScheme))
    }
}

// MARK: Color properties
extension ActorCardView {
    private var overlayLinearGradient: LinearGradient {
        LinearGradient(
            colors: [.clear, backgroundColor.opacity(0.2), backgroundColor.opacity(0.5), backgroundColor.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    private var backgroundColor: Color { colorScheme == .dark ? .gray.opacity(0.2) : .white }
}
