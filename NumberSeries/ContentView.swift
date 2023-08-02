//
//  ContentView.swift
//  NumberSeries
//
//  Created by Bhumika Patel on 02/08/23.
//

import SwiftUI


struct ContentView: View {
    @State private var numberString = ""
    @State private var maximumNumber = 0
    @State private var currentIndex = 0
    
    private var numberRange: ClosedRange<Int> {
        1...max(maximumNumber, 1)
    }
    
    var body: some View {
        VStack {
            TextField("Enter a number greater than 0", text: $numberString, onCommit: {
                if let number = Int(numberString), number > 0 {
                    maximumNumber = number
                    currentIndex = 1 // Reset the current index when the maximum number changes.
                }
            })
            .keyboardType(.numberPad)
            
            HStack {
                Button("Prev", action: prevButtonTapped)
                Spacer()
                Button("Next", action: nextButtonTapped)
            }
            .padding()
            ScrollView(.horizontal){
                HStack {
                   
                    ForEach(numberRange, id: \.self) { num in
                        
                        BoxView(number: num, isActive: num == currentIndex)
                    }
                }
            }
        }
        .padding()
    }
    
    private func nextButtonTapped() {
        if maximumNumber > 1 {
            currentIndex = (currentIndex % maximumNumber) + 1
        }
    }
    
    private func prevButtonTapped() {
        if maximumNumber > 1 {
            currentIndex = (currentIndex - 2 + maximumNumber) % maximumNumber + 1
        }
    }
}

struct BoxView: View {
    let number: Int
    let isActive: Bool
    
    var body: some View {
        Text("\(number)")
            .foregroundColor(isActive ? .white : .black)
            .frame(width: 50, height: 50)
            .background(isActive ? Color.blue : Color.gray)
            .cornerRadius(8)
            .padding(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
