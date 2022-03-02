const PREDICTION_URL = "./predict";

/**
 *
 */
function predictBloodPressure() {
  const age = document.getElementById("age").value;
  const weight = document.getElementById("weight").value;

  /**
   * Displays the predicted blood pressure
   */
  function showResult(predictedBloodPressure) {
    const bloodPressureDisplay = document.getElementById(
      "blood-pressure-display"
    );

    if (bloodPressureDisplay.style.display == "") {
      bloodPressureDisplay.style.display = "block";
    }
    bloodPressureDisplay.innerHTML = predictedBloodPressure;
  }

  // Get the blood pressure prediction
  fetch(PREDICTION_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      age: age,
      weight: weight,
    }),
  })
    .then(async (response) => {
      const result = await response.json();

      // Check the result code
      if (result["code"] == 200) {
        showResult(result["result"]["blood_pressure"]);
      } else {
        alert("Error from server :: " + result["error_msg"]);
      }
    })
    .catch((err) => {
      alert("Some error encountered while contacting the server. " + err);
    });

  return false;
}
