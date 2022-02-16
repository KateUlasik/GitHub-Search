//
//  GitItemCollectionViewCell.swift
//  GitHub Search
//
//  Created by Katerina Ulasik on 15.02.2022.
//

import UIKit

class GitItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pathLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(item: GitResponseItems) {
        nameLabel.text = item.name
        pathLabel.text = item.path
        urlLabel.text = item.url
    }
    
}
