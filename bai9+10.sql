
-- use session6;

create table Patientss(
	patients_id int primary key auto_increment,
    full_name varchar(100),
    DateOfBirth date,
    gender varchar(10),
    phoneNumber varchar(15)
);

create table Doctorss(
	doctor_id int primary key auto_increment,
    full_name varchar(100),
    specialization varchar(50),
    phoneNumber varchar(15),
    email varchar(100)
);

create table Appointmentsss(
	appointmentsId int primary key auto_increment,
    patients_id int not null,
    doctor_id int not null,
    appointments_date datetime,
    status varchar(20),
	FOREIGN KEY (patients_id) REFERENCES Patientss(patients_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctorss(doctor_id) ON DELETE CASCADE
);

create table MedicalRecordss(
	record_id int primary key auto_increment,
    patiemts_id int not null,
    doctor_id int not null,
    diagnosis text,
    treatmentPlan text
);

-- Insert dữ liệu vào bảng Patients (Thông tin bệnh nhân)
INSERT INTO Patientss (full_name, DateOfBirth, gender, phoneNumber)
VALUES
    ('Nguyen Van An', '1985-05-15', 'Nam', '0901234567'),
    ('Tran Thi Binh', '1990-09-12', 'Nu', '0912345678'),
    ('Pham Van Cuong', '1978-03-20', 'Nam', '0923456789'),
    ('Le Thi Dung', '2000-11-25', 'Nu', '0934567890'),
    ('Vo Van Em', '1982-07-08', 'Nam', '0945678901'),
    ('Hoang Thi Phuong', '1995-01-18', 'Nu', '0956789012'),
    ('Ngo Van Giang', '1988-12-30', 'Nam', '0967890123'),
    ('Dang Thi Hanh', '1992-06-10', 'Nu', '0978901234'),
    ('Bui Van Hoa', '1975-10-22', 'Nam', '0989012345');

-- Insert dữ liệu vào bảng Doctors (Thông tin bác sĩ)
INSERT INTO Doctorss (full_name, specialization, phoneNumber, email)
VALUES
    ('Le Minh', 'Noi Tong Quat', '0908765432', 'leminh@hospital.vn'),
    ('Phan Huong', 'Nhi Khoa', '0918765432', 'phanhuong@hospital.vn'),
    ('Nguyen Tuan', 'Tim Mach', '0928765432', 'nguyentuan@hospital.vn'),
    ('Dang Quang', 'Than Kinh', '0938765432', 'dangquang@hospital.vn'),
    ('Hoang Dung', 'Da Lieu', '0948765432', 'hoangdung@hospital.vn'),
    ('Vu Hanh', 'Phu San', '0958765432', 'vuhanh@hospital.vn'),
    ('Tran An', 'Noi Tiet', '0968765432', 'tranan@hospital.vn'),
    ('Lam Phong', 'Ho Hap', '0978765432', 'lamphong@hospital.vn'),
    ('Pham Ha', 'Chan Thuong Chinh Hinh', '0988765432', 'phamha@hospital.vn');

-- Insert dữ liệu vào bảng Appointments (Lịch hẹn khám)
INSERT INTO Appointmentsss (patients_id, doctor_id, appointments_date, status)
VALUES
    (1, 2, '2025-02-01 09:00:00', 'Da Dat'), 
    (1, 2, '2025-02-15 14:00:00', 'Da Dat'), 
    (3, 1, '2025-01-29 10:30:00', 'Da Dat'), 
    (3, 1, '2025-01-30 10:50:00', 'Da Dat'), 
    (3, 1, '2025-02-03 12:30:00', 'Da Dat'), 
    (5, 3, '2025-01-30 08:00:00', 'Da Dat'), 
    (2, 4, '2025-02-03 16:00:00', 'Da Dat'), 
    (6, 6, '2025-02-10 10:00:00', 'Da Dat'), 
    (7, 7, '2025-02-15 11:30:00', 'Da Dat'), 
    (8, 8, '2025-02-20 09:00:00', 'Da Dat'), 
    (9, 9, '2025-02-25 14:30:00', 'Da Dat'); 

-- Insert dữ liệu vào bảng MedicalRecords (Hồ sơ y tế)
INSERT INTO MedicalRecordss (  patiemts_id , doctor_id, diagnosis, treatmentPlan)
VALUES
    (1, 2, 'Cam Cum', 'Nghi ngoi, uong nhieu nuoc, su dung paracetamol 500mg khi sot.'),
    (3, 1, 'Dau Dau Man Tinh', 'Kiem tra huyet ap dinh ky, giam cang thang, su dung thuoc giam dau khi can.'),
    (5, 3, 'Roi Loan Nhip Tim', 'Theo doi tim mach 1 tuan/lan, dung thuoc dieu hoa nhip tim.'),
    (2, 4, 'Dau Cot Song', 'Vat ly tri lieu, giam van dong manh.'),
    (4, 5, 'Viêm Da Tiep Xuc', 'Su dung kem boi da, tranh tiep xuc voi chat gay di ung.'),
    (6, 6, 'Thieu Mau', 'Tang cuong thuc pham giau sat, bo sung vitamin.'),
    (7, 7, 'Tieu Duong Type 2', 'Duy tri che do an lanh manh, kiem tra duong huyet thuong xuyen.'),
    (8, 8, 'Hen Suyen', 'Su dung thuoc xit hen hang ngay, tranh tiep xuc bui ban.'),
    (9, 9, 'Gay Xuong', 'Bo bot, kiem tra xuong dinh ky, vat ly tri lieu sau khi thao bot.');
    
    
    -- 3
SELECT 
	d.full_name AS DoctorName,
	d.specialization AS Specialization,
	COUNT(DISTINCT a.patients_id) AS TotalPatients, -- số lượng bệnh nhân đã điều trị
	COUNT(a.appointmentsId) AS TotalAppointments, -- tổng số lượt khám
	d.email AS Email
FROM Doctorss d
JOIN Appointmentsss a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
HAVING COUNT(a.appointmentsId) > 1 -- chỉ bs 1 lượt khám
ORDER BY TotalPatients DESC, TotalAppointments DESC -- giảm dần số bệnh nhân và tổng lượt khám
LIMIT 5;

-- 4
SELECT 
    d.full_name AS DoctorName,
    d.specialization AS Specialization,
    COUNT(DISTINCT a.patients_id) AS TotalPatients, --  số lượng bệnh nhân đã điều trị
    COUNT(a.appointmentsId) AS TotalAppointments,
    COUNT(a.appointmentsId) * 500000 AS TotalEarnings -- tính thu nhập TotalEarnings=TotalAppointments×500,000
FROM Doctorss d
JOIN Appointmentsss a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
HAVING TotalEarnings > 600000 -- lấy bác sĩ có thu nhập trên 600,000 VND.
ORDER BY TotalEarnings DESC; --  Sắp xếp giảm dần theo thu nhập.
 
 
 
 --  5
 SELECT 
    p.patients_id AS PatientID,
    p.full_name AS PatientName,
    d.full_name AS DoctorName,
    a.appointments_date AS AppointmentDate,
    TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) AS Age,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) < 18 THEN 'Trẻ em'
        WHEN TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) BETWEEN 18 AND 30 THEN 'Trung niên'
        WHEN TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) BETWEEN 31 AND 40 THEN 'Qua thời'
        WHEN TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) BETWEEN 41 AND 50 THEN 'Lớn tuổi'
        WHEN TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE()) BETWEEN 51 AND 60 THEN 'Già'
        ELSE 'Người cao tuổi'
    END AS AgeGroup
