//
//  SearchBar.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 17/12/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var search: String
    @State var show = false
    var body: some View {
        ZStack {
            ZStack {
                if show {
                    TextField("Search", text: $search)
                        .padding(.leading)
                }
            }
            .frame(height: show ? 55 : 40)
            .frame(maxWidth: show ? .infinity : 40)
            .background(.gray.tertiary, in: Capsule())
            .overlay(alignment: show ? .trailing : .center) {
                Image(systemName: show ? "xmark" : "magnifyingglass")
                    .font(.title3)
                    .contentTransition(.symbolEffect)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            show.toggle()
                            search = ""
                        }
                    }
                    .padding(.trailing, show ? 15 : 0)
            }
            .clipped()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    SearchBar(search: .constant(""))
}
