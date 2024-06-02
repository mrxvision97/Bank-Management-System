from flask import Blueprint, request, jsonify
from models import db, Branch

branch_blueprint = Blueprint('branch', __name__)

@branch_blueprint.route('/branches', methods=['GET'])
def get_branches():
    branches = Branch.query.all()
    return jsonify([branch.to_dict() for branch in branches])

@branch_blueprint.route('/branch', methods=['POST'])
def add_branch():
    data = request.get_json()
    new_branch = Branch(Branch_Code=data['Branch_Code'], Branch_Name=data['Branch_Name'], Branch_Loc=data['Branch_Loc'])
    db.session.add(new_branch)
    db.session.commit()
    return jsonify(new_branch.to_dict())

# Helper method to_dict to convert SQLAlchemy object to dictionary
def branch_to_dict(branch):
    return {
        'Branch_Code': branch.Branch_Code,
        'Branch_Name': branch.Branch_Name,
        'Branch_Loc': branch.Branch_Loc
    }

Branch.to_dict = branch_to_dict
