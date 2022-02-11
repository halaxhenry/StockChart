//
//  ContentView.swift
//  StockChart
//
//  Created by Seungchul Ha on 2022/02/11.
//

import SwiftUI

struct Stock: Identifiable {
    var id: String { name }
    let name: String
    let values: [Int]
    
    static let MSCIWorld = Stock(name: "MSCI World", values: [
        1015,1027,1012,1025,1035,1056,1023,1033,1067,1023,1021,1088,1099,1011,1015,1027,1012,1025,1035,1056,1023,1033,1067,1023,1021,1088,1099,1011,1015,1120,1012,1025,1035,1056,1023,1033,1120,1023,1021,1088,1099,1011,1015,1027,1012,1025,1035,1056,1120,1189,1067,1023,1021,1088,1099,1011,1120,1027,1012,1025,1035,1056,1023,1033,1067,1023,1120,1088,1099,1011,1015,899,1012,1025,1035,1120,1023,1667,1067,1023,1021,1088,1099,1011,1015,1027,1012,1025,1035,1056,1023,1033,1067,1023,655,1088,1099,1011,1015,1027,999,1025,1035,1056,1023,1033,1120,1023,1021,1088,1099,1011,1015,1027,1012,1025,1035,1056,1023,1033,1067,1023,1021,1088,1099,1011,1282,1299,1799
    ])
}

struct ContentView: View {
    
    let stock = Stock.MSCIWorld
    
    @State private var selectedValue: Int?
    
    @State private var activeValues = Stock.MSCIWorld.values
    
    var curPrice: Int {
        if let selectedValue = selectedValue {
            return selectedValue
        }
        return stock.values.last ?? 0
    }
    
    let bgColor = Color(hue: 0.337, saturation: 0.528, brightness: 0.624)
    let headerColor = Color(hue: 0.357, saturation: 0.233, brightness: 0.118)
    
    var body: some View {
        VStack(spacing: 0) {
            
            navBar
            
            LineGraphView(values: activeValues, selectedValue: $selectedValue)
                .accentColor(.black)
                .frame(maxHeight: .infinity)
            
            HStack {
                customButton(title: "ALL") {
                    activeValues = Array(stock.values.suffix(365))
                }
                
                customButton(title: "3M") {
                    activeValues = Array(stock.values.suffix(92))
                }
                
                customButton(title: "1M") {
                    activeValues = Array(stock.values.suffix(31))
                }
                
                customButton(title: "1W") {
                    activeValues = Array(stock.values.suffix(7))
                }
            }
            .padding(.top, 10)
        }
        .background(bgColor.ignoresSafeArea())
        .statusBar(hidden: true)
    }
    
    @State private var selectedButtonTitle = "ALL"
    
    func customButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            selectedButtonTitle = title
            selectedValue = nil
            action()
        }) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(selectedButtonTitle == title ? headerColor : .black.opacity(0.2))
                .cornerRadius(5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    var navBar: some View {
        HStack {
            Text("$ \(curPrice)")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            Text(stock.name)
                .font(.title.bold())
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(headerColor.ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
