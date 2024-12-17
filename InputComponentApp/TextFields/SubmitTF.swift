//
//  SubmitTF.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 17/12/2024.
//

import SwiftUI

struct SubmitTF: View {
    @Binding var text: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            TextField("Submit", text: $text)
                .padding(.leading, 25)
                .frame(height: 70)
                .padding(.trailing, 50)
                .background(.gray.tertiary, in: .capsule)
                .overlay(alignment: .trailing) {
                    submitButton
                }
        }
    }
    var submitButton: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.up.right")
                .font(.title).padding(13)
                .background(.black, in: .circle)
        }
        .tint(.primary)
        .padding(.trailing, 10)
    }
}

#Preview {
    SubmitTF(text: .constant(""), action: {})
}
