# 🚀 SAP ABAP SmartForm – Customer & Business Partner Details

## 📌 Overview
This project demonstrates the use of SmartForms in SAP ABAP to generate a formatted output by combining customer master data and business partner data.

The report fetches:
- Customer details from KNA1  
- Business Partner details from BUT000  

The data is then passed to a SmartForm for structured output.

---

## 🎯 Objective
To design a SmartForm-based report that:
- Retrieves customer data  
- Retrieves business partner data  
- Displays formatted output using SmartForms  
- Demonstrates real-time SAP document generation  

---

## 🧩 Tables Used
- KNA1 – Customer Master Data  
- BUT000 – Business Partner Data  

---

## ⚙️ Program Details
**Report Name:** `ZMP_02_SF`  
**SmartForm Name:** `ZMP_02_SF`  

---

## 📥 Input
| Parameter | Description |
|----------|------------|
| KUNNR    | Customer Number |

---

## 📤 Output

### 📺 Output Location
- SAP GUI  
- Execute via SE38  
- Output generated as SmartForm (Print Preview / PDF)

---

### 📊 Output Content
The SmartForm displays:

#### 🔹 Customer Details (KNA1)
- Customer Number  
- Name  
- City  
- Country  

#### 🔹 Business Partner Details (BUT000)
- Partner Number  
- Type  
- Group  
- Name  
- Created Date  

---

## 🔄 Process Flow
1. User enters Customer Number (KUNNR)  
2. System fetches data from KNA1  
3. System fetches data from BUT000  
4. SmartForm function module is generated dynamically  
5. Data is passed to SmartForm  
6. Output is displayed in formatted layout  

---

## 💡 Key Features
- SmartForm integration  
- Dynamic function module call  
- Multi-table data handling  
- Structured print output  
- Real-time document generation  

---

📊 Sample Output
<img width="810" height="785" alt="Screenshot 2026-04-22 194727" src="https://github.com/user-attachments/assets/b0bc3165-9836-4412-83cc-5d711615bdee" />

---

🧰 Technologies Used
- SAP ABAP
- SmartForms
- Open SQL
- Function Modules

---
🏷️ Tags
sap-abap, smartforms, sap-development, kna1, but000, sap-project, erp
