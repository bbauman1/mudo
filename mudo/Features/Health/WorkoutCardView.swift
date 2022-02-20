//
//  WorkoutCardView.swift
//  mudo
//
//  Created by Brett Bauman on 2/20/22.
//

import Foundation
import SwiftUI

struct WorkoutCardView: View {
    
    let entry: WorkoutEntry
    
    var body: some View {
        HStack(alignment: .top) {
            icon
            VStack(alignment: .leading) {
                Text(entry.workoutName)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                makeStat(value: entry.durationValue / 60, measurement: entry.durationMeasurement)
                makeStat(value: entry.energyValue, measurement: entry.energyMeasurement)
            }
            .foregroundColor(.white)
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
        Image(systemName: "heart.text.square")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .scaledToFit()
            .frame(width: 32, height: 32)
    }
    
    func makeStat(value: Double, measurement: Measurement) -> some View {
        Text("\(value, specifier: "%.\(measurement.significantDigits)f")")
            .font(.system(size: 22, weight: .bold, design: .rounded))
        +
        Text(" " + measurement.unit)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
    }
}
