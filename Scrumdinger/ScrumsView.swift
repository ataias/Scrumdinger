//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Ataias Pereira Reis on 24/12/20.
//

import SwiftUI
import Intents
import CoreSpotlight
import MobileCoreServices

//let aTypeCreateScrum = "br.com.ataias.Scrumdinger.create-scrum"

// TODO remove repetition after
public enum Constants {
    static let storage = "demostorage"
    static let group = "br.com.ataias.Scrumdinger"
}

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    @State private var selection: String?
    let saveAction: () -> Void
    @AppStorage(Constants.storage, store: UserDefaults(
                    suiteName: Constants.group)) var store: String = "ORIGINAL"

    //    var shortcut: INShortcut {
    //        let activity = NSUserActivity(activityType: aTypeCreateScrum)
    //        activity.persistentIdentifier =
    //            NSUserActivityPersistentIdentifier(aTypeCreateScrum)
    ////        activity.isEligibleForSearch = true
    ////        activity.isEligibleForPrediction = true
    //
    //        let intent = ScrumIntent()
    //        intent.suggestedInvocationPhrase = "Start Scrum"
    //
    //        return intent
    //    }
    var shortcut: INShortcut {

        let shortcut = INShortcut(intent: {
            let intent = ScrumIntent()
            intent.suggestedInvocationPhrase = "Start Scrum"
            return intent
        }())
        return shortcut!
    }

    fileprivate func newScrum() {
        newScrumData = DailyScrum.Data()
        isPresented = true
    }

    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(
                    destination: DetailView(scrum: binding(for: scrum)),
                    tag: "\(scrum.id)",
                    selection: $selection,
                    label: {
                        CardView(scrum: scrum)
                    }
                )
                .listRowBackground(scrum.color)
            }
            SiriButton(shortcut: shortcut)
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newScrum()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                isPresented = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                                scrums.append(newScrum)
                                isPresented = false
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .onAppear {
            print(store)
        }
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
