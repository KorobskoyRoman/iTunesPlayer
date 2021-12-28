//
//  Library.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 28.12.2021.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader {
                    geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("123")
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(Color.init(#colorLiteral(red: 1, green: 0.1719351113, blue: 0.4505646229, alpha: 1)))
                                .background(Color.init(.lightGray))
                                .cornerRadius(10)
                        }
                        Button {
                            print("543")
                        } label: {
                            Image(systemName: "shuffle")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(Color.init(#colorLiteral(red: 1, green: 0.1719351113, blue: 0.4505646229, alpha: 1)))
                                .background(Color.init(.lightGray))
                                .cornerRadius(10)
                        }
                    }
                }.padding().frame(height: 75)
                Divider().padding(.leading).padding(.trailing)
//                Spacer()
                List {
                    LibraryCell()
                }
            }
            
            .navigationTitle("Library")
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image("iann").resizable().frame(width: 100, height: 100).cornerRadius(5)
            VStack {
                Text("Track name")
                Text("Artist name")
            }
        }
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
