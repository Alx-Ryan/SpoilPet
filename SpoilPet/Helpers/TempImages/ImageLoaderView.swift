//
//  ImageLoaderView.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
//    @StateObject var vm = DownLoadImageModel()
    
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                //.indicator(.progress(style: .linear))
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
                
            )
            .clipped()
        
    }
}

#Preview {
    ImageLoaderView()
        .clipShape(.rect(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
