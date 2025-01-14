//
//  MovieResponseModel.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

struct MovieResponseModel: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
