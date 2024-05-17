//   gameScoreView.swift
//   goMLB
//
//   Created by: Grant Perry on 5/12/24 at 1:47 PM
//     Modified: 
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

struct goMLBView: View {
   @ObservedObject var gameViewModel = GameViewModel()

   var body: some View {
	  NavigationStack {
		 List(gameViewModel.filteredEvents, id: \.id) { event in
			NavigationLink(destination: GameDetailView(event: event)) {
			   LiveGameScoreView(
				  vm: gameViewModel,
				  titleSize: 35,
				  tooDark: "#747575",
				  event: event,
				  scoreSize: 95
			   )
			}
		 }
		 .navigationTitle("Live Games")
		 .refreshable {
			gameViewModel.loadData()
		 }
		 .onAppear {
			if gameViewModel.filteredEvents.isEmpty {
			   gameViewModel.loadData()
			}
		 }
	  }
   }
}

#Preview {
   goMLBView(gameViewModel: GameViewModel())
}

