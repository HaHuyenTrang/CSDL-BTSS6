-- Tạo bảng employees
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY, 
    full_name VARCHAR(100) NOT NULL,            
    position VARCHAR(50) NOT NULL,              
    salary DECIMAL(10, 2) NOT NULL,             
    hire_date DATE NOT NULL,                    
    department VARCHAR(50) NOT NULL            
);

-- Thêm bản ghi vào employees
INSERT INTO employees (full_name, position, salary, hire_date, department)
VALUES
('Nguyen Van An', 'Software Engineer', 15000000.00, '2022-05-01', 'IT'),
('Tran Thi Bich', 'HR Specialist', 12000000.00, '2021-03-15', 'Human Resources'),
('Le Van Cuong', 'Sales Manager', 18000000.00, '2020-11-20', 'Sales'),
('Pham Minh Hoang', 'Marketing Specialist', 14000000.00, '2023-01-10', 'Marketing'),
('Do Thi Ha', 'Accountant', 13000000.00, '2021-07-25', 'Finance'),
('Hoang Quang Huy', 'Project Manager', 20000000.00, '2019-06-05', 'IT');

-- 2
select 
full_name, position, salary
from Employees
where salary > (select avg(salary) from Employees); 

-- 3
select 
full_name, department
from Employees
where department in (
    -- Tìm các phòng ban có từ 2 nhân viên trở lên
    select department
    from employees
    group by department
    having COUNT(*) >= 2
);


-- 4
select 
full_name, department,salary
from Employees
where department in (
    -- Tìm các phòng ban có từ 2 nhân viên trở lên
    select department
    from employees
    group by department
    having max(salary)
); 

-- 5
SELECT 
    e.full_name, 
    e.department, 
    e.hire_date
FROM employees e
WHERE e.hire_date = (
    -- Tìm ngày tuyển dụng sớm nhất trong mỗi phòng ban
    SELECT MIN(hire_date)
    FROM employees
    WHERE department = e.department
    GROUP BY department
);
 