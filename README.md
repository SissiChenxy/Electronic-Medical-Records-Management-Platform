# Electronic-Medical-Records-Management-Platform
The final project of INFO6250 Web Development Tools &amp; Methods

I.	Introduction

I built a communication platform between doctors and patients to help them send and reply messages, request and confirm appointments, write recipes with test conducted and prescriptions assigned, manage patients, retrieve medical histories and update basic contact information and password.

II.	Functionality

1.	Send Message
“From” part can automatically insert the current user’s username, and “To” part is patients lists or doctor lists corresponding to the role of current user. You can add sentences and change their styles in “Content” part, you also can upload attached files. 

2.	Reply and delete in message inbox
The reply page has “From”, “To”, “Subject” settled, “Request Content” hint and editable “Content” part
  
3.	Manage Appointments
You can confirm or cancel this appointment, or change the date or time of this appointment
 
4.	Request Appointment
“To” part will show patient lists or doctor lists corresponding to the role of current user, you can select preferred data and time range.

5.	Manage Appointments
    There is a remind symbol on nav bar which shoes how many appointments you haven’t processed, and the right part shows all the appointments, you can confirm or cancel or edit the appointment time before this appointment is confirmed
 
6.	Write Recipes 
Write recipe on each confirmed appointment
You can add many test and prescription in the recipe
 
7.	Manage Patients and retrieve their medical records
  
8.	Manage Recipes and retrieve each recipe’s details
  
9.	Request to add prescription
If you don’t have prescription and you want more, you can send a request to doctor to get more prescription
 
10.	Change password
You need to input the right old password and make the new password and re-enter match
 
11.	Update basic contact information
  
III.	Technologies

1.	Ajax

(1)	Check the usability of username when register, and give the feedback
   
(2)	Update patients list of one doctor using ajax, to get the lasted recipe records of the patients and easy to look up for the doctor
   
(3)	Use Ajax while the doctor inputting medicine name, there will be a hint for getting the correct medicine name in an easier and faster way
 
 
2.	JavaScript & JQuery

(1)	In the page of change password, use javascript to check whether the re-enter new password is same as new password
 
(2)	In the page of “recipe-edit”, use JQuery to realize that one more test / prescription part will be added after clicking the green add button 
 
(3)	In the nav bar, use ajax to get the number of unprocessed appointments and show in the green square to remind user
  

3.	Interceptor

Prevent unlogged user to get into the business logics pages, check whether if the user has been logged and saved in session, if not, redirect to login page

 
4.	Filter

    Use filter to delete the characters which you want to discard, try to protect the security of data in database in case of Injection Problem
 

IV.	Roles Defination

1.	Patient
(1)	Send or reply message 
(2)	View or delete message
(3)	Request appointment
(4)	View, confirm or cancel appointment
(5)	Change appointment date and time
(6)	Retrieve recipe records and details
(7)	Ask for more prescription
(8)	Change password 
(9)	Update basic contact information

2.	Doctor
(1)	Send or reply message 
(2)	View or delete message
(3)	Request appointment
(4)	View, confirm or cancel appointment
(5)	Change appointment date and time
(6)	Manage Patients who has confirmed appointments
(7)	Write recipes (tests and prescriptions) on each appointment
(8)	Change password 
(9)	Update basic contact information

