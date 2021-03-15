//
//  ListViewController.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import UIKit

protocol IListView: class {
//	Протокол для обращения в качестве сущности View(MVP)
	func updateView()
}

protocol IListViewController: class {
//	Протокол для обращения в качестве UIViewController
	var cellIdentifier: String { get }
}

final class ListViewController: UIViewController {
	var presenter: IListPresenter?
	private var customView: IListViewType?
	
	private var cellId = "ListCellId"
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.customView = ListView(viewController: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.presenter?.viewDidLoad()
    }
	
	override func loadView() {
		self.view = self.customView as? UIView
	}
}

extension ListViewController: UITableViewDelegate {
	
}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.presenter?.leaderList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? ListTableViewCell else {
			assertionFailure("No tableCellView")
			return UITableViewCell()
		}
		
		if let content = self.presenter?.leaderList[indexPath.row] {
			cell.avatar = UIImage(named: "avatarDefault")
//			cell.name = content.firstname ?? "" + " " + content.middlename ?? "" + " " + content.surname ?? ""
			cell.info = """
						Зарплата: \(String(describing: content.salary)) + \n + Часы приёма: \(content.businessHours ?? "")
						"""
		}
	
		return cell
	}
}

// MARK: IListView

extension ListViewController: IListView {
	func updateView() {
		self.customView?.tableView.reloadData()
	}
}

// MARK: IListViewController

extension ListViewController: IListViewController {
	var cellIdentifier: String {
		self.cellId
	}
}
