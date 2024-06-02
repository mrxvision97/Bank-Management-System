from flask import Flask
from config import Config
from models import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    with app.app_context():
        db.create_all()

    from routes.branch import branch_blueprint
    from routes.customer import customer_blueprint
    from routes.employee import employee_blueprint
    from routes.account import account_blueprint
    from routes.loan import loan_blueprint
    from routes.transaction import transaction_blueprint
    from routes.repayment import repayment_blueprint

    app.register_blueprint(branch_blueprint)
    app.register_blueprint(customer_blueprint)
    app.register_blueprint(employee_blueprint)
    app.register_blueprint(account_blueprint)
    app.register_blueprint(loan_blueprint)
    app.register_blueprint(transaction_blueprint)
    app.register_blueprint(repayment_blueprint)

    return app
