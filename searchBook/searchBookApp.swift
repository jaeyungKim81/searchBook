//
//  searchBookApp.swift
//  searchBook
//
//  Created by jaeyung kim on 2/29/24.
//

import SwiftUI

@main
struct searchBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(BookViewModel())
        }
    }
}
