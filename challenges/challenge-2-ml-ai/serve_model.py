"""
Prediction API skeleton for serving the churn model.
Load the serialized model and preprocessing pipeline, expose a prediction endpoint.
"""

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import joblib
import numpy as np
from pathlib import Path

app = FastAPI(title="Churn Prediction API")

# Load model at startup -- update the path after training
MODEL_PATH = Path("churn_model.pkl")
model = None


@app.on_event("startup")
def load_model():
    global model
    if MODEL_PATH.exists():
        model = joblib.load(MODEL_PATH)


class CustomerData(BaseModel):
    """Input schema matching the training features. Adjust fields after EDA."""
    gender: str = Field(..., examples=["Male"])
    senior_citizen: int = Field(..., ge=0, le=1)
    partner: str = Field(..., examples=["Yes"])
    dependents: str = Field(..., examples=["No"])
    tenure: float = Field(..., ge=0)
    phone_service: str = Field(..., examples=["Yes"])
    internet_service: str = Field(..., examples=["Fiber optic"])
    contract: str = Field(..., examples=["Month-to-month"])
    payment_method: str = Field(..., examples=["Electronic check"])
    monthly_charges: float = Field(..., ge=0)
    total_charges: float = Field(..., ge=0)
    support_tickets: int = Field(..., ge=0)


class PredictionResponse(BaseModel):
    churn_probability: float
    prediction: str


@app.get("/health")
def health():
    return {"status": "ok", "model_loaded": model is not None}


@app.post("/predict", response_model=PredictionResponse)
def predict(customer: CustomerData):
    if model is None:
        raise HTTPException(status_code=503, detail="Model not loaded")

    # Convert input to the format your pipeline expects.
    # Update this after building the preprocessing pipeline in Stage 3.
    features = customer.model_dump()

    # Placeholder -- replace with actual pipeline prediction logic:
    # prediction = model.predict(pd.DataFrame([features]))
    # probability = model.predict_proba(pd.DataFrame([features]))[0][1]
    raise HTTPException(
        status_code=501,
        detail="Implement prediction logic after completing Stage 3",
    )
