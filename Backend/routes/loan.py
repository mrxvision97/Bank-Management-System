from flask import Blueprint, request, jsonify
from models import db, LoanType, LoanDetails

loan_blueprint = Blueprint('loan', __name__)

@loan_blueprint.route('/loans', methods=['GET'])
def get_loans():
    loans = LoanDetails.query.all()
    return jsonify([loan.to_dict() for loan in loans])

@loan_blueprint.route('/loan', methods=['POST'])
def add_loan():
    data = request.get_json()
    new_loan = LoanDetails(Acc_No=data['Acc_No'], Loan_Type=data['Loan_Type'], Duration=data['Duration'], Amount=data['Amount'], Status=data['Status'])
    db.session.add(new_loan)
    db.session.commit()
    return jsonify(new_loan.to_dict())

@loan_blueprint.route('/loan/types', methods=['GET'])
def get_loan_types():
    types = LoanType.query.all()
    return jsonify([type.to_dict() for type in types])

@loan_blueprint.route('/loan/type', methods=['POST'])
def add_loan_type():
    data = request.get_json()
    new_type = LoanType(Loan_Type=data['Loan_Type'], Interest=data['Interest'])
    db.session.add(new_type)
    db.session.commit()
    return jsonify(new_type.to_dict())

# Helper methods to_dict to convert SQLAlchemy objects to dictionaries
def loan_type_to_dict(type):
    return {
        'Loan_Type': type.Loan_Type,
        'Interest': type.Interest
    }

def loan_details_to_dict(loan):
    return {
        'Acc_No': loan.Acc_No,
        'Loan_Type': loan.Loan_Type,
        'Duration': loan.Duration,
        'Amount': loan.Amount,
        'Status': loan.Status
    }

LoanType.to_dict = loan_type_to_dict
LoanDetails.to_dict = loan_details_to_dict
