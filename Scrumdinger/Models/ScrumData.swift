//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Ataias Pereira Reis on 26/12/20.
//

import Foundation

class ScrumData: ObservableObject {
    // MARK: - Properties
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
    @Published var scrums: [DailyScrum] = []

    // MARK: - Methods
    func load() {
        print(Self.fileURL)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                // UI updates should always happen in the main queue! The data below is directly related to a UI update!
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
                #endif
                return
            }
            #if DEBUG
            guard data.count != 0 else {
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
                return
            }
            #endif
            guard let dailyScrums = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
                fatalError("Can't decode saved scrum data")
            }
            DispatchQueue.main.async {
                self?.scrums = dailyScrums
            }
        }
    }

    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrums = self?.scrums else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(scrums) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
