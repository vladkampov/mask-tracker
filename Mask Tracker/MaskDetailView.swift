//
//  MaskDetailView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct MaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var mask: MaskData
    @State var isPopoverVisible = false

    func maskSave() {
        do {
          try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func onTimerStart() {
        withAnimation {
            mask.startCounter()
            maskSave()
        }
    }

    func onTimerStop() {
        withAnimation {
            mask.stopCounter()
            maskSave()
        }
    }

    func onTimerReset() {
        withAnimation {
            mask.resetCounter()
            maskSave()
        }
    }

    func onDelete() {
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

        return ScrollView(.vertical) {
            VStack {
                ZStack {
                    PercentageRing(ringWidth: 50, percent: percent, backgroundColor: Color("Blue3").opacity(0.3), foregroundColors: [Color("Blue2")])
                        .frame(width: 300, height: 300, alignment: .center)
                        .cornerRadius(40)
                    VStack {
                        Text("mask.used")
                        Text(String(format: "%02i:%02i:%02i", hours, minutes, seconds))
                            .font(.largeTitle)
                            .foregroundColor(timeColor)
                    }
                }
                .padding(.top)
                HStack {
                    VStack(alignment: .leading) {
                        Text("mask.left").font(.subheadline)
                        Text(String(format: "%02i:%02i:%02i", hoursLeft, minutesLeft, secondsLeft))
                            .font(.title)
                            .foregroundColor(timeColor)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("mask.times").font(.subheadline)
                        Text(String(mask.usedTimes))
                            .font(.title)
                    }
                }.padding(.all)
                Spacer()
                HStack {
                    Button(action: action) {
                        Text(mask.isCounterActive ? "mask.stop" : "mask.start")
                            .font(.headline)
                            .foregroundColor(.white).padding(.horizontal, 20)
                    }
                }
                .padding()
                .background(gradient)
                .cornerRadius(40)
                .shadow(radius: 10)
                .frame(minWidth: 0, maxWidth: .infinity)
                if mask.secondsInUse >= mask.secondsToBeUsed {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("Red"))
                        VStack {
                            HStack {
                                Text("mask.alert.title")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 5)
                                Spacer()
                            }

                            HStack {
                                Text("mask.alert.description")
                                    .font(.footnote)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }.padding()
                    }
                    .padding()
                    .shadow(radius: 10)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color("LightBlue"))
                        VStack {
                            HStack {
                                Text("mask.info.title")
                                    .font(.headline)
                                    .foregroundColor(Color("DarkPurple"))
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 5)
                                Spacer()
                            }

                            HStack {
                                Text("mask.info.description")
                                    .font(.footnote)
                                    .foregroundColor(Color("DarkPurple"))
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }.padding()
                    }
                    .padding()
                    .shadow(radius: 10)
                }
            }
        }
        .navigationTitle(Text(mask.name))
        .navigationBarItems(trailing: HStack {
            Button(action: onDelete) {
                Image(systemName: "trash.circle")
            }
            .imageScale(.large)
            .frame(width: 44, height: 44, alignment: .trailing)
            Button(action: onTimerReset) {
                Image(systemName: "arrow.counterclockwise.circle")
                    .imageScale(.large)
                    .frame(width: 44, height: 44, alignment: .trailing)
            }
        })
    }
}

#if DEBUG
struct MaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let newItem = MaskData.init(context: PersistenceController.preview.container.viewContext)
        newItem.id = UUID()
        newItem.name = "New mask"
        newItem.secondsInUse = 7200
        newItem.secondsToBeUsed = 7200
        newItem.createdAt = Date()
        newItem.changedAt = Date()
        newItem.isCounterActive = false
        newItem.usedTimes = 3
        return NavigationView {MaskDetailView(mask: newItem).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)}
    }
}
#endif
