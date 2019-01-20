//
//  MomentController.swift
//  Emote
//
//  Created by Brent Cocu on 19/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import UIKit

class MomentController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var momentList: UITableView!
	private var moments: [Moment] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if let result = MomentRepository.shared.getAll() {
			moments = result
			momentList.reloadData()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return moments.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MomentTableViewCell
		let moment = moments[indexPath.item]
		cell.name.text = moment.emotion?.name
		cell.color.setImageColor(color: (moment.emotion?.color)!)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showMomentDetail", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? EditMomentController {
			if let selectedRow = momentList.indexPathForSelectedRow {
				destination.moment = moments[selectedRow.row]
				destination._content = moments[selectedRow.row].content
				destination._name = moments[selectedRow.row].emotion?.name
				destination.emotion = moments[selectedRow.row].emotion
				momentList.deselectRow(at: selectedRow, animated: true)
			} else {
				let emotion = EmotionRepository.shared.getAll()![0]
				destination._name = ""
				destination._content = ""
				destination.emotion = emotion
			}
		}
	}
	
	@IBAction func addMoment(_ sender: Any) {
		performSegue(withIdentifier: "showMomentDetail", sender: self)
	}
	
	@IBAction func unwindAndUpdate(unwindsegue: UIStoryboardSegue) {
		let source = unwindsegue.source as? EditMomentController
		
		if let emotion = source?.emotion, let content = source?._content {
			if let moment = source?.moment {
				MomentRepository.shared.update(content: content, date: moment.date! as Date, emotion: emotion, moment: moment)
			} else {
				if let newMoment = MomentRepository.shared.insert(content: content, date: Date(), emotion: emotion) {
					moments.append(newMoment)
				}
			}
		}
		
		momentList.reloadData()
	}
	
	@IBAction func unwindAndDelete(unwindsegue: UIStoryboardSegue) {
		let source = unwindsegue.source as? EditMomentController
		
		if let moment = source?.moment {
			MomentRepository.shared.delete(moment: moment)
			if let index = moments.firstIndex(of: moment) {
				moments.remove(at: index)
			}
		}
		
		momentList.reloadData()
	}
}
