//
//  QueryService.swift
//  Zennex_TestTask
//
//  Created by Боровик Василий on 15.03.2021.
//

import CoreData
import UIKit

protocol IQueryService {
	func removeLeaderAt(id: UUID)
	func fetchLeaderAt(id: UUID?) -> [Leader]?
	func addLeader(info: LeaderInfo)
}

final class QueryService {
	lazy var persistContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Zennex_TestTask")
		container.loadPersistentStores{ (storeDescription, error) in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
		return container
	}()
	
	lazy var context: NSManagedObjectContext = {
		let context  = self.persistContainer.viewContext
		return context
	}()
}

private extension QueryService {
	func saveContext() {
		if self.context.hasChanges {
			do {
				try self.context.save()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}
	}
}

// MARK: IQueryService

extension QueryService: IQueryService {
//	func fetchRequestSelectedRecipes() -> [Recipe]? {
//		var recipe = [Recipe]()
//		let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//
//		let predicate = NSPredicate(format: "isSelected == true", true as CVarArg )
//		fetchRequest.predicate = predicate
//
//		do {
//			recipe = try self.context.fetch(fetchRequest)
//		} catch {
//			assertionFailure(error.localizedDescription)
//			return nil
//		}
//
//		return recipe
//	}
//

//	func changeRecipe(content: RecipeContent) {
//		if let name = content.name,
//		   name != "",
//		   let id = content.id {
//
//			let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//			let predicate = NSPredicate(format: "id == %@", id as CVarArg )
//			fetchRequest.predicate = predicate
//
//			do {
//				let recipes = try self.context.fetch(fetchRequest)
//				recipes.first?.name = name
//				recipes.first?.definition = content.definition
//				recipes.first?.image = content.image?.pngData()
//				recipes.first?.isSelected = content.isSelected ?? false
//			} catch {
//				assertionFailure(error.localizedDescription)
//			}
//		}
//
//		self.saveContext()
//	}
//
	func removeLeaderAt(id: UUID) {
		let fetchRequest: NSFetchRequest<Leader> = Leader.fetchRequest()
		let predicate = NSPredicate(format: "id == %@", id as CVarArg )
		fetchRequest.predicate = predicate
		
		do {
			let leaders = try self.context.fetch(fetchRequest)
			for leader in leaders {
				self.context.delete(leader)
			}
		} catch {
			assertionFailure(error.localizedDescription)
		}
		
		self.saveContext()
	}
	
	func fetchLeaderAt(id: UUID?) -> [Leader]? {
		var leader = [Leader]()
		let fetchRequest: NSFetchRequest<Leader> = Leader.fetchRequest()
		
		if let id = id {
			let predicate = NSPredicate(format: "id == %@", id as CVarArg )
			fetchRequest.predicate = predicate
		}
		
		do {
			leader = try self.context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.localizedDescription)
			return nil
		}
		return leader
	}

	
	func addLeader(info: LeaderInfo) {
		guard let entity = NSEntityDescription.entity(forEntityName: "Leader", in: self.context) else {
			assertionFailure("No entity in context")
			return
		}
		
		let leader = Leader(entity: entity, insertInto: self.context)
		leader.firstname = info.firstname
		leader.middlename = info.middlename
		leader.surname = info.surname
		leader.salary = info.salary ?? 0.0
		leader.businessHours = info.businessHours
		leader.id = info.id
		
		self.saveContext()
	}
}

