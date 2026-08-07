# Phase 4: Polish and Advanced Features

**Duration:** 1-2 hours
**Focus:** Production readiness, advanced features

## Objective

Go beyond the basics. These are optional challenges for teams who finish early or want to push further.

## Advanced Challenges

1. **Compare Multiple Models** -- Go back to the notebook, train 3+ models (e.g., Logistic Regression, Random Forest, Gradient Boosting, XGBoost), compare them side-by-side with cross-validation, and export the best one.
2. **Feature Expansion** -- Add more features to the model (Carrier, Month, CRSDepTime). Retrain and compare performance.
3. **Swagger / OpenAPI** -- Add interactive API documentation (automatic with FastAPI, manual with Flask).
4. **Client-Side Caching** -- Cache the airports list so it's not re-fetched on every interaction.
5. **Data Visualization in the Frontend** -- Display a chart or graph showing delay trends (e.g., by day of week or by airport) using Chart.js, D3, or a similar library.
6. **Unit & Integration Tests** -- Write tests for the API endpoints and the frontend components.
7. **Dockerize** -- Create a `Dockerfile` for the server and optionally the client. Write a `docker-compose.yml` to run both together.
8. **CI/CD Pipeline** -- Create a GitHub Actions workflow that lints, tests, and builds the project on every push.
9. **Deploy to Azure** -- Deploy the API to Azure App Service or Azure Container Apps, and the frontend to Azure Static Web Apps.
10. **Model Interpretability** -- Use SHAP to explain the model's predictions; display feature importance in the frontend.

---

Previous: [Phase 3: Build the Frontend](phase-3-frontend.md)
