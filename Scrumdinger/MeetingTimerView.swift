//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Ataias Pereira Reis on 26/12/20.
//

import SwiftUI

struct MeetingTimerView: View {
    @Binding var speakers: [ScrumTimer.Speaker]
    var scrumColor: Color
    private var currentSpeaker: String { speakers.first(where: { !$0.isCompleted })?.name ?? "Someone" }
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text(currentSpeaker)
                    .font(.title)
                Text("is speaking")
            }
            .accessibilityElement(children: .combine)
            .foregroundColor(scrumColor.accessibleFontColor)
        }
        .padding([.horizontal])
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    @State static var speakers = [ScrumTimer.Speaker(name: "Kim", isCompleted: true), ScrumTimer.Speaker(name: "Bill", isCompleted: false)]
    static var previews: some View {
        MeetingTimerView(speakers: $speakers, scrumColor: Color("Design"))
    }
}
