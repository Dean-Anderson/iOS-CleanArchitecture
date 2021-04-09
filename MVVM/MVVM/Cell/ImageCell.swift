//
//  ImageCell.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import Kingfisher

protocol ImageCellDrawable {
    var imageURL: URL? { get }
}

protocol ImageCellInteractable {
    var linkURL: URL? { get }
}

protocol ImageCellCreatable: ImageCellDrawable, ImageCellInteractable {}

final class ImageCell: UITableViewCell {
    @IBOutlet private weak var thumImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumImageView.image = nil
    }
    
    
    func bind(drawable: ImageCellDrawable) {
        guard let url = drawable.imageURL else {
            thumImageView.image = nil
            return
        }
        
        thumImageView.kf.setImage(with: .network(url))
    }
}

extension ImagePack: ImageCellCreatable {
    var imageURL: URL? { URL(string: thumbnailLink) }
    var linkURL: URL? { URL(string: link) }
}
