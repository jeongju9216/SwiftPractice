//
//  ContentView.swift
//  ChipSegmentControl
//
//  Created by 유정주 on 1/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var namesapce
    @State private var selectedIndex = 0
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(titles.enumerated()), id: \.offset) {
                index,
                title in
                Button {
                    withAnimation {
                        selectedIndex = index
                    }
                } label: {
                    let isSelected = selectedIndex == index
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(uiColor: isSelected ? .white : .black))
                        .padding(.horizontal, 12)
                        .frame(
                            width: isFillEqually ? maxButtonWidth() : nil, // 조건에 따라 너비 지정
                            height: 48
                        )
                        .background {
                            if isSelected {
                                Capsule()
                                    .fill(capsureColor)
                                    .shadow(color: .black.opacity(0.1), radius: 16, y: 4)
                                    .padding(4)
                                    .matchedGeometryEffect(id: capsureID, in: namesapce)
                            }
                        }
                }
            }
        }
        .background {
            Capsule()
                .fill(Color(uiColor: .lightGray))
        }
    }
    
    private let capsureID = UUID()
    private let titles: [String]
    private let capsureColor: Color
    private let isFillEqually: Bool
    
    init(titles: [String], capsureColor: UIColor, isFillEqually: Bool = false) {
        self.titles = titles
        self.capsureColor = Color(uiColor: capsureColor)
        self.isFillEqually = isFillEqually
    }
    
    private func maxButtonWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 14)
        let maxWidth = titles.map { title in
            title.size(withAttributes: [NSAttributedString.Key.font: font]).width
        }.max() ?? 0
        return maxWidth + 24 // 패딩을 고려해 추가
    }
}

#Preview {
    ContentView(titles: ["Hello", "SwiftUI World"], capsureColor: .systemBlue, isFillEqually: true)
}
