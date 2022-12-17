//
//  DetailsVC.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var product:Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        productImgView.downloadImg(from: product?.image?.url ?? "")
        priceLbl.text = "\(product?.price ?? 0)$"
        descriptionLbl.text = product?.productDescription
        imgHeightConstraint.constant = CGFloat(product?.image?.height ?? 250)
    }
}
