//   gaveEvent.swift
//   goMLB
//
//   Created by: Grant Perry on 4/30/24 at 4:37 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//

import SwiftUI

   struct GameEvent: Identifiable {
	  var id = UUID()
	  var title: String
	  var shortTitle: String
	  var home: String
	  var visitors: String
	  var homeRecord: String
	  var visitorRecord: String
	  var inning: Int
	  var homeScore: String
	  var visitScore: String
	  var homeColor: String
	  var homeAltColor: String
	  var visitorColor: String
	  var visitorAltColor: String
	  var on1: Bool
	  var on2: Bool
	  var on3: Bool
	  var lastPlay: String?
	  var balls: Int
	  var strikes: Int
	  var outs: Int
	  var homeLogo: String
	  var visitorLogo: String
	  var inningTxt: String
	  var thisSubStrike: Int
	  var thisCalledStrike2: Bool
	  var startDate: String
	  var startTime: String
	  var atBat: String
	  var atBatPic: String
	  var atBatSummary: String
   }

