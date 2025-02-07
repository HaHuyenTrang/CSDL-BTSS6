-- Tạo bảng students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Tạo bảng courses
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    fee DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng enrollments
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
-- Thêm bản ghi vào bảng students
INSERT INTO students (name, email, phone)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678'),
('Le Van Cuong', 'levancuong@example.com', '0923456789'),
('Pham Minh Hoang', 'phamminhhoang@example.com', '0934567890'),
('Do Thi Ha', 'dothiha@example.com', '0945678901'),
('Hoang Quang Huy', 'hoangquanghuy@example.com', '0956789012');

-- Thêm bản ghi vào bảng cources
INSERT INTO courses (course_name, duration, fee)
VALUES
('Python Basics', 30, 300000),
('Web Development', 50, 1000000),
('Data Science', 40, 1500000);

-- Thêm bản ghi vào bảng enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES
(1, 1, '2025-01-10'), 
(2, 2, '2025-01-11'), 
(3, 3, '2025-01-12'), 
(4, 1, '2025-01-13'), 
(5, 2, '2025-01-14'), 
(6, 2, '2025-01-10'), 
(2, 3, '2025-01-17'), 
(3, 1, '2025-01-11'), 
(4, 3, '2025-01-19'); 

-- 2
SELECT 
    s.student_id, 
    s.name, 
    s.email, 
    SUM(c.fee) AS total_fee, 
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id, s.name, s.email  -- Nhóm kết quả theo học viên để tính tổng học phí và số lượng khóa học cho mỗi học viên.
HAVING COUNT(e.course_id) > 1 -- đăng ký nhiều hơn 1 khóa học. 
ORDER BY total_fee DESC -- học phí gaimr dần 
LIMIT 5; -- 5 bản ghi 
 
-- 3
SELECT 
    s.student_id, 
    s.name AS student_name, 
    c.course_name, 
    c.fee, 
    CASE -- Phân loại mức học phí của từng khóa học vào các nhóm: Low: Học phí dưới 500,000. Medium: Học phí từ 500,000 đến 1,000,000 (bao gồm cả 500,000 và 1,000,000). High: Học phí trên 1,000,000.
        WHEN c.fee < 500000 THEN 'Low'
        WHEN c.fee BETWEEN 500000 AND 1000000 THEN 'Medium'
        ELSE 'High'
    END AS fee_category,
    e.enrollment_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY fee_category, s.name; -- TĂNG ĐẦN


-- 4
SELECT 
    c.course_name, 
    c.fee, 
    COUNT(e.student_id) AS num_students, 
    SUM(c.fee) AS total_revenue -- tổng doanh thu từ học phí của mỗi khóa học.
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name, c.fee
HAVING COUNT(e.student_id) > 1 -- Lọc chỉ lấy các khóa học có hơn 1 học viên đăng ký.
ORDER BY num_students DESC, total_revenue DESC -- ố lượng học viên đăng ký (giảm dần),tổng doanh thu (giảm dần).
LIMIT 10; 10 BẢN GHI 
 
 