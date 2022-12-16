//
//  AttachmentDto.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import ObjectMapper

public class Attachment: Mappable {
    
    public var fileId: Int = 0
    public var fileName: String = ""
    public var structName: String = ""
    public var downloadLink: String = ""
    public var image: UIImage?
    public var name: String = ""
    public var mimeType: String = ""
    public var data: Data?
    public var url: URL?
    public var isThumbnail = false
    public var isStruct = false

    public var storedImageFileName: String {
        get {
            return "ATTACHMENT_\(self.fileId)"
        }
    }
    
    public var isVideo: Bool {
        get {
            guard let url = URL(string: self.downloadLink) else {
                return false
            }
            
            switch url.pathExtension {
            case "png", "jpg", "jpeg":
                return false
            case "mp4":
                return true
            default:
                return false
            }
        }
    }
    
    public required init?(map: Map) {
    }
    
    public init() {
        
    }
    
    public func mapping(map: Map) {
        self.fileId <- map["FileId"]
        self.fileName <- map["FileName"]
        self.downloadLink <- map["DownloadLink"]
    }

}
