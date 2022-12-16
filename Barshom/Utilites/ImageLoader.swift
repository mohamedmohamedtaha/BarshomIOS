//
//  ImageLoader.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import UIKit
import SDWebImage
public class ImageLoader {
    
    public init() {}
    
    public static func download(
        fromUrl imageUrl: String,
        saveWithFileName fileName: String,
        withCompletionHandler completion: ((_ image: UIImage) -> Void)? = nil ) {
        
        SDWebImageDownloader.init().downloadImage(with: URL(string: imageUrl)!, options: SDWebImageDownloaderOptions.highPriority, progress: nil) { (img, data, error, bol) in
            if error == nil
            {
                completion!(img!)
            }
        }
    }
}
