//
//  Library.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 28.12.2021.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader {
                    geometry in
                    HStack(spacing: 20) {
                        Button {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizedTrackDetailsController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(Color.init(#colorLiteral(red: 1, green: 0.1719351113, blue: 0.4505646229, alpha: 1)))
                                .background(Color.init(.lightGray))
                                .cornerRadius(10)
                        }
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                        } label: {
                            Image(systemName: "arrow.clockwise")
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
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture().onEnded{ _ in
                            self.track = track
                            self.showingAlert = true
                        }.simultaneously(with: TapGesture().onEnded{ _ in
//                            let keyWindow = UIApplication.shared.connectedScenes.filter({
//                                $0.activationState == .foregroundActive
//                            }).map({$0 as? UIWindowScene}).compactMap({
//                                $0
//                            }).first?.windows.filter({
//                                $0.isKeyWindow
//                            }).first
                            let keyWindow = UIApplication.shared.connectedScenes
                            .filter({$0.activationState == .foregroundActive})
                            .map({$0 as? UIWindowScene})
                            .compactMap({$0})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                            
                            let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                            tabBarVC?.trackDetailView.delegate = self
                            
                            self.track = track
                            self.tabBarDelegate?.maximizedTrackDetailsController(viewModel: self.track)
                        }))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("delete?"), buttons: [.destructive(Text("Удалить"), action: {
                    self.delete(track: self.track)
                }), .cancel()])
            })
                .navigationTitle("Library")
        }
    }
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            let url: URL = URL(string: cell.iconUrlString ?? "")!
            URLImage(url) { image in
                image.resizable().frame(width: 60, height: 60).cornerRadius(5)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName ?? "")")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPrevTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil}
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPrevTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil}
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}
