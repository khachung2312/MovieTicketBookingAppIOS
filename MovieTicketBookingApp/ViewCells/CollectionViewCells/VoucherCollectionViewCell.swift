//
//  VoucherCollectionViewCell.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 19/08/2023.
//

import UIKit

class VoucherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleVoucher: UILabel!
    @IBOutlet weak var imgVoucher: UIImageView!
    @IBOutlet weak var viewVoucher: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewVoucher.layer.cornerRadius = 40
        imgVoucher.layer.cornerRadius = 20
    }

}
