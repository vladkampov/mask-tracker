//
//  MaskDetailView.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI

struct MaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var mask: MaskDataWatch

    private func maskSave() {
        do {
          try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func onTimerStart() {
        withAnimation {
            mask.startCounter()
            maskSave()
        }
    }

    private func onTimerStop() {
        withAnimation {
            mask.stopCounter()
            maskSave()
        }
    }

    private func onTimerReset() {
        withAnimation {
            mask.resetCounter()
            maskSave()
        }
    }

    private func onDelete() {
        withAnimation {
            mask.stopCounter()
            viewContext.delete(mask)
        }
    }

    var body: some View {
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: Int(mask.secondsInUse))
        let (hoursLeft, minutesLeft, secondsLeft) = secondsToHoursMinutesSeconds(seconds: Int(mask.secondsToBeUsed - mask.secondsInUse))
        let action = mask.isCounterActive ? onTimerStop : onTimerStart

        let percent = usedPercentage(current: mask.secondsInUse, max: mask.secondsToBeUsed)

        let timeColor = getTimeColor(percent: percent, defaultColor: nil)

        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color("Blue2"), Color("Blue3")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)
        let resetGradient = LinearGradient(
            gradient: Gradient(colors: [Color("Mint"), Color("Blue2")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)
        let deleteGradient = LinearGradient(
            gradient: Gradient(colors: [Color("LightRed"), Color("Red")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)

        return ScrollView(.vertical) {
            ZStack {
                PercentageRing(ringWidth: 30, percent: percent == 0 ? 0.1 : percent, backgroundColor: Color("Blue3").opacity(0.3), foregroundColors: [Color("Blue2")])
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(40)
                Text(String(format: "%02i:%02i:%02i", hours, minutes, seconds))
                    .font(.title2)
                    .foregroundColor(timeColor)
                    .shadow(radius: 10/*@END_MENU_TOKEN@*/)
            }.padding()
            Button(action: action) {
                Text(mask.isCounterActive ? "mask.stop" : "mask.start")
                    .font(.headline)
                    .foregroundColor(.white).padding(.horizontal, 20)
            }
            .background(gradient)
            .cornerRadius(40)
            .shadow(radius: 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            VStack(alignment: .center) {
                Text("mask.left").font(.subheadline)
                Text(String(format: "%02i:%02i:%02i", hoursLeft, minutesLeft, secondsLeft))
                    .font(.title)
                    .foregroundColor(timeColor)
            }.padding()
            VStack(alignment: .center) {
                Text("mask.times").font(.subheadline)
                Text(String(mask.usedTimes))
                    .font(.title)
            }.padding()
            Button(action: onTimerReset) {
                Text("mask.reset")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .background(resetGradient)
            .cornerRadius(40)
            .shadow(radius: 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom)
            Button(action: onDelete) {
                Text("mask.delete")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .background(deleteGradient)
            .cornerRadius(40)
            .shadow(radius: 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top)
        }.navigationBarHidden(false)
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .navigationTitle(mask.name)
    }
}

struct MaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let newItem = MaskDataWatch(context: PersistenceControllerWatch.preview.container.viewContext)
        newItem.id = UUID()
        newItem.name = "New mask"
        newItem.secondsInUse = 5303
        newItem.secondsToBeUsed = 7200
        newItem.createdAt = Date()
        newItem.changedAt = Date()
        newItem.isCounterActive = false
        newItem.usedTimes = 3
        return NavigationView {
            MaskDetailView(mask: newItem).environment(\.managedObjectContext, PersistenceControllerWatch.preview.container.viewContext)
        }
    }
}
