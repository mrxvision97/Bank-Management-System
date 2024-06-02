from flask import Blueprint, request, jsonify
from models import db, Repayment

repayment_blueprint = Blueprint('repayment', __name__)

@repayment_blueprint.route('/repayments', methods=['GET'])
def get_repayments():
    repayments = Repayment.query.all()
    return jsonify([repayment.to_dict() for repayment in repayments])

@repayment_blueprint.route('/repayment', methods=['POST'])
def add_repayment():
    data = request.get_json()
    new_repayment = Repayment(Payment_Seqno=data['Payment_Seqno'], Payment_Amt=data['Payment_Amt'], Payment_Date=data['Payment_Date'], Remaining_Amt=data['Remaining_Amt'], Acc_No=data['Acc_No'])
    db.session.add(new_repayment)
    db.session.commit()
    return jsonify(new_repayment.to_dict())

# Helper method to_dict to convert SQLAlchemy object to dictionary
def repayment_to_dict(repayment):
    return {
        'Payment_Seqno': repayment.Payment_Seqno,
        'Payment_Amt': repayment.Payment_Amt,
        'Payment_Date': repayment.Payment_Date,
        'Remaining_Amt': repayment.Remaining_Amt,
        'Acc_No': repayment.Acc_No
    }

Repayment.to_dict = repayment_to_dict
