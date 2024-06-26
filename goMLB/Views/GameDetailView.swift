//   ContentView.swift
//   goMLB
//
//   Created by: Grant Perry on 4/21/24 at 4:37 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct GameDetailView: View {

   @ObservedObject var gameViewModel = GameViewModel()
   @Environment(\.colorScheme) var colorScheme
   @State private var showPicker = false
   @State private var refreshGame = true // refetch JSON
   @State var thisTimeRemaining = 15
   @State var selectedTeam = "New York Yankees"
   @State var timerValue = 15
   @State var timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect() // timer for refetch JSON
   @State var fakeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // timer to reflect remaining until refetch
   @State var scoreColor = Color(.blue)
   @State var winners = Color(.green)
   @State var scoreSize = 65.0
   @State var titleSize = 35.0
   @State var logoWidth = 10.0
   @State var version = "99.8"
   @State var tooDark = "#333333"

   //	var teams = MLBTeams.teams

   var body: some View {
	  let event = gameViewModel.filteredEvents.first
	  let atBat = event?.atBat
	  let atBatPic = event?.atBatPic
	  let liveAction: Bool = true

	  VStack {
 //	MARK: Title / Header Tile
		 if let thisVm = gameViewModel.filteredEvents.first {
			   scoreCardView(vm: gameViewModel,
							 event: event ?? thisVm,
							 titleSize: titleSize,
							 tooDark: tooDark,
							 scoreSize: Int(scoreSize),
							 refreshGame: $refreshGame,
							 timeRemaining: $thisTimeRemaining)
			}

			if liveAction {
			   VStack {
				  // MARK: Last Play & Bases card
				  HStack {
					 if let lastPlay = event?.lastPlay {  // is there a lastPlay
						Text(lastPlay)
						   .font(.footnote)
						   .lineLimit(1)
						   .minimumScaleFactor(0.5)
						   .scaledToFit()
					 }
				  }

 // MARK: Bases View
				  HStack {
					 BasesView(onFirst: event?.on1 ?? false,
							   onSecond: event?.on2 ?? true,
							   onThird: event?.on3 ?? false,
							   strikes: event?.strikes ?? 0,
							   balls: event?.balls ?? 0,
							   outs: event?.outs ?? 0,
							   inningTxt: event?.inningTxt ?? "Nothing yet",
							   thisSubStrike:	event?.thisSubStrike ?? 0,
							   atBat: atBat ?? "Big Dog",
							   atBatPic: atBatPic ?? "",
							   showPic: true)

				  }
			   }			// end bases section
			   .frame(width: UIScreen.main.bounds.width, height: 580)
			}			 // end list

 // MARK: // LastPlayHist list
			VStack {
			   ScrollView {
				  NavigationView {
					 List(Array(gameViewModel.lastPlayHist.reversed().enumerated()), id: \.1) { index, lastPlay in
						HStack {
						   Image(systemName: "baseball")
						   Text(lastPlay)
							  .font(index == 0 ? .body : .footnote)
							  .foregroundColor(index == 0 ? .green : .white)
							  .fontWeight(index == 0 ? .bold : .regular)
							  .minimumScaleFactor(0.5)
							  .scaledToFit()
						}
					 }
					 .toolbar {
						ToolbarItem(placement: .topBarLeading) {

						   Text("\(Image(systemName: "figure.baseball")) \(gameViewModel.filteredEvents.first?.atBat ?? "")\(gameViewModel.filteredEvents.first?.atBatSummary ?? "")")
							  .font(.headline)
							  .foregroundColor(.blue)
						}
					 }
				  }
				  .font(.footnote)
				  .frame(width: UIScreen.main.bounds.width, height: 150)
			   }
			}

			VStack {
			   Text("Version: \(getAppVersion())")
				  .font(.system(size: 10))
				  .padding(.bottom, 10)
			}
//			VStack {
//			   pickTeam()
//				  .frame(width: UIScreen.main.bounds.width, height: 20)
//				  .padding(.top, -15)
//			}
		 }

		 .onAppear(perform: gameViewModel.loadData)

		 .onReceive(timer) { _ in
			if self.refreshGame {
			   gameViewModel.loadData()
			}
			self.thisTimeRemaining = timerValue
		 }

		 // MARK: updating time remaining
		 .onReceive(fakeTimer) { _ in
			if self.thisTimeRemaining > 0 {
			   self.thisTimeRemaining -= 1
			} else  {
			   self.thisTimeRemaining = 15
			}
		 }

		 Button("Refresh") {
			gameViewModel.loadData()
		 }
		 .font(.footnote)
		 .padding(4)

		 .background(Color.blue)
		 .foregroundColor(.white)
		 .clipShape(Capsule())
		 //	  Spacer()
		 .preferredColorScheme(.dark)
   }
}

// MARK: Helpers

extension GameDetailView {

   func isHexGreaterThan(_ hex1: String, comparedTo hex2: String) -> Bool {
	  guard let int1 = hexToInt(hex1), let int2 = hexToInt(hex2) else {
		 return false
	  }
	  return int1 > int2
   }

   func hexToInt(_ hex: String) -> Int? {
	  var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

	  if hexSanitized.hasPrefix("#") {
		 hexSanitized.remove(at: hexSanitized.startIndex)
	  }

	  var intValue: UInt64 = 0
	  Scanner(string: hexSanitized).scanHexInt64(&intValue)
	  return Int(intValue)
   }

   func addPlayd(_ play: String) {
	  //		viewModel.lastPlayHist.append(play)
	  //		print("adding \(play) to lastPlayHist: \(play)")
   }

   func getAppVersion() -> String {
	  if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
		 return version
	  } else {
		 return "Unknown version"
	  }
   }

   func pickTeam() -> some View {
	  return Picker("Select a team:", selection: $selectedTeam) {
		 ForEach(teams, id: \.self) { team in
			Text(team).tag(team)
		 }
	  }
	  .pickerStyle(MenuPickerStyle())
	  .padding()
	  .background(Color.gray.opacity(0.2))
	  .cornerRadius(10)
	  .padding(.horizontal)

	  .onChange(of: selectedTeam) {
		 DispatchQueue.main.async {
			gameViewModel.lastPlayHist.removeAll() // clear the lastPlayHist
			gameViewModel.updateTeamPlaying(with: selectedTeam)
			gameViewModel.teamPlaying = selectedTeam
		 }
	  }
   }
}

#Preview {
   GameDetailView()
}


