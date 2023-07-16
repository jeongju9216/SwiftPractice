import UIKit

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

let str1 = "안녕은 Hello. 잘가는 Bye."
let str2 = "안녕하세요 반갑습니다"

let regex1 = try Regex(#"[가-힣]+"#)
let regex2 = try Regex(#"[a-zA-Z]+"#)

//일치하는 첫 번째 항목 반환
print("\n===== firstMatch =====")
if let result = str1.firstMatch(of: regex1) {
    print("str: \(str1[result.range])")
    print("result: \(result.output.compactMap { $0.value })")
}

if let result = try? regex1.firstMatch(in: str1) {
    print("str: \(str1[result.range])")
}

if let result = str1.firstMatch(of: try Regex(#"[a-zA-z]+"#)) {
    print("str: \(str1[result.range])")
}

if let result = try /[a-zA-z]+/.firstMatch(in: str1) {
    print("str: \(str1[result.range])")
}

print("\n===== String range regularExpression =====")
if let range = str1.range(of: #"[가-힣]+"#, options: .regularExpression) {
    print("str: \(str1[range])")
}

//시작지점부터 일치하는지 확인
print("\n===== prefixMatch =====")
if let result = str1.prefixMatch(of: regex1) {
    print("str: \(str1[result.range])")
}

if let result = str1.prefixMatch(of: regex2) {
    print("result: \(result.output.compactMap { $0.value })")
} else {
    print("일치하지 않음")
}

//전체가 일치하는지 판단
print("\n===== wholeMatch =====")
if let result = str1.wholeMatch(of: regex1) {
    print("str: \(str1[result.range])")
} else {
    print("일치하지 않음")
}

if let result = try /[가-힣]{5}\s?[가-힣]{5}/.wholeMatch(in: "안녕하세요 반갑습니다") {
    print("result: \(result.output)")
} else {
    print("일치하지 않음")
}


print("\n===== firstMatch key-value =====")
let keyAndValue = /(.+?): (\d+)\s+(\d+)\s+(\d+)/
let setting = "color: 161 103 230"

if let match = setting.firstMatch(of: keyAndValue) {
    print("Value: \(match.output)")
}

print("\n===== swift code =====")
let varString = "var a: Int"
let varRegex1 = try Regex(#"\w+"#)
let match = varString.matches(of: varRegex1)
for item in match {
    print("match output: \(varString[item.range])")
}
let matchStrings = varString.matches(of: varRegex1).map { varString[$0.range] }
print("matchStrings: \(matchStrings)")

print("\n===== NSRegularExpression 1 =====")
let varPattern = #"^var\s+(\w+):\s?(\w+)$"#

let varRegex2 = try! NSRegularExpression(pattern: varPattern, options: [])
let varRange = NSRange(location: 0, length: varString.count)

if let match = varRegex2.firstMatch(in: varString, options: [], range: varRange),
   let varNameRange = Range(match.range(at: 1), in: varString),
   let typeRange = Range(match.range(at: 2), in: varString) {
    print("varName: \(varString[varNameRange])")
    print("type: \(varString[typeRange])")
}
    
print("\n===== NSRegularExpression 2 =====")
let varPattern2 = #"^var\s+(?<name>\w+):\s?(?<type>\w+)$"#
let varRegex3 = try! NSRegularExpression(pattern: varPattern2, options: [])

if let match = varRegex3.firstMatch(in: varString, options: [], range: varRange),
   let nameRange = Range(match.range(withName: "name"), in: varString),
   let typeRange = Range(match.range(withName: "type"), in: varString) {
    print("name: \(varString[nameRange])")
    print("type: \(varString[typeRange])")
}

print("\n===== NSRegularExpression 3 =====")
let match2 = varRegex3.matches(in: varString, options: [], range: varRange)
match2.forEach {
    let nameRange = Range($0.range(withName: "name"), in: varString)!
    let typeRange = Range($0.range(withName: "type"), in: varString)!
    print("name: \(varString[nameRange])")
    print("type: \(varString[typeRange])")
}

print("\n===== firstMatch 사용 =====")
if let match3 = varString.firstMatch(of: try Regex(varPattern2)) {
    print("name: \(match3.output.compactMap { $0.name })")
    print("value: \(match3.output.compactMap { $0.value })")
}
