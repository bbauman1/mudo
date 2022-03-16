//
//  AppThemePicker.swift
//  mudo
//
//  Created by Brett Bauman on 2/19/22.
//

import SwiftUI

struct AppThemePicker: View  {
    
    @AppStorage("appColor") var appColor: AppColor = .default
    @Environment(\.colorScheme) var colorScheme
    
    private let feedbackGenerator = UIImpactFeedbackGenerator()
    
    var body: some View {
        VStack {
            firstRow
            secondRow
            thirdRow
        }
    }
    
    var firstRow: some View {
        HStack {
            pickerItem(AppColor.allCases[0])
            Spacer()
            pickerItem(AppColor.allCases[1])
            Spacer()
            pickerItem(AppColor.allCases[2])
            Spacer()
            pickerItem(AppColor.allCases[3])
            Spacer()
            pickerItem(AppColor.allCases[4])
        }
    }
    
    var secondRow: some View {
        HStack {
            Spacer()
            pickerItem(AppColor.allCases[5])
            Spacer()
            pickerItem(AppColor.allCases[6])
            Spacer()
            pickerItem(AppColor.allCases[7])
            Spacer()
            pickerItem(AppColor.allCases[8])
            Spacer()
        }
    }
    
    var thirdRow: some View {
        HStack {
            pickerItem(AppColor.allCases[9])
            Spacer()
            pickerItem(AppColor.allCases[10])
            Spacer()
            pickerItem(AppColor.allCases[11])
            Spacer()
            pickerItem(AppColor.allCases[12])
            Spacer()
            pickerItem(AppColor.allCases[13])
        }
    }
    
    func pickerItem(_ appColor: AppColor) -> some View {
        Button {
            self.appColor = appColor
            feedbackGenerator.impactOccurred(intensity: 1.0)
            Analytics.track(.setAppColor(appColor))
        } label: {
            ZStack {
                Circle()
                    .fill(appColor.color)
                    .frame(width: 32, height: 32)
                    .overlay(appColor == self.appColor
                             ? Circle().stroke(colorScheme == .dark ? Color.white : .black, lineWidth: 3)
                             : nil)
                    .scaleEffect(appColor == self.appColor ? 1.2 : 1)
            }
            
        }
        .buttonStyle(.plain)
    }
}
