//
//  CarousalDetailsCell.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import UIKit

class CarousalDetailsCell: UITableViewCell {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImageView.layer.borderColor = UIColor.gray.cgColor
        headerImageView.layer.borderWidth = 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureData(_ listObject: Detail) {
        headerImageView.image = UIImage(named: listObject.img ?? "")
        titleLabel.text = listObject.text
    }
}
