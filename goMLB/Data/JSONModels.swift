//   JSONModels.swift
//   goMLB
//
//   Created by: Grant Perry on 4/23/24 at 4:37 PM
//     Modified:
//
//  Copyright © 2024 Delicious Studios, LLC. - Grant Perry
//
import Foundation
import Combine
import SwiftUI

// Define your data structures
struct APIResponse: Codable {
   var events: [Event]
}

struct Event: Codable, Identifiable {
   var id: String
   var name: String
   var shortName: String
   var competitions: [Competition]
   var status: EventStatus
}

struct Competition: Codable {
   var competitors: [Competitor]
   var situation: Situation?
   var status: Status

   struct Status: Codable {
	  var type: TypeDetail

	  struct TypeDetail: Codable {
		 var detail: String
	  }
   }
}

struct Competitor: Codable {
   var team: Team
   var score: String?
   var records: [Record]
}

struct Record: Codable {
   var summary: String
}

struct Team: Codable {
   var name: String
   var logo: String
   var color: String
   var alternateColor: String
}

struct Situation: Codable {
   var balls: Int?
   var strikes: Int?
   var outs: Int?
   var onFirst: Bool?
   var onSecond: Bool?
   var onThird: Bool?
   var lastPlay: LastPlay?
   var batter: Batter?
}

struct Batter: Codable {
   var athlete: Athlete
}

struct Athlete: Codable {
   var shortName: String
   var headshot: String
   var summary: String?
}

struct LastPlay: Codable {
   var text: String?
}

struct EventStatus: Codable {
   var period: Int
}
