import UIKit

enum ChangeTeam: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}

//분단 배열
let teamList = ChangeTeam.allCases

func 돌려돌려돌림판() {
    print("---------------------------------------")
    
    //선택된 좌석 번호 담을 배열
    var benNumList = [Int]()
    
    for i in teamList {
        
        var arr = [Int]()
        //현재 팀 번호 추가
        arr.append(i.rawValue)
        //이전에 선택된 좌석 번호 arr에 추가
        arr.append(contentsOf: benNumList)
        
        let filterNum = teamList.filter {
            //아직 선택되지 않은 팀 필터링
            !arr.contains($0.rawValue)
        }
        
        //만약 4분단 차례에 filterNum 값에 5가 포함돼있다면
        if (i.rawValue == 4) && filterNum.contains(.five) {
            //4분단에 5를 대입
            //5가 아닌 다른 숫자를 가져간다면 이후 5분단 차례에 filterNum이 빈 배열이 돼 nil 값 반환하기 때문
            benNumList.append(5)
            print("\(i.rawValue)팀의 좌석은 \(5) 입니다.")
        } else {
            let place = filterNum.randomElement()!
            benNumList.append(place.rawValue)
            print("\(i.rawValue)팀의 좌석은 \(place.rawValue) 입니다.")
        }
        
    }
    
    print("---------------------------------------")
}

돌려돌려돌림판()


/*
 출력결과 예시
 1팀의 좌석은 1 입니다.
 2팀의 좌석은 2 입니다.
 3팀의 좌석은 3 입니다.
 4팀의 좌석은 4 입니다.
 5팀의 좌석은 5 입니다.
 ---------------------------------------
 1팀의 좌석은 5 입니다.
 2팀의 좌석은 3 입니다.
 3팀의 좌석은 1 입니다.
 4팀의 좌석은 2 입니다.
 5팀의 좌석은 4 입니다.
 */
