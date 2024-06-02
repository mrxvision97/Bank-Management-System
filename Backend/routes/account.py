from flask import Blueprint, request, jsonify
from models import db, CustAccounts, AccountDetails

account_blueprint = Blueprint('account', __name__)

@account_blueprint.route('/accounts', methods=['GET'])
def get_accounts():
    accounts = CustAccounts.query.all()
    return jsonify([account.to_dict() for account in accounts])

@account_blueprint.route('/account', methods=['POST'])
def add_account():
    data = request.get_json()
    new_account = CustAccounts(Cust_ID=data['Cust_ID'], Acc_No=data['Acc_No'], Account_Type=data['Account_Type'])
    db.session.add(new_account)
    db.session.commit()
    return jsonify(new_account.to_dict())

@account_blueprint.route('/account/details', methods=['GET'])
def get_account_details():
    details = AccountDetails.query.all()
    return jsonify([detail.to_dict() for detail in details])

@account_blueprint.route('/account/details', methods=['POST'])
def add_account_details():
    data = request.get_json()
    new_detail = AccountDetails(Account_Type=data['Account_Type'], Status=data['Status'], Interest_Rate=data['Interest_Rate'], Balance=data['Balance'])
    db.session.add(new_detail)
    db.session.commit()
    return jsonify(new_detail.to_dict())

# Helper methods to_dict to convert SQLAlchemy objects to dictionaries
def cust_account_to_dict(account):
    return {
        'Cust_ID': account.Cust_ID,
        'Acc_No': account.Acc_No,
        'Account_Type': account.Account_Type
    }

def account_detail_to_dict(detail):
    return {
        'Account_Type': detail.Account_Type,
        'Status': detail.Status,
        'Interest_Rate': detail.Interest_Rate,
        'Balance': detail.Balance
    }

CustAccounts.to_dict = cust_account_to_dict
AccountDetails.to_dict = account_detail_to_dict
