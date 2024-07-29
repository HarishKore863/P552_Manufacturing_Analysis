select * from p552manufacturing_data;
show columns from p552manufacturing_data;

# Total Manufactuning Qty
SELECT 
    CONCAT(ROUND((SUM(manufacturedQty) / 1000), 0),
            'K') AS Ttl_ManufacturingQty
FROM
    p552_manufacturing.p552manufacturing_data;
    
    
# Ttl_Rejected_qty
SELECT 
    CONCAT(ROUND(SUM(RejectedQty) / 1000, 0), 'K') AS Ttl_RejQty
FROM
    p552_manufacturing.p552manufacturing_data;

# Total Balance Qty
SELECT 
    CONCAT(ROUND(SUM(balanceQty) / 1000000, 0), 'M') AS Balance_qty
FROM
    p552_manufacturing.p552manufacturing_data;

# Total Emp
SELECT 
    COUNT(DISTINCT EMP_Name) AS Ttl_EMP
FROM
    p552_Manufacturing.p552manufacturing_data;

# Total Wastage%
SELECT 
    CONCAT(ROUND((SUM(rejectedQty) / SUM(manufacturedQty) * 100),
                    2),
            '%') AS Wastage_percentage
FROM
    p552_manufacturing.p552manufacturing_data; 
    
# Total Produced qty   
SELECT 
    CONCAT(ROUND(SUM(producedqty) / 1000000, 0),
            'M') AS Ttl_RejQty
FROM
    p552_manufacturing.p552manufacturing_data;
    
# Total processed qty
SELECT 
    CONCAT(ROUND(SUM(Processedqty) / 1000000, 2),
            'M') AS Ttl_Proc_qty
FROM
    p552_manufacturing.p552manufacturing_data;
    
# Total Qty
select concat(round(sum(TotalQty)/1000000,0),"M") As Total_qty 
from p552_manufacturing.p552manufacturing_data;

# Total Work Qty
SELECT 
    CONCAT(ROUND(SUM(WO_Qty) / 1000000, 2), 'M') AS WO_Qty
FROM
    p552_manufacturing.p552manufacturing_data;
    
# Total Customers
Select count(Cust_Name) As Total_Cust from p552_manufacturing.p552manufacturing_data
where Cust_Name is not null;

# FiscalDate wise manufacturing_qty Vs Rejected_qty   
SELECT DISTINCT
    fiscalDate,
    concat(round(SUM(ManufacturedQty)/1000,0)," K") AS Manu_qty,
    concat(round(SUM(RejectedQty)/1000,0)," K") AS RejQty
FROM
    p552_manufacturing.p552manufacturing_data
GROUP BY FiscalDate
ORDER BY manu_qty desc;

# monthwise Production VS Rejcted Qty
SELECT DISTINCT
    monthname(fiscalDate) as month,
    concat(round(SUM(ProducedQty)/1000,0)," K") AS Prod_qty,
    concat(round(SUM(RejectedQty)/1000,0)," K") AS Rej_Qty
FROM
    p552_manufacturing.p552manufacturing_data
GROUP BY month
ORDER BY Prod_qty desc;

# Top5 empwise Rejected Qty
select EMP_code, Rej_Qty,
row_number() over(order by Rej_qty desc) as RN
from
(select distinct EMP_Code, concat(round(sum(rejectedQty)/1000,2),"K") as Rej_qty 
from p552_manufacturing.p552manufacturing_data
group by EMP_Code) as CTE
limit 5;

# Top5 machinewise rejected qty
select MachineCode, Rej_Qty,
row_number() over(order by Rej_qty desc) as RN
from
(select distinct MachineCode, concat(round(sum(rejectedQty)/1000,2),"K") as Rej_qty 
from p552_manufacturing.p552manufacturing_data
group by MachineCode) as CTE
limit 5;

#Departmentwise manufactured qty VS Rejected qty
SELECT 
    department_name,
    concat(round(SUM(manufacturedqty) / 1000,2),"K") AS Manu_qty,
    concat(round(SUM(rejectedqty) / 1000,2),"K") AS Rej_qty
FROM
    p552_manufacturing.p552manufacturing_data
GROUP BY Department_Name;

# Top10 EMP_wise Produced_qty
with CTE as(select Emp_code,
concat(round(sum(Producedqty)/1000,2),"K")as Prod_qty,
row_number() over(order by (sum(Producedqty)/1000)  desc) As RN
from p552_manufacturing.p552manufacturing_data
group by EMP_Code )
select Emp_code, Prod_qty, RN
from CTE limit 10;











    


    
    

    
    




