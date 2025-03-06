------------------------------------------------------------------------
------------------------------------------------------------------------
-- Insert into liat.t_depart
------------------------------------------------------------------------
------------------------------------------------------------------------
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('A00', 'SPIFFY COMPUTER SERVICE DIV.', '000010', null);
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('B01', 'PLANNING', '000020', 'A00');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('C01', 'INFORMATION CENTER', '000030', 'A00');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('D01', 'DEVELOPMENT CENTER', null, 'A00');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('E01', 'SUPPORT SERVICES', '000050', 'A00');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('D11', 'MANUFACTURING SYSTEMS', '000060', 'D01');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('D21', 'ADMINISTRATION SYSTEMS', '000070', 'D01');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('E11', 'OPERATIONS', '000090', 'E01');
insert into LIAT.T_DEPART (DEPTNO, DEPTNAME, MGRNO, ADMRDEPT)
values ('E21', 'SOFTWARE SUPPORT', '000100', 'E01');
commit;

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Insert into liat.t_empl
------------------------------------------------------------------------
------------------------------------------------------------------------
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000270', 'MARIA', 'PEREZ', 'D21', to_date('30-09-1980', 'dd-mm-yyyy'), 'CLERK', 15, 'F', to_date('26-05-1953', 'dd-mm-yyyy'), 27380, 500, 2190);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000280', 'ETHEL', 'SCHNEIDER', 'E11', to_date('24-03-1967', 'dd-mm-yyyy'), 'OPERATOR', 17, 'F', to_date('28-03-1936', 'dd-mm-yyyy'), 26250, 500, 2100);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000290', 'JOHN', 'PARKER', 'E11', to_date('30-05-1980', 'dd-mm-yyyy'), 'OPERATOR', 12, 'M', to_date('09-07-1946', 'dd-mm-yyyy'), 15340, 300, 1227);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000300', 'PHILIP', 'SMITH', 'E11', to_date('19-06-1972', 'dd-mm-yyyy'), 'OPERATOR', 14, 'M', to_date('27-10-1936', 'dd-mm-yyyy'), 17750, 400, 1420);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000310', 'MAUDE', 'SETRIGHT', 'E11', to_date('12-09-1964', 'dd-mm-yyyy'), 'OPERATOR', 12, 'F', to_date('21-04-1931', 'dd-mm-yyyy'), 15900, 300, 1272);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000320', 'RAMLAL', 'MEHTA', 'E21', to_date('07-07-1965', 'dd-mm-yyyy'), 'FIELDREP', 16, 'M', to_date('11-08-1932', 'dd-mm-yyyy'), 19950, 400, 1596);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000330', 'WING', 'LEE', 'E21', to_date('23-02-1976', 'dd-mm-yyyy'), 'FIELDREP', 14, 'M', to_date('18-07-1941', 'dd-mm-yyyy'), 25370, 500, 2030);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000340', 'JASON', 'GOUNOT', 'E21', to_date('05-05-1947', 'dd-mm-yyyy'), 'FIELDREP', 16, 'M', to_date('17-05-1926', 'dd-mm-yyyy'), 23840, 500, 1907);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200010', 'DIAN', 'HEMMINGER', 'A00', to_date('01-01-1965', 'dd-mm-yyyy'), 'SALESREP', 18, 'F', to_date('14-08-1933', 'dd-mm-yyyy'), 46500, 1000, 4220);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200120', 'GREG', 'ORLANDO', 'A00', to_date('05-05-1972', 'dd-mm-yyyy'), 'CLERK', 14, 'M', to_date('18-10-1942', 'dd-mm-yyyy'), 29250, 600, 2340);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200140', 'KIM', 'NATZ', 'C01', to_date('15-12-1976', 'dd-mm-yyyy'), 'ANALYST', 18, 'F', to_date('19-01-1946', 'dd-mm-yyyy'), 28420, 600, 2274);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200170', 'KIYOSHI', 'YAMAMOTO', 'D11', to_date('15-09-1978', 'dd-mm-yyyy'), 'DESIGNER', 16, 'M', to_date('05-01-1951', 'dd-mm-yyyy'), 24680, 500, 1974);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200220', 'REBA', 'JOHN', 'D11', to_date('29-08-1968', 'dd-mm-yyyy'), 'DESIGNER', 18, 'F', to_date('19-03-1948', 'dd-mm-yyyy'), 29840, 600, 2387);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200240', 'ROBERT', 'MONTEVERDE', 'D21', to_date('05-12-1979', 'dd-mm-yyyy'), 'CLERK', 17, 'M', to_date('31-03-1954', 'dd-mm-yyyy'), 28760, 600, 2301);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200280', 'EILEEN', 'SCHWARTZ', 'E11', to_date('24-03-1967', 'dd-mm-yyyy'), 'OPERATOR', 17, 'F', to_date('28-03-1936', 'dd-mm-yyyy'), 26250, 500, 2100);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200310', 'MICHELLE', 'SPRINGER', 'E11', to_date('12-09-1964', 'dd-mm-yyyy'), 'OPERATOR', 12, 'F', to_date('21-04-1931', 'dd-mm-yyyy'), 15900, 300, 1272);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200330', 'HELENA', 'WONG', 'E21', to_date('23-02-1976', 'dd-mm-yyyy'), 'FIELDREP', 14, 'F', to_date('18-07-1941', 'dd-mm-yyyy'), 25370, 500, 2030);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200340', 'ROY', 'ALONZO', 'E21', to_date('05-05-1947', 'dd-mm-yyyy'), 'FIELDREP', 16, 'M', to_date('17-05-1926', 'dd-mm-yyyy'), 23840, 500, 1907);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('200350', 'UDI', 'ILAN', 'A00', to_date('29-03-2005', 'dd-mm-yyyy'), 'MANAGER', 16, 'M', to_date('07-06-1984', 'dd-mm-yyyy'), 35480, 600, 2542);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000010', 'CHRISTINE', 'HAAS', 'A00', to_date('01-01-1965', 'dd-mm-yyyy'), 'PRES', 18, 'F', to_date('14-08-1933', 'dd-mm-yyyy'), 52750, 1000, 4220);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000020', 'MICHAEL', 'THOMPSON', 'B01', to_date('10-10-1973', 'dd-mm-yyyy'), 'MANAGER', 18, 'M', to_date('02-02-1948', 'dd-mm-yyyy'), 41250, 800, 3300);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000030', 'SALLY', 'KWAN', 'C01', to_date('05-04-1975', 'dd-mm-yyyy'), 'MANAGER', 20, 'F', to_date('11-05-1941', 'dd-mm-yyyy'), 38250, 800, 3060);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000050', 'JOHN', 'GEYER', 'E01', to_date('17-08-1949', 'dd-mm-yyyy'), 'MANAGER', 16, 'M', to_date('15-09-1925', 'dd-mm-yyyy'), 40175, 800, 3214);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000060', 'IRVING', 'STERN', 'D11', to_date('14-09-1973', 'dd-mm-yyyy'), 'MANAGER', 16, 'M', to_date('07-07-1945', 'dd-mm-yyyy'), 32250, 600, 2580);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000070', 'EVA', 'PULASKI', 'D21', to_date('30-09-1980', 'dd-mm-yyyy'), 'MANAGER', 16, 'F', to_date('26-05-1953', 'dd-mm-yyyy'), 36170, 700, 2893);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000090', 'EILEEN', 'HENDERSON', 'E11', to_date('15-08-1970', 'dd-mm-yyyy'), 'MANAGER', 16, 'F', to_date('15-05-1941', 'dd-mm-yyyy'), 29750, 600, 2380);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000100', 'THEODORE', 'SPENSER', 'E21', to_date('19-06-1980', 'dd-mm-yyyy'), 'MANAGER', 14, 'M', to_date('18-12-1956', 'dd-mm-yyyy'), 26150, 500, 2092);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000110', 'VINCENZO', 'LUCCHESI', 'A00', to_date('16-05-1958', 'dd-mm-yyyy'), 'SALESREP', 19, 'M', to_date('05-11-1929', 'dd-mm-yyyy'), 46500, 900, 3720);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000120', 'SEAN', 'O''CONNELL', 'A00', to_date('05-12-1963', 'dd-mm-yyyy'), 'CLERK', 14, 'M', to_date('18-10-1942', 'dd-mm-yyyy'), 29250, 600, 2340);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000130', 'DOLORES', 'QUINTANA', 'C01', to_date('28-07-1971', 'dd-mm-yyyy'), 'ANALYST', 16, 'F', to_date('15-09-1925', 'dd-mm-yyyy'), 23800, 500, 1904);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000140', 'HEATHER', 'NICHOLLS', 'C01', to_date('15-12-1976', 'dd-mm-yyyy'), 'ANALYST', 18, 'F', to_date('19-01-1946', 'dd-mm-yyyy'), 28420, 600, 2274);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000150', 'BRUCE', 'ADAMSON', 'D11', to_date('12-02-1972', 'dd-mm-yyyy'), 'DESIGNER', 16, 'M', to_date('17-05-1947', 'dd-mm-yyyy'), 25280, 500, 2022);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000160', 'ELIZABETH', 'PIANKA', 'D11', to_date('11-10-1977', 'dd-mm-yyyy'), 'DESIGNER', 17, 'F', to_date('12-04-1955', 'dd-mm-yyyy'), 22250, 400, 1780);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000170', 'MASATOSHI', 'YOSHIMURA', 'D11', to_date('15-09-1978', 'dd-mm-yyyy'), 'DESIGNER', 16, 'M', to_date('05-01-1951', 'dd-mm-yyyy'), 24680, 500, 1974);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000180', 'MARILYN', 'SCOUTTEN', 'D11', to_date('07-07-1973', 'dd-mm-yyyy'), 'DESIGNER', 17, 'F', to_date('21-02-1949', 'dd-mm-yyyy'), 21340, 500, 1707);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000190', 'JAMES', 'WALKER', 'D11', to_date('26-07-1974', 'dd-mm-yyyy'), 'DESIGNER', 16, 'M', to_date('25-06-1952', 'dd-mm-yyyy'), 20450, 400, 1636);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000200', 'DAVID', 'BROWN', 'D11', to_date('03-03-1966', 'dd-mm-yyyy'), 'DESIGNER', 16, 'M', to_date('29-05-1941', 'dd-mm-yyyy'), 27740, 600, 2217);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000210', 'WILLIAM', 'JONES', 'D11', to_date('11-04-1979', 'dd-mm-yyyy'), 'DESIGNER', 17, 'M', to_date('23-02-1953', 'dd-mm-yyyy'), 18270, 400, 1462);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000220', 'JENNIFER', 'LUTZ', 'D11', to_date('29-08-1968', 'dd-mm-yyyy'), 'DESIGNER', 18, 'F', to_date('19-03-1948', 'dd-mm-yyyy'), 29840, 600, 2387);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000230', 'JAMES', 'JEFFERSON', 'D21', to_date('21-11-1966', 'dd-mm-yyyy'), 'CLERK', 14, 'M', to_date('30-05-1935', 'dd-mm-yyyy'), 22180, 400, 1774);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000240', 'SALVATORE', 'MARINO', 'D21', to_date('05-12-1979', 'dd-mm-yyyy'), 'CLERK', 17, 'M', to_date('31-03-1954', 'dd-mm-yyyy'), 28760, 600, 2301);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000250', 'DANIEL', 'SMITH', 'D21', to_date('30-10-1969', 'dd-mm-yyyy'), 'CLERK', 15, 'M', to_date('12-11-1939', 'dd-mm-yyyy'), 19180, 400, 1534);
insert into LIAT.T_EMPL (EMPNO, FIRSTNAME, LASTNAME, DEPTNO, HIREDATE, JOB, EDLEVEL, SEX, BIRTHDATE, SALARY, BONUS, COMM)
values ('000260', 'SYBIL', 'JOHNSON', 'D21', to_date('11-09-1975', 'dd-mm-yyyy'), 'CLERK', 16, 'F', to_date('05-10-1936', 'dd-mm-yyyy'), 17250, 300, 1380);
commit;

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Insert into liat.t_proj
------------------------------------------------------------------------
------------------------------------------------------------------------
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('AD3100', 'ADMIN SERVICES', 'D01', '000010', 6.5, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('MA2100', 'WELD LINE AUTOMATION', 'D01', '000010', 12, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('PL2100', 'WELD LINE PLANNING', 'B01', '000020', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('15-09-1982', 'dd-mm-yyyy'), 'MA2100');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('IF1000', 'QUERY SERVICES', 'C01', '000030', 2, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('IF2000', 'USER EDUCATION', 'C01', '000030', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP1000', 'OPERATION SUPPORT', 'E01', '000050', 6, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP2000', 'GEN SYSTEMS SERVICES', 'E01', '000050', 5, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), null);
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('MA2110', 'W L PROGRAMMING', 'D11', '000060', 9, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'MA2100');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('AD3110', 'GENERAL AD SYSTEMS', 'D21', '000070', 6, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'AD3100');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP1010', 'OPERATION', 'E11', '000090', 5, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'OP1000');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP2010', 'SYSTEMS SUPPORT', 'E21', '000100', 4, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'OP2000');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('MA2112', 'W L ROBOT DESIGN', 'D11', '000150', 3, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-12-1982', 'dd-mm-yyyy'), 'MA2110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('MA2113', 'W L PROD CONT PROGS', 'D11', '000160', 3, to_date('15-02-1982', 'dd-mm-yyyy'), to_date('01-12-1982', 'dd-mm-yyyy'), 'MA2110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('MA2111', 'W L PROGRAM DESIGN', 'D11', '000220', 2, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-12-1982', 'dd-mm-yyyy'), 'MA2110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('AD3111', 'PAYROLL PROGRAMMING', 'D21', '000230', 2, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'AD3110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('AD3112', 'PERSONNEL PROGRAMMG', 'D21', '000250', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'AD3110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('AD3113', 'ACCOUNT.PROGRAMMING', 'D21', '000270', 2, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'AD3110');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP2011', 'SCP SYSTEMS SUPPORT', 'E21', '000320', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'OP2010');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP2012', 'APPLICATIONS SUPPORT', 'E21', '000330', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'OP2010');
insert into LIAT.T_PROJ (PROJNO, PROJNAME, DEPTNO, RESPEMP, PRSTAFF, PRSTDATE, PRENDATE, MAJPROJ)
values ('OP2013', 'DB/DC SUPPORT', 'E21', '000340', 1, to_date('01-01-1982', 'dd-mm-yyyy'), to_date('01-02-1983', 'dd-mm-yyyy'), 'OP2010');
commit;