from flask import Blueprint, request, jsonify
from models import db, EmpInfo, EmpContact, EmpAgeInfo, EmpStatus

employee_blueprint = Blueprint('employee', __name__)

@employee_blueprint.route('/employees', methods=['GET'])
def get_employees():
    employees = EmpInfo.query.all()
    return jsonify([employee.to_dict() for employee in employees])

@employee_blueprint.route('/employee', methods=['POST'])
def add_employee():
    data = request.get_json()
    new_employee = EmpInfo(Emp_Ref=data['Emp_Ref'], Name=data['Name'], Gender=data['Gender'], Address=data['Address'], Branch_Code=data['Branch_Code'])
    db.session.add(new_employee)
    db.session.commit()
    return jsonify(new_employee.to_dict())

@employee_blueprint.route('/employee/contact', methods=['POST'])
def add_employee_contact():
    data = request.get_json()
    new_contact = EmpContact(Emp_Ref=data['Emp_Ref'], Contact=data['Contact'])
    db.session.add(new_contact)
    db.session.commit()
    return jsonify(new_contact.to_dict())

@employee_blueprint.route('/employee/age', methods=['POST'])
def add_employee_age():
    data = request.get_json()
    new_age_info = EmpAgeInfo(Emp_Ref=data['Emp_Ref'], DOB=data['DOB'], Age=data['Age'])
    db.session.add(new_age_info)
    db.session.commit()
    return jsonify(new_age_info.to_dict())

@employee_blueprint.route('/employee/status', methods=['POST'])
def add_employee_status():
    data = request.get_json()
    new_status = EmpStatus(Emp_Ref=data['Emp_Ref'], Position=data['Position'], Salary=data['Salary'])
    db.session.add(new_status)
    db.session.commit()
    return jsonify(new_status.to_dict())

# Helper methods to_dict to convert SQLAlchemy objects to dictionaries
def emp_to_dict(emp):
    return {
        'Emp_Ref': emp.Emp_Ref,
        'Name': emp.Name,
        'Gender': emp.Gender,
        'Address': emp.Address,
        'Branch_Code': emp.Branch_Code
    }

def emp_contact_to_dict(contact):
    return {
        'Emp_Ref': contact.Emp_Ref,
        'Contact': contact.Contact
    }

def emp_age_to_dict(age_info):
    return {
        'Emp_Ref': age_info.Emp_Ref,
        'DOB': age_info.DOB,
        'Age': age_info.Age
    }

def emp_status_to_dict(status):
    return {
        'Emp_Ref': status.Emp_Ref,
        'Position': status.Position,
        'Salary': status.Salary
    }

EmpInfo.to_dict = emp_to_dict
EmpContact.to_dict = emp_contact_to_dict
EmpAgeInfo.to_dict = emp_age_to_dict
EmpStatus.to_dict = emp_status_to_dict
