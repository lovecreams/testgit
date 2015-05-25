-- 1. Viet cau lenh tao bang person_mail
 
CREATE TABLE PERSON_YENNTH8
    (ps_id                          NUMBER(10,0) ,
    name                           VARCHAR2(50 BYTE),
    age                            NUMBER(3,0),
    addr                           VARCHAR2(100 BYTE),
    sex                            NUMBER(1,0))
 
/
--==================================Bai 2 ================================================
--2a. Doi ten bang thanh PERSONNEL_MAIL
alter table PERSON_YENNTH8 rename to PERSONNEL_YENNTH8;

-- 2B. Doi ten cot SEX thanh GENDER
alter table PERSONNEL_YENNTH8 rename column SEX to GENDER;

-- 2C. Them cot BIRTH_DAY kieu DATE
ALTER TABLE PERSONNEL_YENNTH8
ADD BIRTH_DAY DATE;

-- 2d. Them du lieu vao bang
insert into PERSONNEL_YENNTH8 (ps_id,name,age,addr,GENDER,BIRTH_DAY) 
    values (1, 'Nguyen Thi Hai Yen', 29, 'CT6 - Xa La', 0, to_date('23/05/1987','dd/mm/yyyy'));
commit;
-- 2e. Xoa du lieu bang 2 cach
-- cach 1:
Delete PERSONNEL_YENNTH8;
-- cach 2
TRUNCATE TABLE PERSONNEL_YENNTH8; 
-- 2.f: xoa bang

Drop TABLE PERSONNEL_YENNTH8;
--============================================= Bai 3 ===================================================================
-- 3.1 Liet ke ten va luong cua nhan vien co luong > 1000
select last_name, salary from dt_employee where salary > 1000;

-- 3.2 Liet ke ten va luong cua nhan vien co luong < 500 hoac >1000
select last_name, salary from dt_employee where  salary < 500 or salary > 1000;

-- 3.3 Thong tin nhan vien duoc thue tu 20/02/2010 den 01/05/2010. ngay thue tang dan
select * from dt_employee where hire_date BETWEEN to_date ('20/02/2010','dd/mm/yyyy') and to_date('01/05/2010','dd/mm/yyyy')
order by hire_date
/

-- 3.4 liet ke danh sach nhan vien lam viec cho phong 1 va phong 3

select emp.last_name, dept.dept_id department_id  from dt_employee emp inner join dt_department dept on emp.dept_id = dept.dept_id
where emp.dept_id = 1 or emp.dept_id = 3
order by last_name;
-- 3.5 Liet ke danh sach nhan vien khong co nguoi quan ly
select * from dt_employee where manage_id is null
/
-- 3.6 Liet ke danh sach nhan vien trong ten co chu 'a'

select * from dt_employee where last_name like '%a%'
/
-- 3.7 Cho biet ma nhan vien, ten nhan vien, luong sau khi tang them 15% so voi luong ban dau, dc lam cho toi hang don vi va dat lai cot la new_salary

select employee_code, last_name, round(salary*1.15,0) new_salary from dt_employee
/
-- 3.8 Liet ke thong tin (ma, ten)nhan vien cung nguoi quan ly

select emp.employee_code , emp.last_name, man.employee_code manage_code, man.last_name manage_name from dt_employee emp inner join dt_employee man on emp.manage_id = man.employee_id;

-- 3.9 Liet ke danh sach nhung nhan vien cung phong

select emp.employee_code , emp.last_name, emp.dept_id from dt_employee emp 
order by dept_id
/
-- 3.10  Cho biet luong thap nhat, luong cao nhat, luong trung binh tung phong
select max(salary) max_salary, min(salary) min_salary, avg(salary)avg_salary, dept_id from dt_employee
where dept_id is not null
group by dept_id
/
-- 3.11 cho biet ma phong, ten phong, so luong nhan vien tung phong

select dept.dept_code, dept.dept_name, count(emp.employee_id) total_employee
 from dt_employee emp inner join dt_department dept on emp.dept_id = dept.dept_id
group by dept_code, dept_name

-- 3.12 Liet ke danh sach nhan vien co nguoi quan ly la 'King'

select emp.* from dt_employee emp inner join dt_employee man on emp.manage_id = man.employee_id
where man.last_name = 'King'
/
-- 3.13 Liet ke thong tin 3 nhan vien co luong cao nhat
select * from (select * from dt_employee order by salary desc)
where rownum < 4
/
-- 3.14 cap nhat ten cua nhan vien co ma 3 thanh 'Drexler'
update dt_employee set last_name = 'Drexler' where employee_code = 3
/

-- 3.15 Tang them 100$ cho nhan vien co luong < 500$
update dt_employee set salary = salary+100 where salary < 500

-- 3.16 xoa phong ban 5

delete dt_department where dept_id = 5

-- Xoa phong ban nao chua co nhan vien

delete dt_department where dept_id not in (select distinct dept_id from dt_employee)
/
--select * from dt_department where dept_id not in (select distinct dept_id from dt_employee)


