import UIKit

let str = "가나다라ㅎㄱㅎㅊ"

let pt1 = #"[가-힣ㄱ-ㅎㅏ-ㅣ]"#
let pt2 = #"[a-zA-Z]"#
let pt3 = #"[^가-힣ㄱ-ㅎㅏ-ㅣ]"#
let pt4 = #"[가-힣]"#
let pt5 = #"^\d{3}-\d{3,4}-\d{4}$"#
let pt6 = #"^01[0-1]{1}-\d{3,4}-\d{4}$"#
let pt7 = #"^01[0-1]{1}-?\d{3,4}-?\d{4}$"#
let pt8 = #"[A-Z0-9a-z]+@[A-Za-z0-9]+\.[A-Za-z]+"#
let pt9 = #"\w+@\w+\.[A-Za-z]+"#
let pt10 = #"(.)\1"#
let pt11 = #"(.)\1\1"#
let pt12 = #"(.)\1\1\1"#
let pt13 = #"^var\s+(\w+)\s*:\s*(\w+)$"#
let pt14 = #"^var\s+(\w+)\s*:\s*Int\s*=\s*(\d+)$"#
let pt15 = #"19[0-9]{2}|20[0-9]{2}"# //연도
let pt16 = #"0[1-9]|1[0-2]"# //월
let pt17 = #"0[1-9]|1[0-9]|2[0-9]|3[0-1]"# //일


let checkResult = str.range(of: pt1, options: .regularExpression) != nil
print(checkResult)
