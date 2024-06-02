from routes import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)
# Path: Backend/routes/employee.py
# Compare this snippet from Backend/routes/customer.py:
# from flask import Blueprint, request, jsonify
# from models import db, CustomerInfo
