//
//  NewMaskView.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI

struct NewMaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var maskName: String = ""
    @State private var hours: Int = 2

    func onAdd() {
        withAnimation {
            let newMask = MaskDataWatch(context: viewContext)
            newMask.id = UUID()
            newMask.name = maskName
            newMask.secondsInUse = 0
            let seconds = Int32(hours) * 60 * 60
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

    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color("Blue2"), Color("Blue3")]),
            startPoint: .topLeading,
            endPoint: .bottomLeading)

        return ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                Text("newMask.maskNameLabel").font(.headline)
                TextField("newMask.maskNamePlaceholder", text: $maskName).padding(.bottom, 20)
                Text("newMask.recomendedTime").font(.headline)
                Picker("", selection: $hours) {
                    ForEach(1..<150) { i in
                        Text(String(format: NSLocalizedString("newMask.time", comment: "amount of hours"), i)).tag(i)
                    }
                }.frame(height: 60).padding(.bottom, 20)
                .pickerStyle(WheelPickerStyle())
                Button(action: onAdd) {
                    Text("newMask.add")
                        .font(.headline)
                        .foregroundColor(.white).padding(.horizontal, 10)
                }
                .background(gradient)
                .cornerRadius(40)
                .shadow(radius: 10)
                .frame(minWidth: 0, maxWidth: .infinity)
                .disabled(maskName.isEmpty)
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .navigationTitle(Text("title.addMask"))
    }
}

struct NewMaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewMaskView().environment(\.managedObjectContext, PersistenceControllerWatch.preview.container.viewContext)
    }
}
