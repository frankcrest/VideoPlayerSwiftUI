//
//  PlayBackButton.swift
//  VideoPlayerSwiftUI
//
//  Created by Frank Chen on 2024-01-12.
//

import SwiftUI

struct PlayBackButton: View {
    var action: () -> Void
    var imageName: String
    var isDisabled: Bool
    var widthAndHeight: CGFloat
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(imageName)
                .resizable()
                .frame(width: widthAndHeight, height: widthAndHeight)
                .background(Color.gray)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.black, lineWidth: 1.0)
                }
        })
        .disabled(isDisabled)
    }
}

#Preview {
    PlayBackButton(action: {}, imageName: "next", isDisabled: false, widthAndHeight: 44)
}
