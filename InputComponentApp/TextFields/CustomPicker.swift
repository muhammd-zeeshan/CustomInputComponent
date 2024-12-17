//
//  CustomPicker.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 16/12/2024.
//

import SwiftUI

struct CustomPicker: View {
    var width: CGFloat
    @Binding var selectedValue: String
    let values: [String]
    let title: String
    
    @State private var scrollID: String?
    
    init(width: CGFloat, selectedValue: Binding<String>, values: [String], title: String) {
        self.width = width
        self._selectedValue = selectedValue
        self.values = values
        self.title = title
        _scrollID = State(initialValue: selectedValue.wrappedValue)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.gray)
                .font(.caption)
                .padding(.bottom, 4)
            
            HStack(spacing: 0){
                ZStack {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(values, id: \.self) { value in
                                Text(value).fixedSize().font(.title3)
                                    .frame(width: 64, height: 60)
                                    .foregroundStyle(selectedValue == value ? .white : .gray)
                                    .id(value)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.vertical, 20)
                    .scrollPosition(id: $scrollID, anchor: .center)
                    .onChange(of: scrollID) { _, newValue in
                        if let newValue {
                            selectedValue = newValue
                        }
                    }
                }
                .frame(height: 100)
                VStack(spacing: 5) {
                    Image(systemName: "chevron.up")
                    Image(systemName: "chevron.down")
                }
                .font(.footnote)
            }
            
            .padding(.trailing, 8)
            .frame(width: width, height: 40)
            .background(.gray.tertiary, in: .rect(cornerRadius: 12))
            .clipped()
        }
    }
}

#Preview {
    ContentView()
}
