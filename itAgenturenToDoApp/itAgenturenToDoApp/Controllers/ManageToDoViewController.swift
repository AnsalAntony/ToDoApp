//
//  ManageToDoViewController.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 10/11/22.
//

import UIKit
import UserNotifications

protocol ManageToDoViewControllerDelegate: AnyObject {
    func saveTodoItems(message: String)
}

class ManageToDoViewController: UIViewController {
    weak var delegate: ManageToDoViewControllerDelegate?
    
    @IBOutlet weak var deleteBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var alarmSelectionView: UIView!
    @IBOutlet weak var weeklySelectionView: UIView!
    @IBOutlet weak var dailySelectionView: UIView!
    @IBOutlet weak var optionsHoldingStackView: UIStackView!
    @IBOutlet weak var dateTimeHoldingStackView: UIStackView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTetField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var descriptionHoldingView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleHoldingView: UIView!
    @IBOutlet weak var toDoTitleLable: UILabel!
    @IBOutlet weak var toDoHoldingView: UIView!
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    private var dailySet = false
    private var weeklySet = false
    private var alaramSet = false
    private var selectedDate = ""
    private var selectedtime = ""
    var todoItem = ToDoModel()
    private var isEdit = false
    private let manageViewModel = ManageToDoViewModel()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    
    static func make() -> ManageToDoViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.storyboardId.manageToDoViewController) as! ManageToDoViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted){
                print("Permission Denied")
            }
        }
        
        setupUi()
        createDatePicker()
        createTimePicker()
        deleteBtn.isHidden = true
        deleteBtnHeightConstraint.constant = 5
        if(todoItem.title != nil){
            isEdit = true
            setEditUi()
            deleteBtn.isHidden = false
            deleteBtnHeightConstraint.constant = 45
            toDoTitleLable.text = "Edit ToDo"
        }
    }
    
    private func setEditUi(){
        titleTextField.text = todoItem.title
        
        DescriptionTextView.text = todoItem.toDoDescription
        if let time = todoItem.time{
            let convertedTime = Formaters.shared.convertDateStringToDate(dateValue: time, formate: Constants.formateDateTime)
            timeTetField.text = Formaters.shared.formateDateTime(dateTime: convertedTime, formate: Constants.formateTodoTime)
            selectedtime = todoItem.time ?? ""
        }
        if let date = todoItem.date{
            let convertedDate = Formaters.shared.convertDateStringToDate(dateValue: date, formate: Constants.formateDateTime)
            dateTextField.text = Formaters.shared.formateDateTime(dateTime: convertedDate, formate: Constants.formateTodoDate)
            selectedDate = todoItem.date ?? ""
        }
        if(todoItem.daily){
            dailySelectionView.isHidden = false
            dailySet = true
        }
        if(todoItem.weekly){
            weeklySelectionView.isHidden = false
            weeklySet = true
        }
        if(todoItem.alaram){
            alarmSelectionView.isHidden = false
            alaramSet = true
        }
        
    }
    
    private func setupUi(){
        
        deleteBtn.layer.cornerRadius = 7
        deleteBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 7
        saveBtn.layer.masksToBounds = true
        optionsHoldingStackView.layer.cornerRadius = 7
        optionsHoldingStackView.layer.masksToBounds = true
        titleHoldingView.layer.cornerRadius = 7
        titleHoldingView.layer.masksToBounds = true
        descriptionHoldingView.layer.cornerRadius = 7
        descriptionHoldingView.layer.masksToBounds = true
        dateTimeHoldingStackView.layer.cornerRadius = 7
        dateTimeHoldingStackView.layer.masksToBounds = true
        toDoHoldingView.layer.cornerRadius = 15
        toDoHoldingView.layer.masksToBounds = true
        toDoHoldingView.setBackgroundShadow(setColor: UIColor.lightGray)
        DescriptionTextView.setTextViewPlaceholder(placeHolderText:"Description")
    }
    
    private func createDatePicker(){
        
        datePicker.frame.size = CGSize(width: 0, height: 150)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        let toolBarDatePicker = UIToolbar()
        toolBarDatePicker.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateSelected))
        toolBarDatePicker.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolBarDatePicker
        dateTextField.inputView = datePicker
    }
    
    @objc func dateSelected() {
        dateTextField.text = Formaters.shared.formateDateTime(dateTime: datePicker.date, formate: Constants.formateTodoDate)
        selectedDate = "\(datePicker.date)"
        self.view.endEditing(true)
        upendDateTime()
    }
    
    private func createTimePicker(){
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        let toolBarDatePicker = UIToolbar()
        toolBarDatePicker.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeSelected))
        toolBarDatePicker.setItems([doneButton], animated: true)
        timeTetField.inputAccessoryView = toolBarDatePicker
        timeTetField.inputView = timePicker
    }
    
    @objc func timeSelected() {
        timeTetField.text = Formaters.shared.formateDateTime(dateTime: timePicker.date, formate: Constants.formateTodoTime)
        selectedtime = "\(timePicker.date)"
        self.view.endEditing(true)
        upendDateTime()
    }
    
    private func upendDateTime(){
        if (selectedtime != ""){
            let taketime = Formaters.shared.formateDateTime(dateTime: timePicker.date, formate: Constants.timeFormate)
            if(selectedDate != ""){
                let takeDate = Formaters.shared.formateDateTime(dateTime: datePicker.date, formate: Constants.dateFormate)

                selectedtime = takeDate + " " + taketime
            }
        }

    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        manageViewModel.deleteTodoItems(todoItem: todoItem) { success, message in
            self.dismiss(animated: true, completion: nil)
            delegate?.saveTodoItems(message: message)
        }
    }
    
    @IBAction func saveClciked(_ sender: Any) {
        manageViewModel.saveTodoItems(oldTodo: todoItem, editTodo: isEdit, title: titleTextField.text ?? "", descrtpition: DescriptionTextView.text ?? "", time:selectedtime, date:selectedDate, dailly: dailySet, weekly: weeklySet, alaram: alaramSet) { success, message in
            if(success){
                self.dismiss(animated: true, completion: nil)
                delegate?.saveTodoItems(message: message)
            }else{
                alertPresent(title: "", message: message)
            }
        }
    }
    @IBAction func setAlarmClicked(_ sender: Any) {
        if(alarmSelectionView.isHidden){
            alaramSet = true
            alarmSelectionView.isHidden = false
        }else{
            alaramSet = false
            alarmSelectionView.isHidden = true
        }
    }
    @IBAction func WeeklyClicked(_ sender: Any) {
        checkNotficationPermission { [self] success in
            if success {
                DispatchQueue.main.async{
                dailySelectionView.isHidden = true
                weeklySet = true
                dailySet = false
                weeklySelectionView.isHidden = false
                }
                    
            }
        }
        
    }
    @IBAction func daillyClicked(_ sender: Any) {
        checkNotficationPermission { [self] success in
            if success {
                DispatchQueue.main.async{
                weeklySelectionView.isHidden = true
                dailySet = true
                weeklySet = false
                dailySelectionView.isHidden = false
                }
            }
        }
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkNotficationPermission(completion: @escaping (Bool) -> ())  {
        notificationCenter.getNotificationSettings {(settings) in
            DispatchQueue.main.async{
                if(settings.authorizationStatus != .authorized){
                    let ac = UIAlertController(title: Constants.enableNotifications, message: Constants.notificationEnableDec, preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default){ (_) in
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
                        else{
                            return
                        }
                        if(UIApplication.shared.canOpenURL(setttingsURL)){
                            UIApplication.shared.open(setttingsURL) { (_) in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
    
}
extension ManageToDoViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        DescriptionTextView.checkTextViewPlaceholder()
    }
}
