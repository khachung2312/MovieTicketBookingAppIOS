//
//  MovieCSCollectionViewCell.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 14/08/2023.
//

import UIKit
import CollectionViewPagingLayout

class MovieCSCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieComingSoonPoster: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let posterFrame = CGRect(
            x: contentView.bounds.midX - (frame.width / 2),
            y: contentView.bounds.midY - (frame.height / 2),
            width: frame.width,
            height: frame.height
        )
        movieComingSoonPoster = UIImageView(frame: posterFrame)
        contentView.addSubview(movieComingSoonPoster)
    }
}

extension MovieCSCollectionViewCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.linear)
    }
}


