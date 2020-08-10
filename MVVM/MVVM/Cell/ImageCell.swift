//
//  ImageCell.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import Kingfisher

final class ImageCell: UITableViewCell {
    @IBOutlet private weak var thumImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumImageView.image = nil
    }
    
    func set(url: URL?) {
        guard let url = url else {
            thumImageView.image = nil
            return
        }
        
        thumImageView.kf.setImage(with: .network(url))
    }
}
