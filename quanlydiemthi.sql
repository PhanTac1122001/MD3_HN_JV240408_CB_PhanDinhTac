create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;

create table student(
student_id varchar(4) not null primary key,
student_name varchar(100) not null,
birthday date not null,
gender bit(1) not null,
address text not null,
phone_number varchar(45)
);

insert into student values ('S001','Nguyễn Thế Anh','1999-1-11',1,'Hà Nội','984678082'),
('S002','Đặng Bảo Trâm','1998-12-22',0,'Lào Cai','904982654'),
('S003','Trần Hà Phương','2000-5-5',0,'Nghệ An','947645363'),
('S004','Đỗ Tiến Mạnh','1999-3-26',1,'Hà Nội','983665353'),
('S005','Phạm Duy Nhất','1998-4-10',1,'Tuyên Quang','987242678'),
('S006','Mai Văn Thái','2002-6-22',1,'Nam Định','982654268'),
('S007','Giang Gia Hàn','1996-11-10',0,'Phú Thọ','982364753'),
('S008','Nguyễn Ngọc Bảo My','1999-1-22',0,'Hà Nam','927867453'),
('S009','Nguyễn Tiến Đạt','1998-8-7',1,'Tuyên Quang','989274673'),
('S010','Nguyễn Thiều Quang','2000-9-18',1,'Hà Nội','984378291');

create table subjects(
	subject_id varchar(4) not null primary key,
    subject_name varchar(45) not null,
    priority int not null
);
insert into subjects values ('MH01','Toán',2),
('MH02','Vật Lý',2),
('MH03','Hóa Học',1),
('MH04','Ngữ Văn',1),
('MH05','Tiếng Anh',2);

create table mark(
subject_id varchar(4) not null,
student_id varchar(4) not null,
point double not null,
foreign key (subject_id) references subjects(subject_id),
foreign key (student_id) references student(student_id)
);

insert into mark(subject_id, student_id, point) values
('MH01','S001', 8.5), ('MH02','S001', 7), ('MH03','S001',9), ('MH04','S001',9), ('MH05','S001',5),
('MH01','S002',9), ('MH02','S002',8), ('MH03','S002',6.5), ('MH04','S002',8), ('MH05','S002',6),
('MH01','S003',7.5), ('MH02','S003',6.5), ('MH03','S003',8), ('MH04','S003',7), ('MH05','S003',7),
('MH01','S004',6), ('MH02','S004',7), ('MH03','S004',5), ('MH04','S004',6.5), ('MH05','S004',8),
('MH01','S005',5.5), ('MH02','S005',8), ('MH03','S005',7.5), ('MH04','S005',8.5), ('MH05','S005',9),
('MH01','S006',8), ('MH02','S006',10), ('MH03','S006',9), ('MH04','S006',7.5), ('MH05','S006',6.5),
('MH01','S007',9.5), ('MH02','S007',9),('MH03','S007',6), ('MH04','S007',9), ('MH05','S007',4),
('MH01','S008',10), ('MH02','S008',8.5), ('MH03','S008',8.5), ('MH04','S008',6), ('MH05','S008',9.5),
('MH01','S009',7.5), ('MH02','S009',7), ('MH03','S009',9), ('MH04','S009',5), ('MH05','S009',10),
('MH01','S010',6.5), ('MH02','S010',8), ('MH03','S010',5.5), ('MH04','S010',4), ('MH05','S010',7);


-- Cập nhật dữ liệu
-- Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.

update student set student_name ='Đỗ Đức Mạnh' where student_id='S004';

-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.

update subjects set subject_name='Ngoại Ngữ',priority=1 where subject_id='MH05';

-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6, MH05 : 9).

update mark set point = 8.5 where student_id = 'S009' and subject_id = 'MH01';
update mark set point = 7 where student_id = 'S009' and subject_id = 'MH02';
update mark set point = 5.5 where student_id = 'S009' and subject_id = 'MH03';
update mark set point = 6 where student_id = 'S009' and subject_id = 'MH04';
update mark set point = 9 where student_id = 'S009' and subject_id = 'MH05';

-- Xóa dữ liệu
-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.

delete from mark where student_id='S010';

-- Truy vấn dữ liệu
-- Lấy ra tất cả thông tin của sinh viên trong bảng Student .

select * from student;

-- Hiển thị tên và mã môn học của những môn có hệ số bằng 1

select * from subjects where priority=1;

-- Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh
select student_id as 'Mã học sinh',
student_name as 'Tên học sinh',
year(curdate())-year(birthday) as 'Tuổi',
case when gender = 1 then 'Nam' else 'Nữ' end as 'Giới tính'  from student;

-- Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần

select s.student_name as 'Tên học sinh',sbj.subject_name as 'Tên môn học',m.point as 'Điểm thi' from mark m
join student s on s.student_id= m.student_id
join subjects sbj on sbj.subject_id=m.subject_id
where sbj.subject_name='Toán' order by m.point desc;

-- Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).

select case when gender=1 then 'Nam' else 'Nữ' end as 'Giới tính', count(*) as 'Số lượng' from student group by gender;

-- Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) , bảng gồm mã học sinh,
-- tên hoc sinh, tổng điểm và điểm trung bình.

select s.student_id as 'Mã học sinh',s.student_name as 'Tên học sinh',sum(m.point) as 'Tổng điểm', avg(m.point) as 'Điểm trung bình'
from mark m
inner join student s on m.student_id =s.student_id group by s.student_id, s.student_name;

-- Tạo View, Index, Procedure
-- Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán .

create view student_view as select student_id as 'Mã học sinh', student_name as 'Tên học sinh',
case when gender =1 then 'Nam' else 'Nữ' end as 'Giới tính',address as 'Quê quán' from student;

-- Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học .

create view AVERAGE_MARK_VIEW as select s.student_id as 'Mã học sinh',s.student_name as 'Tên học sinh',
avg(m.point) as 'Điểm trung bình' from mark m inner join student s on m.student_id =s.student_id
group by s.student_id,s.student_name;

-- Đánh Index cho trường `phoneNumber` của bảng STUDENT.

create index index_phone_number on student(phone_number);

-- Tạo các PROCEDURE sau:
-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.

delimiter //
create procedure PROC_INSERTSTUDENT(
student_id_index varchar(4),
student_name_index varchar(100),
birthday_index date,
gender_index bit,
address_index text,
phone_number_index varchar(45)
)
begin
	insert into student(student_id,student_name,birthday,gender,address,phone_number)
    value(student_id_index,student_name_index,birthday_index,gender_index,address_index,phone_number_index);
    end //
    delimiter ;
    
call PROC_INSERTSTUDENT('S011','Phạm Duy Nhất','1998-4-10',1,'Tuyên Quang','987242678'); 

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.

delimiter //
create procedure PROC_UPDATESUBJECT(
	subject_id_in VARCHAR(4),
	subject_name_in VARCHAR(45)
)
begin
	update subject
	set subject_name = subject_name_index
	where subject_id = subject_id_index;
end //
delimiter ;

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh. 

delimiter //
create procedure PROC_DELETEMARK(
	student_id_index varchar(4)
)
begin
	delete from mark
	where student_id = student_id_index;
end // 
    delimiter ;
    