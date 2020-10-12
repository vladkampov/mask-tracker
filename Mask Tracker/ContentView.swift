//
//  ContentView.swift
//  Mask Tracker
//
//  Created by Vladyslav Kampov on 10.10.2020.
//

import SwiftUI

struct ContentView: View {
    var tutors: [Tutor] = []

    var body: some View {
        NavigationView {
            List(tutors) {tutor in
                ExtractedView(tutor: tutor)
            }.navigationBarTitle(Text("Tutors"))
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tutors: testData)
    }
}
#endif

struct ExtractedView: View {
    var tutor: Tutor

    var body: some View {
        NavigationLink(destination: Text(tutor.name)) {
            HStack {
                Image(tutor.imageName)
                    .cornerRadius(40)
                VStack(alignment: .leading) {
                    Text(tutor.name)
                    Text(tutor.headline)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}
