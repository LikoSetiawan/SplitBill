//
//  ContentView.swift
//  SplitBill
//
//  Created by Liko Setiawan on 28/01/24.
//


import SwiftUI

struct ContentView: View {
    //Buat tutup keyboard setelah input
    @FocusState private var amountIsFocused: Bool
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 0
    let taxPercentages = [10, 11, 20, 25, 0]
    @State private var taxPercentage = 10
    
    let serviceTaxPercentages = [5, 6, 7, 10, 0]
    @State private var serviceTaxPercentage = 5
    
    var grantTotal : Double{
        let taxPercentage = Double(taxPercentage)
        let serviceTaxPercentage = Double(serviceTaxPercentage)

        let taxValue = billAmount / 100 * taxPercentage
        let updateValue = billAmount + taxValue
        let serviceTaxValue = updateValue / 100 * serviceTaxPercentage
        let grantTotals = updateValue + serviceTaxValue
        
        return grantTotals
    }
    
    var totalPerPerson : Double{
        // ditambah 2 karena kalo foreach itu mulai loop dari 0
        //kalo tanpa tambah 2 loopnya start dari 0,1,2,3,4,5...
        //kalo pakai tambah 2 loopnya start dari 2,3,4,5,6,7...
        let peopleCount = Double(numberOfPeople + 2)

        let amountPerPerson = grantTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Bill Cost", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "JPY")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    
                    Picker("Number Of people", selection: $numberOfPeople){
                        ForEach(2..<11){ people in
                            Text("\(people) Kepala")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Tax"){
                    Picker("Tip Percentage", selection: $taxPercentage){
                        ForEach(taxPercentages, id: \.self){ tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Service Tax"){
                    Picker("Tip Percentage", selection: $serviceTaxPercentage){
                        ForEach(serviceTaxPercentages, id: \.self){ tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total Harga Setelah Tax and service"){
                    Text(grantTotal,format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
                }
                Section("Yang harus dibayar per orang ya") {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "JPY"))
                    }
            }
            .navigationTitle("Split Bill")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
