//
//  PlanData.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import Foundation


var PlansData = {
    Plans(devices: Devices(name: "Mobile"), plan: Plan(monthlyPrice: 100, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table"]), duration: "Monthly")
    Plans(devices: Devices(name: "Basic"), plan: Plan(monthlyPrice: 200, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly")
    Plans(devices: Devices(name: "Standard"), plan: Plan(monthlyPrice: 500, videoQuality: "Better", resolution: "1080p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly")
    Plans(devices: Devices(name: "Premium"), plan: Plan(monthlyPrice: 700, videoQuality: "Best", resolution: "4K+HDR", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly")
    
    
}
