//
//  MaskListView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI
import CoreData

struct MaskListView: View {
    @ObservedObject var settings = UserSettings()

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MaskData.createdAt, ascending: false)],
        animation: .default)
    private var masks: FetchedResults<MaskData>
    
    private func onContinue() {
        settings.isWelcomeAccepted = true
    }

    var body: some View {
        return NavigationView {
            if !settings.isWelcomeAccepted {
                WelcomeView(onContinue: onContinue)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(masks) { m in
                            MaskListItemView(mask: m)
                        }
                        NewMaskListItemView(listLength: masks.count)
                    }
                    .padding(.all)
                }.frame(width: UIScreen.main.bounds.width).navigationTitle(Text("list.masks"))
                .navigationBarItems(
                    trailing: NewMaskButtonView()
                )
            }
        }
    }
}

#if DEBUG
struct MaskListView_Previews: PreviewProvider {
    static var previews: some View { 
        print( PersistenceController.preview.container.viewContext)
        return MaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif

struct NewMaskButtonView: View {
    var body: some View {
        NavigationLink(
            destination: NewMaskView()) {
            Image(systemName: "plus.circle").imageScale(.large)
        }
    }
}
