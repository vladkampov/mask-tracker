//
//  SwiftUIView.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI

struct WatchCardView: View {
    var title: String
    var description: String
    var image: String
    var percent: Double?
    var isRunning: Bool

    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: isRunning ? [Color("Mint"), Color("Blue3")] : [Color("Blue2"), Color("Blue3")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)

        var descriptionColor = Color.white
        if percent != nil {
            descriptionColor = getTimeColor(percent: percent!, defaultColor: Color.white)!
        }

        return  ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(gradient)
                .shadow(radius: 10)

            if percent != nil {
                HStack {
                    PercentageRing(ringWidth: 10, percent: percent!, backgroundColor: Color("LightBlue").opacity(0.6), foregroundColors: [Color("Blue2"), Color("Blue2")])
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(40)
                        .padding(.trailing, 5)
                    VStack {
                        Text(description)
                            .font(.headline)
                            .foregroundColor(descriptionColor)
                        Text(title)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                }
            } else {
                HStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .frame(width: 60, alignment: .center/*@END_MENU_TOKEN@*/)
                    VStack {
                        Text(LocalizedStringKey(title))
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
            }

        }
        .frame(width: WKInterfaceDevice.current().screenBounds.width, height: 70)
    }
}

struct WatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            WatchCardView(title: "Usual mask", description: "04:02", image: "Mask Placeholder", percent: 20, isRunning: false)
            WatchCardView(title: "Usual mask", description: "04:02", image: "Mask Placeholder", percent: 20, isRunning: true)
            WatchCardView(title: "Create the new mask", description: "Awesome description", image: "Mask Placeholder", isRunning: false)
            WatchCardView(title: "Usual mask", description: "04:02", image: "Mask Placeholder", percent: 20, isRunning: false)
        }
    }
}
