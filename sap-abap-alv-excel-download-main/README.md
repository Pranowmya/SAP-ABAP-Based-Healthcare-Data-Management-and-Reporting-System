# 🚀 SAP ABAP ALV Report – Excel Download Functionality

## 📌 Overview
This project demonstrates an Object-Oriented ALV (ABAP List Viewer) report in SAP ABAP with a custom toolbar button to download report data into Excel (CSV format).

The report fetches material document data by joining header and item tables and displays it in an interactive ALV Grid.

---

## 🎯 Objective
To build an interactive ALV report that:
- Displays material document data  
- Provides a custom Excel download button  
- Allows users to export data to CSV format  
- Demonstrates event handling in ALV  

---

## 🧩 Tables Used
- MKPF – Material Document Header  
- MSEG – Material Document Item  

---

## ⚙️ Report Details
**Report Name:** `ZMP_02_ALV`

---

## 🔄 Process Flow
1. User enters Posting Date range  
2. System fetches data using INNER JOIN (MKPF & MSEG)  
3. ALV Grid is displayed  
4. User clicks **Download Excel** button  
5. File save dialog opens  
6. Data is downloaded as CSV  

---

## 💡 Key Features
- OO ALV using `CL_GUI_ALV_GRID`  
- Custom toolbar button  
- Event handling (Toolbar + User Command)  
- Excel (CSV) export functionality  
- Dynamic field catalog  

---

📊 Sample Output
<img width="564" height="554" alt="Screenshot 2026-04-22 195207" src="https://github.com/user-attachments/assets/ee3ae696-6c49-4073-a4c8-05371037994b" />

<img width="564" height="554" alt="Screenshot 2026-04-22 195351" src="https://github.com/user-attachments/assets/333617f3-3600-4539-b4d1-75dbffaa23f4" />

----

🧰 Technologies Used
- SAP ABAP
- ALV Grid (CL_GUI_ALV_GRID)
- Open SQL
- Event Handling
- GUI_DOWNLOAD

---

🏷️ Tags

sap-abap, alv-report, excel-download, sap-development, erp, abap
