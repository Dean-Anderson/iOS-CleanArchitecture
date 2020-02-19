//
//  ImageCell.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage

final class ImageCell: UITableViewCell {
    @IBOutlet fileprivate weak var thumImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumImageView.image = nil
    }
    
    func set(url: URL?) {
        thumImageView.sd_setImage(with: url, completed: nil)
    }
}
