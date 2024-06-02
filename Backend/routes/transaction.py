from flask import Blueprint, request, jsonify
from models import db, Transaction

transaction_blueprint = Blueprint('transaction', __name__)

@transaction_blueprint.route('/transactions', methods=['GET'])
def get_transactions():
    transactions = Transaction.query.all()
    return jsonify([transaction.to_dict() for transaction in transactions])

@transaction_blueprint.route('/transaction', methods=['POST'])
def add_transaction():
    data = request.get_json()
    new_transaction = Transaction(Transaction_Ref=data['Transaction_Ref'], Tr_Date=data['Tr_Date'], Tr_Amount=data['Tr_Amount'], Tr_Type=data['Tr_Type'], Tr_Desc=data['Tr_Desc'], Cust_ID=data['Cust_ID'], Acc_No=data['Acc_No'])
    db.session.add(new_transaction)
    db.session.commit()
    return jsonify(new_transaction.to_dict())

# Helper method to_dict to convert SQLAlchemy object to dictionary
def transaction_to_dict(transaction):
    return {
        'Transaction_Ref': transaction.Transaction_Ref,
        'Tr_Date': transaction.Tr_Date,
        'Tr_Amount': transaction.Tr_Amount,
        'Tr_Type': transaction.Tr_Type,
        'Tr_Desc': transaction.Tr_Desc,
        'Cust_ID': transaction.Cust_ID,
        'Acc_No': transaction.Acc_No
    }

Transaction.to_dict = transaction_to_dict
