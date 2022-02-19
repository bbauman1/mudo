//
//  HealthCardView.swift
//  mudo
//
//  Created by Brett Bauman on 2/13/22.
//

import SwiftUI

struct HealthCardView: View {
    
    let dataType: HealthDataType
    let value: Double
    
    var body: some View {
        HStack(spacing: 8) {
            icon
            VStack(alignment: .leading) {
                descriptionText
                valueText
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.accentColor)
        )
    }
    
    var icon: some View {
        Image(systemName: dataType.symbolName)
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: 32, height: 32)
            .foregroundColor(.white)
            
    }
    
    var valueText: some View {
        Group {
            Text("\(value, specifier: "%.\(dataType.measurement.significantDigits)f")")
                .font(.system(size: 22, weight: .bold, design: .rounded))
            +
            Text(" " + dataType.measurement.unit)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        .foregroundColor(.white)
        .lineLimit(1)
    }
    
    var descriptionText: some View {
        Text(dataType.displayName)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
    }
}
