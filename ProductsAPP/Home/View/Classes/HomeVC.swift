//
//  ViewController.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var connectionStatusLbl: UILabel!
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    let viewModel  = HomeViewModel()
    var products:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setUpCollctionView()
        viewModel.getProducts()
        bindData()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            handleConnectionView(isConnected:true)
            viewModel.getProducts()
        } else {
            handleConnectionView(isConnected:false)
        }
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    func handleConnectionView(isConnected:Bool) {
        UserDefaults.standard.set(isConnected, forKey: "isConnected")
        print("connection \(isConnected)")
        DispatchQueue.main.async {
            self.connectionView.backgroundColor = isConnected ? .green : .red
            self.connectionStatusLbl.text       = isConnected ? "Connected" : "Check your connection"
            self.connectionView.isHidden        = false
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                self.connectionView.isHidden    = isConnected ? true : false
            }
        }
    }
    
    func setUpCollctionView(){
        productsCollectionView.delegate   = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        if let layout = productsCollectionView?.collectionViewLayout as? PrudctsListFlowLayout {
            layout.delegate = self
        }
    }
    
    func bindData(){
        
        viewModel.isLoading.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                }else{
                    self?.loadingIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.products.bind { [weak self] produsts in
            guard let products = produsts else { return }
            self?.products.append(contentsOf: products)
            DispatchQueue.main.async {
                self?.productsCollectionView.reloadData()
            }
        }
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            DispatchQueue.main.async {
                self.showAlert(withTitle: "Error", message: message,showingOkButton: false)
            }
        }
        
        viewModel.errorType.bind { [weak self] type in
            guard let type = type else { return }
            if type == .noInternet {
                self?.viewModel.getData()
            }
        }
    }
    
    func showAlert(withTitle title: String?,
                   message: String?,
                   showingCancelButton: Bool = false,
                   showingOkButton: Bool = true,
                   cancelHandler: ((UIAlertAction) -> Void)? = nil,
                   actionTitle: String = "OK",
                   actionStyle: UIAlertAction.Style = .default,
                   actionHandler: ((UIAlertAction) -> Void)? = nil)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if showingOkButton {
            let okAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: actionHandler)
            alertController.addAction(okAction)
        }
        else
        {// auto hide
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
        if showingCancelButton {
            let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: cancelHandler)
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
