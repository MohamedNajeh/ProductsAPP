//
//  ProductCell.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func configureCell(product:Product){
        self.productDescription.text = product.productDescription
        self.productPrice.text       = "\(product.price ?? 0)$"
        self.productImgView.downloadImg(from: product.image?.url ?? "")
    }
}
