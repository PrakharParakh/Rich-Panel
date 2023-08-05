//
//  Plans.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import Foundation

struct Plans: Identifiable{
    var id = UUID()
    var devices: Devices
    var plan: Plan
    var duration: String
}

struct Plan: Identifiable,Encodable{
    var id = UUID()
    var monthlyPrice: Int
    var videoQuality: String
    var resolution: String
    var devicesSuppoted: [String]
}

struct Devices{
    var name: String
}
