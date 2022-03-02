from flask import Flask, Blueprint, request, make_response, jsonify
from flask import render_template
import pandas as pd
import joblib


MODEL_PATH = "./regr.pkl"


def create_app():
    app = Flask(__name__)
    app.config["MODEL_PATH"] = "./regr.pkl"
    app.config["classifier"] = None

    blood_pressure_predictor = Blueprint(
        "blood_pressure_predictor", __name__, template_folder="templates", static_folder="static"
    )

    @app.before_first_request
    def init_app():
        # Load the classifier
        app.config["classifier"] = joblib.load(app.config["MODEL_PATH"])

    @app.after_request
    def after_request(response):
        origin = request.headers.get("Origin")
        if request.method == "OPTIONS":
            response = make_response()
            response.headers.add("Access-Control-Allow-Credentials", "true")
            response.headers.add("Access-Control-Allow-Headers", "Content-Type")
            response.headers.add("Access-Control-Allow-Headers", "x-csrf-token")
            response.headers.add("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, PATCH, DELETE")
            if origin:
                response.headers.add("Access-Control-Allow-Origin", origin)
        else:
            response.headers.add("Access-Control-Allow-Credentials", "true")
            if origin:
                response.headers.add("Access-Control-Allow-Origin", origin)

        return response

    @blood_pressure_predictor.route("/", methods=["GET"])
    def index():
        """Return the main blood pressure prediction application"""
        return render_template("index.html")

    @blood_pressure_predictor.route("/predict", methods=["POST"])
    def predict():
        """Returns the predicted blood pressure from age and weight"""
        clf = app.config["classifier"]

        if clf is None:
            print("Model not found!")
            return jsonify({"status": "failed", "code": 500, "error_msg": "Prediction model could not be found!"})

        req = request.json
        age, weight = req["age"], req["weight"]

        x = pd.DataFrame([[age, weight]], columns=["Age", "Weight"])
        return jsonify(
            {
                "status": "success",
                "code": 200,
                "request": {"weight": weight, "age": age},
                "result": {"blood_pressure": clf.predict(x)[0]},
            }
        )

    # Register the blood pressure predictor with the Flask app
    app.register_blueprint(blood_pressure_predictor, url_prefix="/bl00dPr6ssur6pr6d!ctor")

    return app


app = create_app()
if __name__ == "__main__":
    app.run(debug=True)
