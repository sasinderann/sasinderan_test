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
    }
    
    func setUpTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HoldingCell.self, forCellReuseIdentifier: "HoldingCell")
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userHoldings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCell",for: indexPath) as? HoldingCell,
            let holdings = viewModel?.userHoldings {
            cell.configure(with: holdings[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
