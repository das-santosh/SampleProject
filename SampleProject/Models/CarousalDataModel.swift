//
//  CarousalDataModel.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import Foundation

// MARK: - CarouselDatum
class CarouselList: Codable {
    let headerImage: String?
    let details: [Detail]?

    init(headerImage: String, details: [Detail]) {
        self.headerImage = headerImage
        self.details = details
    }
}

// MARK: - Detail
class Detail: Codable {
    let img, text: String?

    init(img: String, text: String) {
        self.img = img
        self.text = text
    }
}

typealias CarouselData = [CarouselList]

