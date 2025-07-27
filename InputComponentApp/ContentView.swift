//
//  ContentView.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 05/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDay = "01"
    @State private var selectedMonth = "January"
    @State private var selectedyear = "2021"
    
    private let days = (1...31).map {String(format: "%02d", $0)}
    private let months = Calendar.current.monthSymbols
    private let years = (1900...2100).map {String($0)}
    
    // Submit TF
    @State var text = ""
    // Email TF
    @State var emailAdress = ""
    @State var send = false
    
    //InfoField
    @State var Firstname = ""
    @State var Lastname = ""
    //SearchBar
    @State var search = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 44) {
                SearchBar(search: $search)
                
                CardView()
                
                InfoField(title: "First Name", text: $Firstname)
                InfoField(title: "Last Name", text: $Lastname)
                
                PhoneNumberTextField()
                
                HStack(spacing: 36){
                    CustomPicker(width: 70, selectedValue: $selectedDay, values: days, title: "Day")
                    CustomPicker(width: 136, selectedValue: $selectedMonth, values: months, title: "Months")
                    CustomPicker(width: 93, selectedValue: $selectedyear, values: years, title: "Year")
                }
                
                DateInputField()
                
                EmailTF(emailAddress: $emailAdress, send: $send, action: {send.toggle()})
                PasswordCheckField()
                
                SubmitTF(text: $text, action: {})
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
