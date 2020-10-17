//
//  CardView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct CardView: View {
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
                VStack {
                    ZStack {
                        PercentageRing(ringWidth: 30, percent: percent!, backgroundColor: Color("LightBlue").opacity(0.6), foregroundColors: [Color("Blue2"), Color("Blue2")])
                            .frame(width: 150, height: 150, alignment: .center)
                            .cornerRadius(40)
                        VStack {
                            Text(description)
                                .font(.headline)
                                .foregroundColor(descriptionColor)
                        }
                    }
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
            } else {
                VStack {
                    Image(image)
                        .resizable()
                        .clipped()
                        .scaledToFill()
                        .frame(width: 150)
                    Text(LocalizedStringKey(title))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Text(LocalizedStringKey(description))
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }

        }
        .frame(width: 246, height: 250)
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(title: "Usual mask", description: "04:02", image: "Mask Placeholder", percent: 20, isRunning: false)
            CardView(title: "Usual mask", description: "04:02", image: "Mask Placeholder", percent: 20, isRunning: true)
            CardView(title: "Usual mask", description: "Aesome description", image: "Mask Placeholder", isRunning: false)
        }
    }
}
#endif
