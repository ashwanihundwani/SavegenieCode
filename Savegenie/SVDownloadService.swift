//
//  SVDownloadService.swift
//  Savegenie
//
//  Created by Ashwani Hundwani on 7/1/16.
//  Copyright © 2016 Ashwani Hundwani. All rights reserved.
//

import UIKit
import Alamofire

class SVDownloadService: NSObject {
    
    static private func download(request:NSURLRequest, completionHandler handler:(String?, NSError?) -> Void) {
        
        var filePath:String? = nil
        Alamofire.download( request,destination: { (temporaryURL, response) in
            
            if response.statusCode != 200 {
                
                handler(nil, NSError(domain: SVConstants.APP_NAME, code: 200, userInfo: nil))
                
            }
            filePath = SVUtil.pathByAddingFileName(response.suggestedFilename!)!.absoluteString
            return SVUtil.pathByAddingFileName(response.suggestedFilename!)!
            
        })
            .response { (request, response, data, error) in
                
                handler(filePath, nil)
        }
        
    
        
    }
    
    static internal func downloadDataZip(completionHandler handler: (String? , NSError?) -> Void){
        
        let url = SVConstants.DATA_ZIP_URL
        
        let urlRequest = NSURLRequest(URL: NSURL(string: url)!)
        
        SVDownloadService.download(urlRequest, completionHandler: handler)
    }

}
