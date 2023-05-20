The TabStudentsController class is a controller for working with the interface for interacting with objects of the Student type.

Methods of the class:

1. initialize(view) - constructor of the class, takes a view object and creates an empty object of the type
DataListStudentShort, which is assigned the add_listener method with the view argument, as a result of which the view
is set as a listener for data state change events (data_list).
2. on_view_created is a method that initializes an object of the StudentRepository type, which is used for interaction
with the database, and if an error occurs connecting to the database displays a dialog box with an error message.
3. show_view is a method that displays the main application window.
4. show_modal_add is a method that displays a modal window for creating a new student record.
Creates an instance of the StudentInputFormControllerCreate controller and passes it a reference to the current controller,
creates an object of the StudentInputForm type and passes it a reference to the controller. Then it displays the modal window.
5. show_modal_edit(current_page, per_page, selected_row) is a method that displays the modal window for
editing a student record. Takes the values of the current page (current_page), the number of records on the page
(per_page) and the selected row (selected_row). Calculates the number of the selected student and selects his id from
the DataListStudentShort object, then passes it to the StudentInputFormControllerEdit controller, creates an object of the type
StudentInputForm and passes it a link to the controller. After that, it displays a modal window.
6. delete_selected(current_page, per_page, selected_row) is a method that deletes the selected student record.
Takes the values of the current page (current_page), the number of records on the page (per_page)
and the selected row (selected_row). Calculates the number of the selected student and selects his id from the DataListStudentShort object,
then deletes the record using the remove_student method from the StudentRepository object.
7. refresh_data(page, per_page) is a method that updates the data in the list of students. Takes the values
of the current page (page) and the number of entries on the page (per_page).
Calls a method of the StudentRepository paginated_short_students type to get data in the DataListStudentShort object format.
Updates information about the number of students using the update_student_count method of the view.

The Student_Input_Form_Controller_Edit controller and Student_Input_Form_Controller_Create are forms
for modifying and creating students into the database, respectively.

The student, student_base and student_short models are a student model with various fields and methods
for setting, receiving and processing information. Student_base - super class,
and student_short is the short information about the student.