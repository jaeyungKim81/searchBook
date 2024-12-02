//
//  Book.swift
//  searchBook
//
//  Created by jaeyung kim on 2/29/24.
//

import Foundation


struct Book: Codable {
    let meta: BookMeta    //응답 관련 정보
    let documents: [BookDetail]    //응답 결과
}

struct BookMeta: Codable {
    let total_count: Int    //검색된 문서 수
    let pageable_count: Int    //total_count 중 노출 가능 문서 수
    let is_end: Bool    //현재 페이지가 마지막 페이지인지 여부, 값이 false면 page를 증가시켜 다음 페이지를 요청할 수 있음
}

struct BookDetail: Codable {
    
    let title: String    //도서 제목
    let contents: String    //도서 소개
    let url: String    //도서 상세 URL
    let isbn: String    //ISBN10(10자리) 또는 ISBN13(13자리) 형식의 국제 표준 도서번호(International Standard Book Number)
    let datetime: String//times    //도서 출판날짜, ISO 8601 형식
//    [YYYY]-[MM]-[DD]T[hh]:[mm]:[ss].000+[tz]
    let authors: [String]    //도서 저자 리스트
    let publisher: String    //도서 출판사
    let translators: [String]    //도서 번역자 리스트
    let price: Int    //도서 정가
    let sale_price: Int    //도서 판매가
    let thumbnail: String    //도서 표지 미리보기 URL
    let status: String    //도서 판매 상태 정보 (정상, 품절, 절판 등)
    //상황에 따라 변동 가능성이 있으므로 문자열 처리 지양, 단순 노출 요소로 활용 권장
    
    // "yyyy-MM-dd" 형식 출간일 문자 스트링
    var dateString: String? {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: datetime) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = tempLocale // reset the locale
            let dateString = dateFormatter.string(from: date)
            return dateString
        } else {
            return nil
        }
    }
}

