//
//  ContentView.swift
//  CalendarView
//
//  Created by Riku on 2024/09/01.
//

import SwiftUI
import SwiftData
import ActivityKit

struct ContentView: View {
    @State private var url: String = "webcal://api.veracross.eu/fis/subscribe/410D2CF0-2F35-457D-8346-5733D699E015.ics?uid=FA9000D2-01E1-42E5-997F-E7045E35332A"
    @Query var dataEvents: [Event] = []
    @State private var isShowingErrorNoEvents = false
    @State private var isFunctionLoading = false
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            TextField("Calendar URL", text: $url)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Load Events") {
                loadEvents(from: url) { events in
                    DispatchQueue.main.async {
                        if events.isEmpty {
                            isShowingErrorNoEvents = true
                        } else {
                            do {
                                try modelContext.delete(model: Event.self)
                            } catch {
                                print("Failed to clear data.")
                            }
                            for event in events {
                                modelContext.insert(event)
                            }
                            try? modelContext.save()
                            print("Fetched \(events.count) events")
                            print("dataEvents: \(dataEvents.count)")
                            isShowingErrorNoEvents = false
                        }
                        
                    }
                }
            }
            .padding()
            
            Button("Start Live Activity") {
                if dataEvents.isEmpty {
                    isShowingErrorNoEvents = true
                } else {

                    let attributes = CalendarLiveAttributes()
                    let state = ActivityContent(state: CalendarLiveAttributes.ContentState(emoji: "", classIndex: 3), staleDate: nil)
                    _ = try? Activity<CalendarLiveAttributes>.request(attributes: attributes, content: state)
                }
            }
            .alert("No Events Loaded", isPresented: $isShowingErrorNoEvents) {
                
            } message: {
                Text("No events loaded. Load events by entering URL")
            }
            .padding()
        }
        .padding()
    }
    
    private func loadEvents(from urlString:String, completion: @escaping ([Event]) -> Void) {
        let httpsURLString = urlString.replacingOccurrences(of: "webcal://", with: "https://")
        
        guard let url = URL(string: httpsURLString) else {
                print("Invalid URL")
                completion([])
                return
            }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                    return
                }

                if let icsString = String(data: data, encoding: .utf8) {
                    let events = Event.parseICS(icsString)
                    completion(events)
                } else {
                    completion([])
                }
            }
        task.resume()
    }

    
}

#Preview {
    ContentView()
        .modelContainer(for: Event.self, inMemory: true)
}
