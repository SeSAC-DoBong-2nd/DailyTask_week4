//
//  LotteryResponseModel.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

struct LotteryResponseModel: Decodable {
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}