select 
    description, 
    lastChangeDate, 
    `name`, 
    (select name from Employee where Employee.id = ExpenseReport.assignee_id) as assignee
from ExpenseReport;
