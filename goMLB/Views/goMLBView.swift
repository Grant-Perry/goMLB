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
   @ObservedObject var gameViewModel: GameViewModel //= GameViewModel()
   @State private var selectedGame: GameEvent? 

   var body: some View {
	  NavigationStack {
		 ScrollView {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 20)], spacing: 20) {
			   ForEach(gameViewModel.filteredEvents, id: \.ID) { event in
				  NavigationLink(value: event) {
					 LiveGameScoreView(vm: gameViewModel, titleSize: 35, tooDark: "#747575", event: event, scoreSize: 95)
				  }
//				  .buttonStyle(PlainButtonStyle())
//				  .buttonStyle(Button)
			   }
			}
		 }
		 .navigationDestination(for: GameEvent.self) { selectedEvent in
			GameDetailView(gameViewModel: gameViewModel) //, event: selectedEvent) // Adjusted to use GameEvent
		 }
		 .navigationTitle("Live Games")
		 .onAppear(perform: gameViewModel.loadData)
	  }
   }
}

#Preview {

    goMLBView(gameViewModel: GameViewModel())
}
