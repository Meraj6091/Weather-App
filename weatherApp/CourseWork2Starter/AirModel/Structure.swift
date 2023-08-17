//
//  Structure.swift
//  CourseWork2Starter
//
//  Created by Meraj Vindira on 06/05/2023.
//

import Foundation

// MARK: - Welcome1
struct AirPollutionModel: Codable {
    let coord: Coord
    let list: [AirPollutionList]
}

struct Coord : Codable {
    let lon : Double
    let lat : Double
}

// MARK: - List
struct AirPollutionList: Codable {
    let dt: Int
    let main: AirPollutionDataMain
    let components: AirPollutionDataComponents
}

// MARK: - Main
struct AirPollutionDataMain: Codable {
    let aqi: Int
}

struct AirPollutionDataComponents : Codable {
    let co : Double
    let no : Double
    let no2 : Double
    let so2 : Double
    let pm2_5 : Double
    let pm10 : Double
    let nh3 : Double
    
}
