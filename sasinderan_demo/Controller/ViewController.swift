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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitiateViewModel()
        setUpTableView()
    }
    
    func InitiateViewModel() {
        let apiClient = APIClient()
        let service = PortFolioRequestService(APIClient: apiClient)
        self.viewModel = PortfolioPageViewModel(APIService: service)
        self.viewModel?.delegate = self
        self.viewModel?.fetchUserHoldings()
        tableView.allowsSelection = false
    }
    
    func setUpTableView() {
        self.view.addSubview(tableView)
        self.view.addSubview(investmentConsolidateView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        investmentConsolidateView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HoldingCell.self, forCellReuseIdentifier: "HoldingCell")
        tableView.dataSource = self
        
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
    
    func reloadData() {
        self.tableView.reloadData()
        if let consolidate = self.viewModel?.userHoldings.getInvestmentConsolidate() {
            investmentConsolidateView.updateValues(from: consolidate)
        }
    }
}
