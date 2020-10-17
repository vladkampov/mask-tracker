//
//  ContentView.swift
//  Mask Tracker Watch App Extension
//
//  Created by Vladyslav Kampov on 17.10.2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MaskDataWatch.createdAt, ascending: false)],
        animation: .default)
    private var masks: FetchedResults<MaskDataWatch>

    var body: some View {
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(masks) { m in
                    MaskListItemView(mask: m)
                }
                NewMaskListItemView(listLength: masks.count)
            }
            .padding(.all)
        }.navigationTitle(Text("list.masks"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceControllerWatch.preview.container.viewContext)
    }
}
