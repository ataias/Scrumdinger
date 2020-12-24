//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Ataias Pereira Reis on 24/12/20.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel("Start Meeting")
                }

                HStack {
                    Label("Meeting Length", systemImage: "clock")
                        .accessibilityLabel("Meeting Length")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore) // color information is not relevant for VoiceOver
            }

            Section(header: Text("Atendees")) {
                ForEach(scrum.attendees, id: \.self) { atendee in
                    Label(atendee, systemImage: "person")
                        .accessibilityLabel("Person")
                        .accessibilityValue(atendee)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(scrum.title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.data[0])
        }
    }
}