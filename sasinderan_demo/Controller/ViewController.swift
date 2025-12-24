//
//  ViewController.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import UIKit

class ViewController: UIViewController, PortfolioPageDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var viewModel : PortfolioPageViewModel?
    let investmentConsolidateView = InvestmentConsolidateView()
    var activityIndicator = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateViewModel()
        setUpView()
        setUpRefreshControl()
    }
    
    func initiateViewModel() {
        let apiClient = APIClient()
        let userdefaultCache = UserdefaultCaching(defaults: .standard, cacheKey: "user_holdings")
        let service = PortFolioRequestService(APIClient: apiClient, cache: userdefaultCache)
        self.viewModel = PortfolioPageViewModel(APIService: service)
        self.viewModel?.delegate = self
        refreshData()
    }
    
    func setUpView() {
        self.view.addSubview(tableView)
        self.view.addSubview(investmentConsolidateView)
        self.view.addSubview(activityIndicator)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        investmentConsolidateView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HoldingCell.self, forCellReuseIdentifier: "HoldingCell")
        tableView.dataSource = self
        tableView.allowsSelection = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .lightGray
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            investmentConsolidateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            investmentConsolidateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            investmentConsolidateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        investmentConsolidateView.isHidden = true
    }
    
    func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .lightGray
        tableView.refreshControl = refreshControl
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userHoldings.userHolding?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCell",for: indexPath) as? HoldingCell,
           let holdings = viewModel?.userHoldings.userHolding {
            cell.configure(with: holdings[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    @MainActor
    func reloadData() {
        self.tableView.reloadData()
        if let consolidate = self.viewModel?.userHoldings.getTotalInvestmentConsolidate() {
            activityIndicator.stopAnimating()
            investmentConsolidateView.isHidden = false
            investmentConsolidateView.updateValues(from: consolidate)
        }
    }
    
    @objc func refreshData() {
        self.viewModel?.fetchUserHoldings() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                if self?.refreshControl.isRefreshing ?? false {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}
