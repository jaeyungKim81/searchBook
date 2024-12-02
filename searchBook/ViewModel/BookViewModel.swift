//
//  BookEngine.swift
//  searchBook
//
//  Created by jaeyung kim on 2/29/24.
//

import Foundation
import Combine

class BookViewModel: ObservableObject {
    
    @Published var books: [BookDetail] = []
    let searchBookUrl = "https://dapi.kakao.com/v3/search/book"
    let kakaoKey = "KakaoAK aee2cb1d4eee16c38eebfe393968efb5"
    
    func requestBook(searchText: String, method: String = "GET") {
        
        let urlString = ("\(searchBookUrl)?query=\(searchText)")
        guard let url = URL(string: urlString) else {
            return
        }
        
        print("request Url = \(url)")
        var cancleables = Set<AnyCancellable>()
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(kakaoKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Book.self, decoder: JSONDecoder())
            .map { book in
                // "정상판매" 인 것들만
                return book.documents.filter {
                    $0.status == "정상판매"
                }
            }
            .sink { completion in
                print("completion \(completion)")
                if case .failure(let err) = completion {
                    print("요청 실패 : \(err)")
                }
            } receiveValue: { [weak self] responseElements in
                print("responseElements \(responseElements)")
                guard let self = self else {
                    return
                }
                self.books.append(contentsOf: responseElements)
            }
            .store(in: &cancleables)
    }
}



