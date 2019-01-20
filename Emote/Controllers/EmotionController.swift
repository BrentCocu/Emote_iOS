//
//  ViewController.swift
//  Emote
//
//  Created by Brent Cocu on 19/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import UIKit

class EmotionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var emotionList: UITableView!
	private var emotions: [Emotion] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let result = EmotionRepository.shared.getAll() {
			emotions = result
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emotions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmotionTableViewCell
		let emotion = emotions[indexPath.item]
		cell.name.text = emotion.name
		cell.color.setImageColor(color: emotion.color!)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showDetail", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? EditEmotionController {
			if let selectedRow = emotionList.indexPathForSelectedRow {
				destination.emotion = emotions[selectedRow.row]
				destination._name = emotions[selectedRow.row].name
				destination._color = emotions[selectedRow.row].color
				emotionList.deselectRow(at: selectedRow, animated: true)
			} else {
				destination._name = ""
				destination._color = UIColor(named: "blue")
			}
		}
	}
	
	@IBAction func addEmotion(_ sender: Any) {
		performSegue(withIdentifier: "showDetail", sender: self)
	}
	
	@IBAction func unwindAndUpdate(unwindsegue: UIStoryboardSegue) {
		let source = unwindsegue.source as? EditEmotionController
		
		if let name = source?.name.text, let color = source?.color.backgroundColor {
			if let emotion = source?.emotion {
				EmotionRepository.shared.update(name: name, color: color, emotion: emotion)
			} else {
				if let newEmotion = EmotionRepository.shared.insert(name: name, color: color) {
					emotions.append(newEmotion)
				}
			}
		}
		
		emotionList.reloadData()
	}
	
	@IBAction func unwindAndDelete(unwindsegue: UIStoryboardSegue) {
		let source = unwindsegue.source as? EditEmotionController
		
		if let emotion = source?.emotion {
			EmotionRepository.shared.delete(emotion: emotion)
			if let index = emotions.firstIndex(of: emotion) {
				emotions.remove(at: index)
			}
		}
		
		emotionList.reloadData()
	}
}

