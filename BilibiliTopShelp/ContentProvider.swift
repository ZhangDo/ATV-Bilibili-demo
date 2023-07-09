//
//  ContentProvider.swift
//  BiliBiliTopShelp
//
//  Created by zhang dong on 2023/2/26.
//

import TVServices

class ContentProvider: TVTopShelfContentProvider {

    override func loadTopShelfContent(completionHandler: @escaping (TVTopShelfContent?) -> Void) {
        // Fetch content and call completionHandler
        completionHandler(nil);
    }

}

