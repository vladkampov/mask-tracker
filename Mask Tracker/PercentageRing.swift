//
//  PercentageRing.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 11.10.2020.
//

import SwiftUI

extension Double {
    func toRadians() -> Double {
        return self * Double.pi / 180
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

struct PercentageRing: View {
    let ringWidth: CGFloat
     let percent: Double
     let backgroundColor: Color
     let startAngle: Double = -90

    // Gradient colors
    let foregroundColors: [Color]
    private var firstGradientColor: Color {
      self.foregroundColors.first ?? .black
    }
    private var lastGradientColor: Color {
      self.foregroundColors.last ?? .black
    }
    // 1. Get the start angle for the gradient
    private var gradientStartAngle: Double {
      self.percent >= 100 ? relativePercentageAngle - 360 : startAngle
    }
    // 2. Compute the gradient
    private var ringGradient: AngularGradient {
      AngularGradient(
        gradient: Gradient(colors: self.foregroundColors),
        center: .center,
        startAngle: Angle(degrees: self.gradientStartAngle),
        endAngle: Angle(degrees: relativePercentageAngle)
      )
    }

    private static let ShadowColor: Color = Color.black.opacity(0.2)
    private static let ShadowRadius: CGFloat = 5
    private static let ShadowOffsetMultiplier: CGFloat = ShadowRadius + 2

    private var absolutePercentageAngle: Double {
      RingShape.percentToAngle(percent: self.percent, startAngle: 0)
    }
    private var relativePercentageAngle: Double {
      // Take into account the startAngle
      absolutePercentageAngle + startAngle
    }

    // Returns the (x, y) location of the offset
    private func getEndCircleLocation(frame: CGSize) -> (CGFloat, CGFloat) {
      // Get angle of the end circle with respect to the start angle
      let angleOfEndInRadians: Double = relativePercentageAngle.toRadians()
      let offsetRadius = min(frame.width, frame.height) / 2
      return (offsetRadius * cos(angleOfEndInRadians).toCGFloat(), offsetRadius * sin(angleOfEndInRadians).toCGFloat())
    }

    private func getEndCircleShadowOffset() -> (CGFloat, CGFloat) {
      let angleForOffset = absolutePercentageAngle + (self.startAngle + 90)
      let angleForOffsetInRadians = angleForOffset.toRadians()
      let relativeXOffset = cos(angleForOffsetInRadians)
      let relativeYOffset = sin(angleForOffsetInRadians)
      let xOffset = relativeXOffset.toCGFloat() * PercentageRing.ShadowOffsetMultiplier
      let yOffset = relativeYOffset.toCGFloat() * PercentageRing.ShadowOffsetMultiplier
      return (xOffset, yOffset)
    }

    var body: some View {
        // 1. Wrap view in a GeometryReader so that the view has access to its parent size
         GeometryReader { geometry in
                         ZStack {
                           // 2. Background for the ring
                           RingShape()
                             .stroke(style: StrokeStyle(lineWidth: self.ringWidth))
                             .fill(self.backgroundColor)
                           // 3. Foreground
                            RingShape(percent: self.percent, startAngle: self.startAngle)
                              .stroke(style: StrokeStyle(lineWidth: self.ringWidth, lineCap: .round))
                              .fill(self.ringGradient)
                            Circle()
                            .fill(self.lastGradientColor)
                            .frame(width: self.ringWidth, height: self.ringWidth, alignment: .center)
                            .offset(x: self.getEndCircleLocation(frame: geometry.size).0,
                                    y: self.getEndCircleLocation(frame: geometry.size).1)
                            .shadow(color: PercentageRing.ShadowColor,
                                    radius: PercentageRing.ShadowRadius,
                                    x: self.getEndCircleShadowOffset().0,
                                    y: self.getEndCircleShadowOffset().1)
                         }
                        }
         // 4. Padding to ensure that the entire ring fits within the view size allocated
         .padding(self.ringWidth / 2)
    }
}

struct PercentageRing_Previews: PreviewProvider {
    static var previews: some View {
        PercentageRing(ringWidth: 50, percent: 1, backgroundColor: Color("LightBlue"), foregroundColors: [Color("Blue2"), Color("Blue2")])
    }
}
