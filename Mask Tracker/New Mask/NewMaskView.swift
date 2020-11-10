//
//  NewMaskView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

enum MaskType: LocalizedStringKey {
    case MEDICAL = "Medical"
    case FABRIC = "Fabric"
    case FFP2 = "FFP2"
    case FFP3 = "FFP3"
    case CUSTOM = "Custom"
}

let MaskTypeUseHours = [
    MaskType.MEDICAL: 2,
    MaskType.FABRIC: 2,
    MaskType.FFP2: 100,
    MaskType.FFP3: 100,
    MaskType.CUSTOM: 2
]

struct MaskTypeStruct: Identifiable {
    var id = UUID()
    var type: MaskType
}

struct NewMaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var maskType = MaskType.MEDICAL
    @State private var maskName: String = ""
    @State private var hours: Int = 2

    var maskTypes: [MaskTypeStruct] = [
        MaskTypeStruct(type: MaskType.MEDICAL),
        MaskTypeStruct(type: MaskType.FABRIC),
        MaskTypeStruct(type: MaskType.FFP2),
        MaskTypeStruct(type: MaskType.FFP3),
        MaskTypeStruct(type: MaskType.CUSTOM)
    ]

    func randomizeName() {
        // TODO: Connect store of the funny random names
        print("lalka")
    }

    func onAdd() {
        withAnimation {
            let newMask = MaskData(context: viewContext)
            newMask.id = UUID()
            newMask.name = maskName
            newMask.secondsInUse = 0
            let seconds = Int32(hours + 1) * 60 * 60
            newMask.secondsToBeUsed = seconds
            newMask.createdAt = Date()
            newMask.changedAt = Date()
            newMask.isCounterActive = false
            newMask.usedTimes = 0

            do {
                try viewContext.save()
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func onMaskTypeChange(t: MaskType) {
        // TODO: Change image
        withAnimation {
            if t != MaskType.CUSTOM {
                hours = MaskTypeUseHours[t] ?? 2
            }
        }
    }

    func onTimeChange(t: Int) {
        withAnimation {
            if t != MaskTypeUseHours[MaskType.MEDICAL] && t != MaskTypeUseHours[MaskType.FFP3] && t != MaskTypeUseHours[MaskType.FABRIC] && t != MaskTypeUseHours[MaskType.FFP2] {
                maskType = MaskType.CUSTOM
            }
        }
    }

    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color("Blue2"), Color("Blue3")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)

        return ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                Image("Mask Placeholder")
                    .resizable()
                    .clipped()
                    .scaledToFit()
                    .frame(width: 100).cornerRadius(40)
            }
            VStack(alignment: .leading, spacing: 20) {
                Text("newMask.maskNameLabel").font(.headline)
                HStack {
                    TextField("newMask.maskNamePlaceholder", text: $maskName)
// TODO: to be added going forward
//                    Button(action: randomizeName) {
//                        Text("newMask.random")
//                    }
                }
// TODO: to be added going forward
//                VStack(alignment: .leading) {
//                    Text("newMask.pickType").font(.headline)
//                    Text("newMask.typeDescription")
//                        .font(.caption)
//                        .multilineTextAlignment(.leading)
//                        .frame(height: 40.0)
//                }
//                Picker(
//                    selection: $maskType, label: Text("Mask Type")) {
//                    ForEach(maskTypes) { m in
//                        Text(m.type.rawValue).tag(m.type)
//                    }
//                }.pickerStyle(WheelPickerStyle()).onChange(of: maskType, perform: onMaskTypeChange)
                Text("newMask.recomendedTime").font(.headline)
                Picker("", selection: $hours) {
                    ForEach(1..<150) { i in
                        Text(String(format: NSLocalizedString("newMask.time", comment: "amount of hours"), i)).tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
// TODO: to be added going forward
//                .onChange(of: hours, perform: onTimeChange)
                Button(action: onAdd) {
                    Text("newMask.add")
                        .font(.headline)
                        .foregroundColor(.white).padding(.horizontal, 20)
                }
                .padding()
                .background(gradient)
                .cornerRadius(40)
                .shadow(radius: 10)
                .frame(minWidth: 0, maxWidth: .infinity)
                .disabled(maskName.isEmpty)
            }.padding(.horizontal, 50)
        }
        .navigationTitle(Text("title.addMask"))
    }
}

#if DEBUG
struct NewMaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewMaskView().environment(\.locale, .init(identifier: "ru"))
        }
    }
}
#endif
