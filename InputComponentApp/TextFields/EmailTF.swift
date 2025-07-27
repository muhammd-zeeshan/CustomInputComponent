//
//  EmailTF.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 17/12/2024.
//

import SwiftUI

struct EmailTF: View {
    @Binding var emailAddress: String
    @Binding var send: Bool
    var action: () -> Void
    @State var isValidEmail = true
    @State var showError = false
    
    var body: some View {
        VStack {
            TextField("email address", text: $emailAddress)
                .padding(.leading, 10).padding(.trailing, 50)
                .frame(height: 70)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
                .contentTransition(.symbolEffect)
                .foregroundColor(isValidEmail ? .primary : .red)
                .overlay(alignment: .trailing) {
                    SendButton(send: $send) {
                        isValidEmail = validateemail(emailAddress)
                        if isValidEmail {
                            withAnimation {
                                action()
                                showError = false
                            }
                        } else {
                            showError = true
                        }
                    }
                }
                .overlay(alignment: .leading) {
                    if showError {
                        invalidView
                    }
                }
        }
        .onChange(of: emailAddress) { oldValue, newValue in
            isValidEmail = true
            showError = false
        }
    }
    
    var invalidView: some View {
        Text("Invalid email address")
            .foregroundStyle(.red)
            .font(.caption)
            .padding(.leading, 10)
            .offset(y: -25)
            .transition(.opacity)
    }
    
    private func validateemail(_ email: String) -> Bool {
        let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let predicate = NSPredicate(format: "SELF MATCHES NQ", emailPattern)
        
        // Check if email format matches basic pattern
        guard predicate.evaluate(with: email) else { return false }
        
        // Chaeck if domain part contains atleast one period
        if let domainPart = email.split(separator: "@").last {
            return domainPart.contains(".")
        }
        return false
    }
}

#Preview {
    EmailTF(emailAddress: .constant(""), send: .constant(false), action: {})
}


struct SendButton: View {
    @Binding var send: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: send ? "checkmark" : "arrow.right")
                .font(.title).padding(12)
                .foregroundColor(.black)
                .background(.primary, in: RoundedRectangle(cornerRadius: send ? 50 : 10))
        }
        .padding(.trailing, 10)
        .tint(.primary)
    }
}
