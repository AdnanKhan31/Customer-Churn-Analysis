SELECT * FROM "Telecom_project";

#1Q. What is the total number of customers, churned customers, retained customers, and the overall churn rate?
SELECT * FROM Overall_churn_value;
CREATE VIEW Overall_churn_value AS
SELECT
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
SUM(CASE WHEN "Churn" = 'No' THEN 1 ELSE 0 END) AS retained_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2):: TEXT ||'%'
AS churn_rate
FROM "Telecom_project";

#2Q. How does customer churn vary across different contract types, and which contract type has the highest churn rate?
SELECT * FROM Churn_by_contracts;
CREATE VIEW Churn_by_contracts AS
SELECT "Contract",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
SUM(CASE WHEN "Churn" = 'No' THEN 1 ELSE 0 END) AS retained_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)::TEXT ||'%' AS churn_rate
FROM "Telecom_project"
GROUP BY "Contract"
ORDER BY churn_rate DESC;

#3Q. Which customer tenure groups have the highest churn rate, and how does customer retention change as tenure increases?
SELECT * FROM Churn_by_tenure;
CREATE VIEW Churn_by_tenure AS
SELECT
CASE
WHEN "tenure" <= 12 THEN '0-12 Months'
WHEN "tenure" <= 24 THEN '13-24 Months'
WHEN "tenure" <= 48 THEN '25-48 Months'
 ELSE '49-72 Months' END AS tenure_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)::TEXT ||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY tenure_group
ORDER BY MIN("tenure");

#4Q. How does customer churn vary across different internet service types, and which service type has the highest churn rate?
SELECT * FROM churn_by_internet_service;
CREATE VIEW churn_by_internet_service as
SELECT "InternetService",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)::TEXT ||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY "InternetService"
ORDER BY churn_rate DESC;

#5Q. How does customer churn vary across different monthly charge ranges, and which charge range has the highest churn rate?
SELECT * FROM churn_by_monthly_charges;
CREATE VIEW churn_by_monthly_charges AS
SELECT
CASE
WHEN "MonthlyCharges" < 35 THEN 'Low Charges'
WHEN "MonthlyCharges" < 70 THEN 'Medium Charges' ELSE 'High Charges'
END AS charge_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) :: TEXT||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY charge_group;

#6Q. Which payment methods have the highest customer churn rate, and how does churn vary across different payment methods?
SELECT * FROM churn_by_payment_method;
CREATE VIEW churn_by_payment_method AS
SELECT "PaymentMethod",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2):: TEXT||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY "PaymentMethod"
ORDER BY churn_rate DESC;

#7Q. How does customer churn vary by gender and senior citizen status, and which customer group has the highest churn rate?
SELECT * FROM churn_by_demographics;
CREATE VIEW churn_by_demographics AS
SELECT "gender", "SeniorCitizen",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2):: TEXT||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY "gender", "SeniorCitizen"
ORDER BY churn_rate DESC;

#8Q. How does customer churn differ between customers who have OnlineSecurity and TechSupport services and those who do not?
SELECT * FROM churn_by_additional_services;
CREATE VIEW churn_by_additional_services AS
SELECT "OnlineSecurity", "TechSupport",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2):: TEXT|| '%'
AS churn_rate
FROM "Telecom_project"
GROUP BY "OnlineSecurity", "TechSupport"
ORDER BY churn_rate DESC;

#9Q. How do average monthly charges and customer tenure differ between churned and retained customers?
SELECT * FROM churn_vs_tenure_and_charges;
CREATE VIEW churn_vs_tenure_and_charges; AS
SELECT "Churn",
COUNT(*) AS total_customers,
ROUND(AVG("MonthlyCharges")::NUMERIC, 2) AS avg_monthly_charges,
ROUND(AVG("tenure")::NUMERIC, 2) AS avg_tenure_months,
ROUND(AVG("TotalCharges")::NUMERIC, 2) AS avg_total_charges
FROM "Telecom_project"
GROUP BY "Churn";

