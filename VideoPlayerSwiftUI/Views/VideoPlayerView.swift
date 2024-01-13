//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @StateObject private var videoPlayerViewModel: VideoPlayerViewModel = VideoPlayerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VideoPlayer(player: videoPlayerViewModel.player) {
                    VStack(alignment: .center) {
                        HStack {
                            Button(action: {}, label: {
                                Image("previous")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(videoPlayerViewModel.isPlaying ? "pause" : "play")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image("next")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .background(.gray)
                                    .clipShape(Circle())
                                    .overlay {
                                       Circle()
                                            .stroke(.black, lineWidth: 1.0)
                                    }
                            })
                        }
                        .padding(.horizontal, 80)
                    }
                }
                .frame(height: 300)
                
                ScrollView {
                    Text("Title")
                    Text("Author")
                    Text("Description")
                }
            }
            .navigationTitle("Video Player")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
