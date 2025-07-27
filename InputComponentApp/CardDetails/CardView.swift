//
//  CardView.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 16/12/2024.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 34) {
            Image(systemName: "swift")
                .font(.title)
            
            HStack {
                CardNumber()
                Spacer()
                Image(systemName: "rectangle.split.2x2.fill").font(.title)
            }
            
            HStack {
                ExpiryData()
                Spacer()
                CVVCode()
            }
        }
        .padding()
        .background(.gray.tertiary, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    CardView()
}
