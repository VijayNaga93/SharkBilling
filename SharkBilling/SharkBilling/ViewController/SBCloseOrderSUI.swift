//
//  SBCloseOrderSUI.swift
//  SharkBilling
//
//  Created by Vijay on 16/10/23.
//

import SwiftUI

struct SBCloseOrderSUI: View {
    
    
    @ObservedObject var viewModel: SBCloseOrderSUIModel
    
    @State private var totalText = ""
    @State private var taxText = ""
    
    @State private var discountTypeSegment = 0
    @State private var dByPercentageText = ""
    @State private var dByAmountText = ""
    
    @State private var paymentTypeSegment = 0
    
    @State private var tabAmountTxt = ""
    
    @State private var isToggled = false
    @State private var splitCountText = ""
    @State private var splitPerShareText = ""
    
    @State private var finalPaymentText = ""
    
    @State private var paidAmtText = ""
    @State private var returnedAmtText = ""
    @State private var remainingAmtText = ""
    
    
    @State private var isShowingAlert = false
    
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack {
                    
                    // MARK: - 1 Total payment and tax
                    
                    HStack {
                        Text("Total")
                        TextField("", text: $totalText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                            .keyboardType(.decimalPad)
                        
                        Text("Tax 5%")
                        TextField("", text: $taxText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                            .keyboardType(.decimalPad) // Restrict input to numbers
                    }
                    Spacer().frame(height: 20)
                    
                    // MARK: - 2 Discount
                    
                    VStack {
                        Text("Discount Type")
                        Picker("Discount Type", selection: $discountTypeSegment) {
                            Text("By Percentage").tag(0)
                            Text("By Amount").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        if discountTypeSegment == 0 {
                            TextField("By Percentage", text: $dByPercentageText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Restrict input to numbers
                        }
                        else {
                            TextField("By Amount", text: $dByAmountText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Restrict input to numbers
                            
                        }
                        
                    }
                    Spacer().frame(height: 20)
                    
                    // MARK: - 3 Payment type
                    VStack {
                        Text("Payment Type")
                        Picker(selection: $paymentTypeSegment, label: Text("Payment Method")) {
                            Text("Cash").tag(0)
                            Text("Debit Card").tag(1)
                            Text("Credit Card").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if paymentTypeSegment == 2 {
                            Text("CreditCard surchange 1.2%")
                                .foregroundColor(.red)
                        }
                    }
                    Spacer().frame(height: 20)
                    
                    // MARK: - 4 Tab amount
                    VStack {
                        HStack {
                            Text("Tab Amount:")
                            
                            // MARK: - 1
                            TextField("", text: $tabAmountTxt)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Restrict input to numbers
                        }
                        Spacer().frame(height: 20)
                    }
                    
                    // MARK: - 5 Split
                    
                    VStack {
                        Toggle("Split", isOn: $isToggled)
                            .padding()
                        
                        if isToggled {
                            HStack {
                                Text("Split Count")
                                TextField("", text: $splitCountText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad) // Restrict input to numbers
                                
                                Text("Per Share")
                                TextField("", text: $splitPerShareText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)
                                    .keyboardType(.decimalPad) // Restrict input to numbers
                                
                            }
                        }
                        Spacer().frame(height: 20)
                    }
                    
                    Divider()
                    VStack {
                        HStack {
                            Text("Payment")
                            TextField("", text: $finalPaymentText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(true)
                                .keyboardType(.decimalPad) // Restrict input to numbers
                            
                        }
                        
                        HStack {
                            VStack {
                                Text("Paid")
                                TextField("", text: $paidAmtText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(false)
                                    .keyboardType(.decimalPad) // Restrict input to numbers
                                
                            }
                            VStack {
                                Text("Returned")
                                TextField("", text: $returnedAmtText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)
                                    .keyboardType(.decimalPad) // Restrict input to numbers
                                
                            }
                            VStack {
                                Text("Remaining")
                                TextField("", text: $remainingAmtText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)
                                    .keyboardType(.decimalPad) // Restrict input to numbers
                                
                            }
                        }
                        
                        Spacer().padding(.top, 50)
                        
                        VStack {
                            Button {
                                printBill()
                            } label: {
                                Rectangle()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(Color.green)
                                    .overlay(Text("Print Bill").foregroundColor(Color.white))
                                    .cornerRadius(5)
                            }
                            .alert(isPresented: $isShowingAlert) {
                                Alert(
                                    title: Text("Alert"),
                                    message: Text("Payment not done"),
                                    primaryButton: .default(Text("OK")) {
                                        print("OK button tapped")
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    }
                    
                }
                .padding()
                .onChange(of: paymentTypeSegment) { newValue in
                    finalPaymentCalculation()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    // Call your function when the keyboard disappears
                    keyboardDidHide()
                }
                .onTapGesture {
                    //                    Dismiss the keyboard when tapped outside of the TextEditor
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
            .navigationBarTitle("Payment")
            
        }
        .onAppear {
            addValueToElements()
        }
    }
    
    func keyboardDidHide() {
        finalPaymentCalculation()
    }
    
    func printBill()
    {
        finalPaymentCalculation()
        print("paidAmtText-->\(paidAmtText) --- finalPaymentText-->\(finalPaymentText)")
        if paidAmtText == "" || Float(paidAmtText) ?? 0.0 < Float(finalPaymentText) ?? 0.0 {
            isShowingAlert = true
        } else {
            SBBillingCalculationHandler.printInvoice(invoiceDataModel: viewModel.invoiceDataModel)
        }
    }
    
    func addValueToElements()
    {
        totalText = "\(staticCurrentType)\(viewModel.invoiceDataModel.billTotal ?? 0.0)"
    }
    
    func finalPaymentCalculation()
    {
        
        var finalPaymentAmount : Float = 0.0
        
        let billTotal = formatDecimal(viewModel.invoiceDataModel.billTotal ?? 0.0)
        finalPaymentAmount = billTotal
        
        let taxPercent = formatDecimal(viewModel.invoiceDataModel.tax ?? 0.0)
        let taxAmount = billTotal * taxPercent / 100
        taxText = "\(staticCurrentType)\(taxAmount)"
        
        if discountTypeSegment == 0 {
            if dByPercentageText != ""  {
                let discountPercentage = formatDecimal(Float(dByPercentageText) ?? 0.0)
                let discountAmount = (discountPercentage / 100.0) * billTotal
                finalPaymentAmount = billTotal - discountAmount
            }
        } else if discountTypeSegment == 1 {
            if dByAmountText != "" {
                let discountAmount = formatDecimal(Float(dByAmountText) ?? 0.0)
                finalPaymentAmount = billTotal - discountAmount
            }
        }
        
        
        if paymentTypeSegment == 2 {
            let surChargeAmount = (finalPaymentAmount / 100.0) * staticCreditCardCharge
            finalPaymentAmount = formatDecimal(finalPaymentAmount + surChargeAmount)
        }
        
        if tabAmountTxt != "" {
            let tabAmount = formatDecimal(Float(tabAmountTxt) ?? 0.0)
            finalPaymentAmount = finalPaymentAmount - tabAmount
        }
        
        if isToggled, splitCountText != "" {
            let splitCount = Int(splitCountText) ?? 0
            let splitAmount = finalPaymentAmount / Float(splitCount)
            splitPerShareText = "\(formatDecimal(splitAmount))"
        }
        
        
        finalPaymentText = "\(finalPaymentAmount)"
        
        if paidAmtText != "" {
            let paidAmount = formatDecimal(Float(paidAmtText) ?? 0.0)
            let remainingAmount = formatDecimal(finalPaymentAmount - paidAmount)
            if remainingAmount < 0 {
                returnedAmtText = "\(remainingAmount)"
                remainingAmtText = "0.0"
            } else {
                remainingAmtText = "\(remainingAmount)"
                returnedAmtText = "0.0"
            }
        }
        
    }
    
    
    
    func formatDecimal(_ value: Float) -> Float {
        // Convert the Float to a String with the desired format
        let formattedString = String(format: "%.2f", value)
        
        // Convert the formatted string back to a Float
        if let formattedFloat = Float(formattedString) {
            return formattedFloat
        } else {
            // Return the original value if conversion fails
            return value
        }
    }
    
    func formatDecimalToString(_ value: Float) -> String {
        return String(format: "%.\(2)f", value)
    }
    
}

struct SBCloseOrderSUI_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SBCloseOrderSUIModel(invoiceDataModel: InvoiceModel())
        SBCloseOrderSUI(viewModel: viewModel)
    }
}
