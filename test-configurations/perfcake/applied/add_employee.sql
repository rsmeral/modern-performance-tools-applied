insert into Employee(bankAccount, email, firstName, lastName) values(
    (select floor(100000000 + rand()*899999999)),
    (select uuid()),
    'Firstname',
    'Lastname'
);