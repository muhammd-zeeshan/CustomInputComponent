//
//  CountryPickerSheet.swift
//  InputComponentApp
//
//  Created by Muhammad Zeeshan on 16/12/2024.
//

import SwiftUI

struct Country: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var flag: String
    var dialingCode: String
    var maxNumberLength: Int
    var region: String
}

struct CountryPickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCountry: Country
    let countriesByRegion: [String: [Country]]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCountriesByRegion.keys.sorted(), id: \.self) { region in
                    Section(header: Text(region).bold()) {
                        ForEach(filteredCountriesByRegion[region] ?? []) { country in
                            Button {
                                selectedCountry = country
                                dismiss()
                            } label: {
                                HStack {
                                    Text(country.flag)
                                    Text(country.name)
                                    Spacer()
                                    Text(country.dialingCode)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .tint(Color.primary)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
            .navigationTitle("Select Country")
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
    }
    
    private var filteredCountriesByRegion: [String: [Country]] {
        if searchText.isEmpty {
            return countriesByRegion
        } else {
            var filtered = [String: [Country]]()
            for (region, countries) in countriesByRegion {
                let matchedCountries = countries.filter { country in
                    country.name.lowercased().contains(searchText.lowercased()) ||
                    country.dialingCode.contains(searchText)
                }
                if !matchedCountries.isEmpty {
                    filtered[region] = matchedCountries
                }
            }
            return filtered
        }
    }
}

#Preview {
//    CountryPickerSheet()
    PhoneNumberTextField()
}


struct PhoneNumberTextField: View {
    @State var phoneNumber = ""
    @State var selectedCountry = Country(name: "Austria", flag: "🇦🇹", dialingCode: "+43", maxNumberLength: 10, region: "Europe")
    @State var isPickerPresented = false
    var countries: [Country] = [
        // Europe
        Country(name: "Austria", flag: "🇦🇹", dialingCode: "+43", maxNumberLength: 10, region: "Europe"),
        Country(name: "Germany", flag: "🇩🇪", dialingCode: "+49", maxNumberLength: 11, region: "Europe"),
        Country(name: "France", flag: "🇫🇷", dialingCode: "+33", maxNumberLength: 9, region: "Europe"),
        
        //Africa
        Country(name: "Nigeria", flag: "🇳🇬", dialingCode: "+234", maxNumberLength: 10, region: "Africa"),
        Country(name: "South Africa", flag: "🇿🇦", dialingCode: "+27", maxNumberLength: 9, region: "Africa"),
        Country(name: "Egypt", flag: "🇪🇬", dialingCode: "+20", maxNumberLength: 10, region: "Africa"),
        
        // Asia
        Country(name: "Japan", flag: "🇯🇵", dialingCode: "+81", maxNumberLength: 10, region: "Asia"),
        Country(name: "India", flag: "🇮🇳", dialingCode: "+91", maxNumberLength: 10, region: "Asia"),
        Country(name: "China", flag: "🇨🇳", dialingCode: "+86", maxNumberLength: 11, region: "Asia"),
        Country(name: "Pakistan", flag: "🇵🇰", dialingCode: "+92", maxNumberLength: 11, region: "Asia"),
        
        //North America
        Country(name: "United States", flag: "🇺🇸", dialingCode: "+1", maxNumberLength: 10, region: "North America"),
        Country(name: "Canada", flag: "🇨🇦", dialingCode: "+1", maxNumberLength: 10, region: "North America"),
        Country(name: "Mexico", flag: "🇲🇽", dialingCode: "+52", maxNumberLength: 10, region: "North America"),
        
        //South America
        Country(name: "Brazil", flag: "🇧🇷", dialingCode: "+55", maxNumberLength: 11, region: "South America"),
        Country(name: "Argentina", flag: "🇦🇷", dialingCode: "+54", maxNumberLength: 10, region: "South America"),
        Country(name: "Chile", flag: "🇨🇱", dialingCode: "+56", maxNumberLength: 9, region: "South America"),
        
        //Oceania
        Country(name: "Australia", flag: "🇦🇺", dialingCode: "+61", maxNumberLength: 9, region: "Oceania"),
        Country(name: "New Zealand", flag: "🇳🇿", dialingCode: "+64", maxNumberLength: 9, region: "Oceania")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    isPickerPresented.toggle()
                } label: {
                    HStack {
                        Text(selectedCountry.flag)
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 55)
                    .background(Color.gray.tertiary, in: .rect(cornerRadius: 12))
                }
                .tint(.primary)
                .sheet(isPresented: $isPickerPresented) {
                    CountryPickerSheet(selectedCountry: $selectedCountry, countriesByRegion: groupCountriesByRegion())
                        .presentationDragIndicator(.visible)
                }
                TextField("Phonenumber", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .padding(.leading, 12)
                    .frame(height: 55)
                    .background(Color.gray.tertiary, in: .rect(cornerRadius: 12))
                    .onChange(of: phoneNumber) { old, newValue in
                        if newValue.count > selectedCountry.dialingCode.count + selectedCountry.maxNumberLength {
                            phoneNumber = String(newValue.prefix(selectedCountry.dialingCode.count + selectedCountry.maxNumberLength))
                        }
                        matchedCountryForDialingCode()
                    }
                    .onChange(of: selectedCountry) { old, newValue in
                        phoneNumber = newValue.dialingCode
                    }
                    .onAppear {
                        if phoneNumber.isEmpty {
                            phoneNumber = selectedCountry.dialingCode
                        }
                    }
            }
        }
    }
    
    private func matchedCountryForDialingCode() {
        guard phoneNumber.count >= 2 else { return }
        
        //Normalize the input to handle both "+81" and "0001"
        let normalizedPhoneNumber = phoneNumber.replacingOccurrences(of: "^00", with: "+", options: .regularExpression)
        
        for country in countries {
            if normalizedPhoneNumber.starts(with: country.dialingCode) {
                selectedCountry = country
                break
            }
        }
    }
    
    private func groupCountriesByRegion()  -> [String: [Country]] {
        Dictionary(grouping: countries) {$0.region}
    }
}
