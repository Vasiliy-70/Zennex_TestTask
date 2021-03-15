//
//  ListPresenter.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import Foundation

protocol IListPresenter: class {
//	Протокол для обращения в качестве сущности Presenter(MVP)
	var leaderList: [LeaderInfo] { get }
	func viewDidLoad()
}

final class ListPresenter {
	private weak var view: IListView?
//	private var coordinateController:
	private var queryModel: IQueryService?
	private var leadersInfo = [LeaderInfo]()
	private var leaderRawData = [Leader]() {
		didSet {
			self.leadersInfo.removeAll()
			for item in self.leaderRawData {
				self.leadersInfo.append(LeaderInfo(id: item.id,
												   firstname: item.firstname,
												   middlename: item.middlename,
												   surname: item.surname,
												   salary: item.salary,
												   businessHours: item.businessHours))
			}
		}
	}
	
	init(view: IListView, queryModel: IQueryService) {
		self.view = view
		self.queryModel = queryModel
	}
}

private extension ListPresenter {
	func addNewLeader() {
		let leader = LeaderInfo(id: UUID(), firstname: "firstname", middlename: "middlename", surname: "surname", salary: 60.000, businessHours: "14:00-15:00")
		self.queryModel?.addLeader(info: leader)
	}
	
	func requestData() {
		self.leaderRawData = self.queryModel?.fetchLeaderAt(id: nil) ?? []
		self.view?.updateView()
	}
}

// MARK: IListPresenter

extension ListPresenter: IListPresenter {
	func viewDidLoad() {
		self.requestData()
	}
	
	var leaderList: [LeaderInfo] {
		self.leadersInfo
	}
}
