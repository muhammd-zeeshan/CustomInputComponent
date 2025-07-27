//
//  CVVCode.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 16/12/2024.
//

import SwiftUI

struct CVVCode: View {
    @State private var deletedCharacters: [Character] = []
    @State private var inputText: String = ""
    @State var TFPromot = "000"
    @FocusState var isTYping: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("CVV Code")
                .foregroundStyle(.gray)
            TextFieldView
        }
    }
    
    var TextFieldView: some View {
        TextField("", text: $inputText)
            .font(.system(.body, design: .monospaced))
            .keyboardType(.numberPad)
            .focused($isTYping)
            .overlay(alignment: .leading) {
                Text("\(TFPromot)")
                    .font(.system(.body, design: .monospaced))
                    .frame(width: 35, alignment: .trailing)
                    .offset(x: -2)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        isTYping = true
                    }
            }
    }
    
    private func formatInputText() {
        inputText = String(inputText.prefix(3)).filter{ $0.isNumber }
    }
}

#Preview {
    CVVCode()
}
