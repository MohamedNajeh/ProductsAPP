//
//  viewController+CollectionDelegate.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation
import UIKit

extension HomeVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configureCell(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = currentStoryboard(.Details).instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.product = products[indexPath.row]
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == products.count - 1 {
            viewModel.getProducts()
        }
    }
}

extension HomeVC: ProductsListLayoutDelegate {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> Int {
          return products[indexPath.row].image?.height ?? 0
  }
}
