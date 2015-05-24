insert into ExpenseReport (description, lastChangeDate, `name`, status, assignee_id, lastChangedBy_id, reporter_id) values(
    null,
    (select now()),
    (select uuid()),
    (select floor(1 + rand()*5)),
    (select floor(1 + rand()*3)),
    (select floor(1 + rand()*3)),
    (select floor(1 + rand()*3))
);
