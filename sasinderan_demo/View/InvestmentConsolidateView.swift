//
//  InvestmentConsolidateView.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 23/12/25.
//

import Foundation
import UIKit

class InvestmentConsolidateView: UIView {
    
    let currentValueLabel = UILabel()
    let totalInvestmentLabel = UILabel()
    let todayPNLLabel = UILabel()
    let totalPNLLabel = UILabel()
    
    var currentValueRow: UIView!
    var totalInvestmentRow: UIView!
    var todayPNLRow: UIView!
    var dropDownRow: UIView!
    
    var isExpanded = false
    let dropDownLblTag = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setupUI() {
        
        currentValueRow = createLbl(title: "Current value*", valueLabel: currentValueLabel)
        totalInvestmentRow = createLbl(title: "Total investment*", valueLabel: totalInvestmentLabel)
        todayPNLRow = createLbl(title: "Today's Profit & Loss*", valueLabel: todayPNLLabel)
        dropDownRow = createLbl(title: "Profit & Loss* ▾", valueLabel: totalPNLLabel, tag: dropDownLblTag)
        
        currentValueRow.isHidden = true
        totalInvestmentRow.isHidden = true
        todayPNLRow.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expandDropDown))
        dropDownRow.isUserInteractionEnabled = true
        dropDownRow.addGestureRecognizer(tapGesture)
        self.layer.cornerRadius = 8
        
        let stack = UIStackView(arrangedSubviews: [
            currentValueRow,
            totalInvestmentRow,
            todayPNLRow,
            dropDownRow
        ])
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func createLbl(title: String, valueLabel: UILabel, tag: Int = 0) -> UIView {
        let titleLabel = UILabel()
        titleLabel.tag = tag
        titleLabel.text = title
        valueLabel.textAlignment = .right
        valueLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }
    
    @objc func expandDropDown() {
        isExpanded.toggle()
        UIView.animate(withDuration: 0.25) {
            self.currentValueRow.isHidden = !self.isExpanded
            self.totalInvestmentRow.isHidden = !self.isExpanded
            self.todayPNLRow.isHidden = !self.isExpanded
            let arrow = self.isExpanded ? "▴" : "▾"
            if let lbl = (self.dropDownRow as? UIStackView)?.arrangedSubviews.compactMap({$0.tag == self.dropDownLblTag ? $0 as? UILabel: nil}).first {
//                print("===FOUND ===")
                lbl.text = "Profit & Loss* \(arrow)"
            }
            self.layoutIfNeeded()
        }
    }
    
    func updateValues(from consolidate: InvestmentConsolidate) {
        self.currentValueLabel.text = String(format: "%.2f", consolidate.currentValue)
        self.totalInvestmentLabel.text = String(format: "%.2f", consolidate.totalInvestment)
        self.totalPNLLabel.text = String(format: "%.2f", consolidate.totalPnL)
        self.todayPNLLabel.text = String(format: "%.2f", consolidate.todayPnL)
        
        totalPNLLabel.textColor = consolidate.totalPnL >= 0 ? .systemGreen : .systemRed
        todayPNLLabel.textColor = consolidate.todayPnL >= 0 ? .systemGreen : .systemRed
    }
}
