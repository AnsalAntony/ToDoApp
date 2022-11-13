//
//  ToDoListTableViewCell.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 11/11/22.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    @IBOutlet weak var alaramStatusView: UIView!
    @IBOutlet weak var weeklyStatusView: UIView!
    @IBOutlet weak var dailyStatusView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateHoldingStackView: UIStackView!
    @IBOutlet weak var contentHoldingView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alaramStatusView.layer.cornerRadius = alaramStatusView.frame.size.height/2
        alaramStatusView.layer.masksToBounds = true
        alaramStatusView.backgroundColor = UIColor.green
        weeklyStatusView.layer.cornerRadius = weeklyStatusView.frame.size.height/2
        weeklyStatusView.layer.masksToBounds = true
        dailyStatusView.layer.cornerRadius = dailyStatusView.frame.size.height/2
        dailyStatusView.layer.masksToBounds = true
        dailyStatusView.backgroundColor = UIColor.green
        
        contentHoldingView.layer.cornerRadius = 10
        contentHoldingView.layer.masksToBounds = true
        dateHoldingStackView.layer.cornerRadius = 5
        dateHoldingStackView.layer.masksToBounds = true
        contentHoldingView.setBackgroundShadow(setColor: UIColor.lightGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureProductCell(todo: ToDoModel) {
        
        titleLabel.text = todo.title
        descriptionLabel.text = todo.toDoDescription
        var dateTime = ""
        if let time = todo.time{
            let timeFormated = Formaters.shared.convertDateStringToDate(dateValue: time, formate: Constants.formateDateTime)
            let formatedTime = Formaters.shared.formateDateTime(dateTime: timeFormated, formate: Constants.formateTodoTime)
            dateTime = formatedTime
        }
        if let date = todo.date{
            let dateFormated = Formaters.shared.convertDateStringToDate(dateValue: date, formate: Constants.formateDateTime)
            let formatedDate = Formaters.shared.formateDateTime(dateTime: dateFormated, formate: Constants.formateTodoDate)
            dateTime = dateTime + ", " + formatedDate
        }
        dateTimeLabel.text = dateTime
        weeklyStatusView.backgroundColor = UIColor.lightGray
        dailyStatusView.backgroundColor = UIColor.lightGray
        alaramStatusView.backgroundColor = UIColor.lightGray
        if(todo.weekly){
            weeklyStatusView.backgroundColor = UIColor.green
        }
        if(todo.daily){
            dailyStatusView.backgroundColor = UIColor.green
        }
        if(todo.alaram){
            alaramStatusView.backgroundColor = UIColor.green
        }
    }

}