#10Q. How does the availability of technical support across different contract types affect customer churn rates?
SELECT * FROM churn_by_contract_and_support;
CREATE VIEW churn_by_contract_and_support AS
SELECT "Contract", "TechSupport",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)::TEXT||'%'
AS churn_rate
FROM "Telecom_project"
GROUP BY "Contract", "TechSupport"
ORDER BY "Contract", churn_rate DESC;

#11Q. Which contract type contributes the highest total revenue, and 
what percentage of overall revenue does each contract type contribute?
SELECT * FROM revenue_contribution_by_contract;
CREATE VIEW revenue_contribution_by_contract AS
SELECT "Contract",
COUNT(*) AS total_customers,
ROUND(SUM("TotalCharges")::NUMERIC, 2) AS total_revenue,
ROUND(
     (
SUM("TotalCharges") * 100.0 /
(SELECT SUM("TotalCharges") FROM "Telecom_project")
)::NUMERIC,2) AS revenue_contribution_pct
FROM "Telecom_project"
GROUP BY "Contract"
ORDER BY total_revenue DESC;

#12Q. Which payment methods generate the highest total revenue, and how does average customer spending vary across payment methods?
SELECT * FROM revenue_by_payment_method;
CREATE VIEW revenue_by_payment_method AS
SELECT "PaymentMethod",
COUNT(*) AS total_customers,
ROUND(SUM("TotalCharges")::NUMERIC, 2) AS total_revenue,
ROUND(AVG("TotalCharges")::NUMERIC, 2) AS avg_customer_spending,
ROUND(
    (
SUM("TotalCharges") * 100.0 / (SELECT SUM("TotalCharges") FROM "Telecom_project")
)::NUMERIC,2) AS revenue_contribution_pct
FROM "Telecom_project"
GROUP BY "PaymentMethod"
ORDER BY total_revenue DESC;

#13Q. Which combinations of optional services are associated with the highest customer churn rates?
SELECT * FROM churn_risk_by_service_combination;
CREATE VIEW churn_risk_by_service_combination AS
SELECT "OnlineSecurity", "OnlineBackup", "DeviceProtection",
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
     (
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
)::NUMERIC, 2) AS churn_rate
FROM "Telecom_project"
GROUP BY "OnlineSecurity", "OnlineBackup", "DeviceProtection"
ORDER BY churn_rate DESC;

#14Q. How are customers distributed across revenue segments (Low, Medium, and High), and 
which segment contributes the most to total revenue?
SELECT * FROM customer_revenue_segmentation;
CREATE VIEW customer_revenue_segmentation AS
SELECT
CASE
WHEN "TotalCharges" < 1000 THEN 'Low Revenue'
WHEN "TotalCharges" < 3000 THEN 'Medium Revenue'
ELSE 'High Revenue' END AS revenue_segment,
COUNT(*) AS total_customers,
ROUND(SUM("TotalCharges")::NUMERIC, 2) AS total_revenue,
ROUND(AVG("TotalCharges")::NUMERIC, 2) AS avg_customer_revenue,
ROUND(
     (
SUM("TotalCharges") * 100.0 / (SELECT SUM("TotalCharges") FROM "Telecom_project")
)::NUMERIC, 2) AS revenue_contribution_pct
FROM "Telecom_project"
GROUP BY revenue_segment
ORDER BY MIN("TotalCharges");	

#15Q. How does customer churn vary across different customer lifetime revenue segments, and which segment has the highest churn rate?
SELECT * FROM churn_by_revenue_segment;
CREATE VIEW churn_by_revenue_segment AS
SELECT
CASE
WHEN "TotalCharges" < 1000 THEN 'Low Revenue'
WHEN "TotalCharges" < 3000 THEN 'Medium Revenue'
ELSE 'High Revenue' END AS revenue_segment,
COUNT(*) AS total_customers,
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (
SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
)::NUMERIC, 2)::TEXT||'%' AS churn_rate
FROM "Telecom_project"
GROUP BY revenue_segment
ORDER BY churn_rate DESC;
