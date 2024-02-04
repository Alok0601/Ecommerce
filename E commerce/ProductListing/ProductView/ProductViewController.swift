//
//  ViewController.swift
//  E commerce
//
//  Created by Alok Ranjan on 02/02/24.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProductViewModel?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congigureNavigationBar()
        configureTable()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = ProductViewModel()
        viewModel?.products.bind(listener: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        viewModel?.isAnimated.bind(listener: { [weak self] isAnimating in
            if let isAnimating, isAnimating {
                DispatchQueue.main.async {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                    self?.isLoading = true
                }
            } else{
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.isLoading = false
                }
            }
        })
        viewModel?.productWebService(with: "", sortBy: "")
    }
    
    func congigureNavigationBar() {
        addSearchBar()
        addCartAndWishListIcon()
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    func addSearchBar() {
        lazy var searchBar: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 250, 20))
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
    }
    
    func addCartAndWishListIcon() {
        var cart = UIImage(systemName: "cart")
        cart = cart?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: cart, style:.plain, target: self, action: #selector(onClickCartButton))
        let filterButton = UIBarButtonItem(title: "SortBy", style:.plain, target: self, action: #selector(onClickfilterButton))
        self.navigationItem.rightBarButtonItems = [button, filterButton]
    }
    
    // MARK: - UISearchBarDelegate

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchText = searchBar.text else { return }
            searchBar.resignFirstResponder()
            viewModel?.productWebService(with: searchText, sortBy: "")
        }

    
    @objc func onClickfilterButton() {
        let secondStoryboard = UIStoryboard(name: "SortByStoryboard", bundle: nil)
        let secondViewController = secondStoryboard.instantiateViewController(withIdentifier: "SortByViewController") as! SortByViewController
        secondViewController.delegate = self
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @objc func onClickCartButton() {
        print("Message")
    }
    
}


extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.products.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let data = viewModel?.products.value?[indexPath.row] {
            cell.configure(data: data)
        }
       
        return cell
    }
}


extension ProductViewController: SortByProtocol {
    func didSelectSortByOption(data: SortBYData) {
        viewModel?.sortBYTapped(data: data)
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
