//
//  ListView.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import UIKit

protocol IListViewType: class {
//	Протокол, реализующий интерфейс UIView
	var tableView: UITableView { get }
}

class ListView: UIView {
	private var viewController: IListViewController
	private var table = UITableView()
	
	private enum Constraints {
		static let tableHorizontalOffset: CGFloat = 10
		static let tableVerticalOffset: CGFloat = 10
	}
	
	init(viewController: IListViewController) {
		self.viewController = viewController
		super.init(frame: .zero)
		
		self.setupView()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension ListView {
	func setupView() {
		self.backgroundColor = .white
		self.setupTable()
	}
	
	func setupTable() {
		self.table.register(ListTableViewCell.self, forCellReuseIdentifier: self.viewController.cellIdentifier)
		self.table.delegate = self.viewController as? UITableViewDelegate
		self.table.dataSource = self.viewController as? UITableViewDataSource
	}
}

private extension ListView {
	func setupConstraints() {
		self.setupTableConstraints()
	}
	
	func setupTableConstraints() {
		self.addSubview(self.table)
		self.table.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.table.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.tableVerticalOffset),
			self.table.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.tableHorizontalOffset),
			self.table.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.tableHorizontalOffset),
			self.table.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.tableVerticalOffset)
		])
	}
}

// MARK: IListViewType

extension ListView: IListViewType {
	var tableView: UITableView {
		self.table
	}
}
