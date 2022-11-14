# ToDoApp

ToDo App Test
Components to be used:-
	•	Use Swift
	•	Storyboard
	•	Realm database
	•	MVVM Architecture
	•	Multi threading
	•	Apple push notification
	•	Error Handling, Unit testing, Test cases,

1. Login screen
Email (Email validation)
Password
[LOGIN] button
POST :-  https://reqres.in/api/login
Request Body (application/json): {"email": "eve.holt@reqres.in","password": "cityslicka" }
Response :  {"token": "QpwL5tke4Pnpja7X4" }
2. Home Screen
List of Added ToDos (Fetch it from local Database)
Users can Delete Todo by clicking the list item.
Create ToDo (+) Button
Create / Update ToDo Screen (Save it to local Database)
Title*
Description
Time (HH:mm)*
Date (dd/MM/yyyy)
Types: ◉ Daily and ◉ Weekly *
CREATE button
Set Alarm of each and every ToDos created. (If Possible)
1. Display Local push notification. (contains Title, Description, DataTime)
For Ex:
If 1st ToDo is created at 4:00 PM for type Daily then the app will notify daily at 4:00 PM.
If 2nd ToDo is created at 5:00 AM, 28 May 2021 for type Weekly then the app will notify weekly at 5:00 PM starts from the selected date.
Notes: Maintain Proper Project Structure, Coding standards, naming conventions, and validations
