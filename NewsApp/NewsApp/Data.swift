//
//  Data.swift
//  NewsApp
//
//  Created by Yerasyl on 28.02.2024.
//

import Foundation
import SwiftyJSON

struct DataType: Identifiable {
    var id: String
    var title: String
    var desc: String
    var url: String
    var image: String
}

class GetData: ObservableObject {
    
    @Published var datas = [DataType]()
    var search: String
    var apiKey: String
    var isTopHeadline: Bool
    
    init(search: String = "apple", isTopHeadline: Bool) {
        self.search = search
        self.isTopHeadline = isTopHeadline
        self.apiKey = "&apiKey=797d006be20c453ba47eaaba66b6e003"
        
        let searchingType = isTopHeadline ? "top-headlines?q=" : "everything?q="
        let urlString = "https://newsapi.org/v2/" + searchingType + search + "&pageSize=10" + apiKey
        
        
        // Convert URL string to URL
        guard let url = URL(string: urlString) else {
            // Handle invalid URL
            print("Invalid URL")
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            
            for i in json["articles"] {
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                DispatchQueue.main.async {
                    
                    self.datas.append(DataType(id: id, title: title, desc: description, url: url, image: image))
                }
                
                
            }
        }.resume()
    }
}
