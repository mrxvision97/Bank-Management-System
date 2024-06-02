from flask import Blueprint, request, jsonify
from models import db, CustomerInfo

customer_blueprint = Blueprint('customer', __name__)

@customer_blueprint.route('/customers', methods=['GET'])
def get_customers():
    customers = CustomerInfo.query.all()
    return jsonify([customer.to_dict() for customer in customers])

@customer_blueprint.route('/customer', methods=['POST'])
def add_customer():
    data = request.get_json()
    new_customer = CustomerInfo(Cust_ID=data['Cust_ID'], Name=data['Name'], DOB=data['DOB'], Gender=data['Gender'], Branch_Code=data['Branch_Code'])
    db.session.add(new_customer)
    db.session.commit()
    return jsonify(new_customer.to_dict())

# Helper method to_dict to convert SQLAlchemy object to dictionary
def customer_to_dict(customer):
    return {
        'Cust_ID': customer.Cust_ID,
        'Name': customer.Name,
        'DOB': customer.DOB,
        'Gender': customer.Gender,
        'Branch_Code': customer.Branch_Code
    }

CustomerInfo.to_dict = customer_to_dict
