//
//  BookDetailView.swift
//  searchBook
//
//  Created by jaeyung kim on 2/29/24.
//

import Foundation
import SwiftUI

struct BookDetailView: View {

    let detail: BookDetail
    
    var body: some View {
        ScrollView {
            VStack {
                Text("").font(.largeTitle)
                // 썸네일
                ImageView(urlString: detail.thumbnail)
                    .scaledToFit()
                // 타이틀
                Text(detail.title)
                    .padding()
                // 저자
                let authors = detail.authors.joined(separator: " | ")
                Text(authors)
                    .padding()
                // 출간일
                if let dateString = detail.dateString {
                    Text(dateString)
                    Spacer()
                }
                // 요약내용
                Text(detail.contents)
                    .padding()
                // 가격
                Text("정상가 : \(detail.price)")
                Text("할인가 : \(detail.sale_price)")
                Spacer()
            }
        }
    }
}
