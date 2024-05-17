//   EventViewModel.swift
//   goMLB
//
//   Created by: Grant Perry on 4/23/24 at 4:36 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
   @Published var filteredEvents: [GameEvent] = []
   @Published var teamPlaying: String = "New York Yankees"
   @Published var lastPlayHist: [String] = []
   @Published var subStrike = 0
   @Published var foulStrike2: Bool = false
   @Published var startDate: String = ""
   @Published var startTime: String = ""
   private var isDataLoaded = false

   func loadData() {
	  guard !isDataLoaded else { return } // Prevent reloading if data is already loaded
	  isDataLoaded = true

	  guard let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard") else { return }
	  URLSession.shared.dataTask(with: url) { data, response, error in
		 guard let JSONDecodedData = data, error == nil else {
			print("Network error: \(error?.localizedDescription ?? "No error description")")
			return
		 }
		 do {
			let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: JSONDecodedData)
			DispatchQueue.main.async {
			   self.filteredEvents = decodedResponse.events.flatMap { event in
				  event.competitions.map { competition -> GameEvent in
					 let homeTeam = competition.competitors[0]
					 let awayTeam = competition.competitors[1]
					 let situation = competition.situation
					 let inningTxt = competition.status.type.detail

					 return GameEvent(
						id: UUID(),
						title: event.name,
						shortTitle: event.shortName,
						home: homeTeam.team.name,
						visitors: awayTeam.team.name,
						homeRecord: homeTeam.records.first?.summary ?? "0-0",
						visitorRecord: awayTeam.records.first?.summary ?? "0-0",
						inning: event.status.period,
						homeScore: homeTeam.score ?? "0",
						visitScore: awayTeam.score ?? "0",
						homeColor: homeTeam.team.color,
						homeAltColor: homeTeam.team.alternateColor,
						visitorColor: awayTeam.team.color,
						visitorAltColor: awayTeam.team.alternateColor,
						on1: situation?.onFirst ?? false,
						on2: situation?.onSecond ?? false,
						on3: situation?.onThird ?? false,
						lastPlay: situation?.lastPlay?.text ?? inningTxt,
						balls: situation?.balls ?? 0,
						strikes: situation?.strikes ?? 0,
						outs: situation?.outs ?? 0,
						homeLogo: homeTeam.team.logo,
						visitorLogo: awayTeam.team.logo,
						inningTxt: inningTxt,
						thisSubStrike: 0,
						thisCalledStrike2: false,
						startDate: "",
						startTime: "",
						atBat: situation?.batter?.athlete.shortName ?? "",
						atBatPic: situation?.batter?.athlete.headshot ?? "",
						atBatSummary: situation?.batter?.athlete.summary ?? ""
					 )
				  }
			   }
//			   print("Filtered Events Count: \(self.filteredEvents.count)")
//			   for event in self.filteredEvents {
//				  print("Event: ID: \(event.id), \(event.title), \(event.shortTitle)")
//			   }
			}
		 } catch {
			print("Error decoding JSON: \(error)")
		 }
	  }.resume()
   }

   func updateTeamPlaying(with team: String) {
	  teamPlaying = team // Update the teamPlaying with the new team
	  loadData() // Reload data based on the new team
   }

   private func extractDateAndTime(from dateString: String) { // split up the date string
	  let parts = dateString.split(separator: "T")
	  if parts.count == 2 {
		 self.startDate = String(parts[0])
		 self.startTime = String(parts[1].dropLast())  // Removes the 'Z' if present
	  }
   }
}

// MARK:  Helpers

extension GameViewModel {
   func convertTimeTo12HourFormat(time24: String, DST: Bool) -> String {
	  // Create a DateFormatter to parse the input time in 24-hour format
	  let inputFormatter = DateFormatter()
	  inputFormatter.dateFormat = "HH:mm"
	  inputFormatter.timeZone = TimeZone(abbreviation: "UTC") // Assume the input is in UTC
	  inputFormatter.locale = Locale(identifier: "en_US_POSIX")  // Use POSIX to ensure the format is interpreted correctly

	  // Parse the input time string to a Date object
	  guard let date = inputFormatter.date(from: time24) else {
		 return "Invalid time"  // Return an error message or handle appropriately
	  }

	  // If DST is true, add one hour to the date
	  let adjustedDate = DST ? date.addingTimeInterval(3600) : date

	  // Create another DateFormatter to format the Date object to 12-hour time format with AM/PM
	  let outputFormatter = DateFormatter()
	  outputFormatter.dateFormat = "h:mm a"
	  outputFormatter.timeZone = TimeZone.current  // Set to user's current timezone
	  outputFormatter.locale = Locale.current  // Adjust to the current locale for correct AM/PM

	  // Convert the adjusted Date object to the desired time format string
	  let time12 = outputFormatter.string(from: adjustedDate)
	  return time12
   }
}


