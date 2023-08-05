//
//  PlansView.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import SwiftUI
import Firebase

var PlansDataMonthly = [
    Plans(devices: Devices(name: "Mobile"), plan: Plan(monthlyPrice: 100, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table"]), duration: "Monthly"),
    Plans(devices: Devices(name: "Basic"), plan: Plan(monthlyPrice: 200, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly"),
    Plans(devices: Devices(name: "Standard"), plan: Plan(monthlyPrice: 500, videoQuality: "Better", resolution: "1080p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly"),
    Plans(devices: Devices(name: "Premium"), plan: Plan(monthlyPrice: 700, videoQuality: "Best", resolution: "4K+HDR", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Monthly")
]

var PlansDataYearly = [
    Plans(devices: Devices(name: "Mobile"), plan: Plan(monthlyPrice: 1000, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table"]), duration: "Yearly"),
    Plans(devices: Devices(name: "Basic"), plan: Plan(monthlyPrice: 2000, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Yearly"),
    Plans(devices: Devices(name: "Standard"), plan: Plan(monthlyPrice: 5000, videoQuality: "Better", resolution: "1080p", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Yearly"),
    Plans(devices: Devices(name: "Premium"), plan: Plan(monthlyPrice: 7000, videoQuality: "Best", resolution: "4K+HDR", devicesSuppoted: ["Phone","Table","Computer","TV"]), duration: "Yearly")
]
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct PlansView: View {
    let columns = [
        GridItem(.fixed(UIScreen.screenWidth / 2)),
        GridItem(.fixed(UIScreen.screenWidth / 2)),
        GridItem(.fixed(UIScreen.screenWidth / 2)),
        GridItem(.fixed(UIScreen.screenWidth / 2))
        ]
    @State var planDataMonthly = PlansDataMonthly
    @State var planDataYearly = PlansDataYearly
    @State var planData: [Plans] = PlansDataMonthly
    @State var selectedPlan: Int = 0
    @State var selected: Int = 0
    @StateObject var vm = PaymentViewModel()
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Text("Choose the right plan for you")
                        .font(.title)
                        .padding()
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack{
                            VStack(spacing : 20){
                                HStack{
                                    Button{
                                        selected = 0
                                    }label: {
                                        Text("Monthly")
                                            .foregroundColor(selected == 0 ? .blue : .white)
                                            .padding()
                                            .background{
                                                if selected == 0 {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .fill(.white)
                                                    
                                                    
                                                }
                                            }
                                    }
                                    Button{
                                        selected = 1
                                    }label: {
                                        Text("Yearly")
                                            .foregroundColor(selected == 1 ? .blue : .white)
                                            .padding()
                                            .background{
                                                if selected == 1 {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .fill(.white)
                                                    
                                                    
                                                }
                                            }
                                    }
                                }.onChange(of: selected, perform: { newValue in
                                    if newValue == 1{
                                        planData = planDataYearly
                                    }
                                    else{
                                        planData = planDataMonthly
                                    }
                                })
                                .padding()
                                    .background{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.blue)
                                    }
                                Text("Monthly Price")
                                    .padding(.bottom)
                                Text("Video Quality")
                                    .padding(.bottom)
                                Text("Resolution")
                                    .padding(.bottom)
                                Text("Devices you can use to watch")
                                    .padding(.bottom)

                            }
                            
                            
                            LazyVGrid(columns: columns) {
                                ForEach(0..<planData.count) { i in
                                    Button{
                                        selectedPlan = i
                                    }label: {
                                        VStack(spacing : 20){
                                            Text(planData[i].devices.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background{
                                                    Rectangle()
                                                        .frame(width: 120,height: 100)
                                                        .foregroundColor(selectedPlan == i ? .blue : .blue.opacity(0.3))
                                                }
                                            Text("\(planData[i].plan.monthlyPrice) INR")
                                                .foregroundColor(selectedPlan == i ? .blue : .gray)
                                                .padding(.top)
                                            Text(planData[i].plan.videoQuality)
                                                .foregroundColor(selectedPlan == i ? .blue : .gray)
                                                .padding(.top)
                                            Text(planData[i].plan.resolution)
                                                .foregroundColor(selectedPlan == i ? .blue : .gray)
                                                .padding(.top)
                                            Text(planData[i].plan.devicesSuppoted[0])
                                                .foregroundColor(selectedPlan == i ? .blue : .gray)
                                                .padding(.top)
                                        }

                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    NavigationLink(destination: CheckoutView(plan: planData[selectedPlan])) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 170, height: 40)
                                    .foregroundColor(.blue)
                            }
                    }

                }
            }

        }
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}
