//
//  HomeViewModel.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import UIKit

class HomeViewModel {
    //MARK:  declare variable to store data
    var carousalData: [CarouselList]?
    var data: [Detail]?
    var listData: [Detail]?
    
    init() {
        readLocalFile()
    }
    
    //MARK: This method is used to read data from local json file
    private func readLocalFile() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "CarouselData", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                self.parse(jsonData: jsonData)
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: This method is used to Map data to Model object
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(CarouselData.self, from: jsonData)
            carousalData = decodedData
            if let detail = decodedData.first?.details {
                self.listData = detail
                self.data = detail
            }
        } catch {
            print("decode error")
        }
    }
    
    //Filter data according to search text entry
    func filterProduct(text: String) {
        data = text.isEmpty ? listData : listData?.filter { $0.text!.contains(text) }
    }
    
}

