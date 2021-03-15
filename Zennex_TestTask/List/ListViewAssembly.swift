//
//  ListViewAssembly.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import UIKit

enum ListViewAssembly {
	static func createListViewModule() -> UIViewController {
		let view = ListViewController()
		let queryService = QueryService()
		
		let presenter = ListPresenter(view: view, queryModel: queryService)
		view.presenter = presenter
		return view
	}
}
