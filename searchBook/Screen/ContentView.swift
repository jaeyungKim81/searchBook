//
//  ContentView.swift
//  searchBook
//
//  Created by jaeyung kim on 2/29/24.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var bookVM: BookViewModel
    @State var searchText: String = ""

    var body: some View {

        NavigationView {
            VStack {
                HStack {
                    TextField("검색어를 입력하세요", text: $searchText)
                    Button("검색") {
                        bookVM.requestBook(searchText: searchText)
                    }
                }
                
                Spacer()
                
                List(bookVM.books, id: \.isbn) { book in
                    HStack {
                        ImageView(urlString: book.thumbnail)
                            .frame(width: 100, height: 100)
                        
                        NavigationLink(destination: BookDetailView(detail: book)) {
                            Text(book.title)
                        }
                    }
                }
            }
            .padding()
        }
    }
}



#Preview {
    ContentView()
}