FROM Patientss p
JOIN Appointmentsss a ON p.patients_id = a.patients_id
JOIN Doctorss d ON a.doctor_id = d.doctor_id
ORDER BY Age DESC, AppointmentDate ASC;


-- bài 10
-- xóa lịch hẹn
DELETE FROM Appointmentsss
WHERE doctor_id = (
    SELECT doctor_id FROM Doctorss WHERE full_name = 'Phan Huong'
)
AND appointments_date < CURDATE();
 
-- hiển thị
SELECT 
    a.appointmentsId, 
    p.full_name AS PatientName, 
    d.full_name AS DoctorName, 
    a.appointments_date, 
    a.status
FROM Appointmentsss a
JOIN Patientss p ON a.patients_id = p.patients_id
JOIN Doctorss d ON a.doctor_id = d.doctor_id
ORDER BY a.appointments_date ASC;
 
 
 -- 2
 -- cập nhật lịch hẹn
 UPDATE Appointmentsss
SET status = 'Dang cho'
WHERE patients_id = (
    SELECT patients_id FROM Patientss WHERE full_name = 'Nguyen Van An'
)
AND doctor_id = (
    SELECT doctor_id FROM Doctorss WHERE full_name = 'Phan Huong'
)
AND appointments_date >= CURDATE();


-- 3
SELECT 
    p.full_name AS PatientName, 
    d.full_name AS DoctorName, 
    a.appointments_date AS AppointmentDate, 
    m.diagnosis AS Diagnosis
FROM Appointmentsss a
JOIN Patientss p ON a.patients_id = p.patients_id
JOIN Doctorss d ON a.doctor_id = d.doctor_id
JOIN MedicalRecordss m ON a.patients_id = m.patiemts_id AND a.doctor_id = m.doctor_id
WHERE a.patients_id IN (
    SELECT patients_id 
    FROM Appointmentsss
    GROUP BY patients_id, doctor_id  -- Nhóm các lịch hẹn theo bệnh nhân và bác sĩ
    HAVING COUNT(appointmentsId) >= 2 -- để chỉ lấy những bệnh nhân có từ 2 lịch hẹn trở lên với cùng bác sĩ
)
ORDER BY p.full_name, d.full_name, a.appointments_date;

-- 4
SELECT 
    UPPER(CONCAT('BỆNH NHÂN: ', p.full_name, ' - BÁC SĨ: ', d.full_name)) AS AppointmentDetails, -- Chuyển toàn bộ chuỗi thành chữ in hoa.
    a.appointments_date AS AppointmentDate
FROM Appointmentsss a
JOIN Patientss p ON a.patients_id = p.patients_id
JOIN Doctorss d ON a.doctor_id = d.doctor_id
ORDER BY a.appointments_date ASC; -- tăng đân

 -- 5
 SELECT 
    UPPER(CONCAT('BỆNH NHÂN: ', p.full_name, ' - BÁC SĨ: ', d.full_name)) AS AppointmentDetails, -- Chuyển toàn bộ chuỗi thành chữ in hoa.
    a.appointments_date AS AppointmentDate, m.diagnosis AS Diagnosis, a.status AS Status
FROM Appointmentsss a
JOIN Patientss p ON a.patients_id = p.patients_id
JOIN Doctorss d ON a.doctor_id = d.doctor_id
LEFT JOIN MedicalRecordss m ON a.patients_id = m.patiemts_id AND a.doctor_id = m.doctor_id
ORDER BY a.appointments_date ASC;