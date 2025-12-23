//
//  HoldingCell.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 23/12/25.
//

import Foundation
import UIKit

class HoldingCell: UITableViewCell {

    let entityName = UILabel()
    let netQuantity = UILabel()
    let ltpLabel = UILabel()
    let profitAndLoss = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        entityName.font = .boldSystemFont(ofSize: 16)
        netQuantity.font = .systemFont(ofSize: 13)
        netQuantity.textColor = .secondaryLabel

        ltpLabel.font = .systemFont(ofSize: 14)
        profitAndLoss.font = .systemFont(ofSize: 14)

        let leftStack = UIStackView(arrangedSubviews: [entityName, netQuantity])
        leftStack.axis = .vertical
        leftStack.spacing = 4

        let rightStack = UIStackView(arrangedSubviews: [ltpLabel, profitAndLoss])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.spacing = 4

        let mainStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.distribution = .equalSpacing
        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with holding: IndividualHolding) {
        entityName.text = holding.symbol
        netQuantity.text = "NET QTY: \(holding.quantity.zeroUnWrapped)"
        ltpLabel.text = "LTP: ₹\(holding.ltp.zeroUnWrapped)"
        let currentValue = holding.getCurrentValue()
        profitAndLoss.text = "P&L: ₹\(currentValue)"
        profitAndLoss.textColor = currentValue >= 0 ? .systemGreen : .systemRed
    }
}
