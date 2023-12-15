DROP TABLE IF EXISTS `MEMBER`;

CREATE TABLE `MEMBER` (
	`USER_ID`	VARCHAR(36 )	NOT NULL primary key	COMMENT '회원 아이디',
	`PASSWORD`	VARCHAR(70)	NOT NULL	COMMENT '회원 비밀번호',
	`EMAIL`	VARCHAR(50 )	NOT NULL	COMMENT '회원 이메일',
	`GRADE`	CHAR(50 )	NULL	DEFAULT 'ROLE_USER'	COMMENT '회원 등급',
	`TELL`	VARCHAR(15 )	NULL	COMMENT '회원 전화번호',
	`IS_LEAVE`	bool	NOT NULL	DEFAULT false	COMMENT '탈퇴여부'
);

DROP TABLE IF EXISTS `BOOK`;

CREATE TABLE `BOOK` (
	`BK_IDX`	int	NOT NULL primary key auto_increment	COMMENT '도서번호',
	`ISBN`	VARCHAR(36 )	NULL	COMMENT 'ISBN코드',
	`CATEGORY`	CHAR(4 )	NULL	COMMENT '도서카테고리',
	`TITLE`	VARCHAR(100 )	NOT NULL	COMMENT '도서명',
	`AUTHOR`	VARCHAR(36 )	NOT NULL	COMMENT '저자',
	`INFO`	VARCHAR(36 )	NULL	COMMENT '도서설명',
	`BOOK_AMT`	int	NULL	DEFAULT 0	COMMENT '도서재고',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '도서등록일자',
	`RENT_CNT`	int	NULL	DEFAULT 0	COMMENT '대출횟수'
);

DROP TABLE IF EXISTS `RENT_BOOK`;

CREATE TABLE `RENT_BOOK` (
	`RB_IDX`	int	NOT NULL primary key auto_increment	COMMENT '대출도서번호',
	`RM_IDX`	int	NOT NULL	COMMENT '대출번호',
	`BK_IDX`	int	NOT NULL	COMMENT '도서번호',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '대출일자',
	`STATE`	VARCHAR(36)	NULL	DEFAULT 'RE00'	COMMENT '대출도서상태',
	`RETURN_DATE`	timestamp	NULL	COMMENT '반납일자'
);

DROP TABLE IF EXISTS `BOARD`;

CREATE TABLE `BOARD` (
	`BD_IDX`	int	NOT NULL primary key auto_increment	COMMENT '게시글번호',
	`USER_ID`	VARCHAR(36 )	NOT NULL	COMMENT '작성자',
	`REG_DATE`	timestamp	NOT NULL	DEFAULT now()	COMMENT '등록일자',
	`TITLE`	VARCHAR(50)	NOT NULL	COMMENT '제목',
	`CONTENT`	VARCHAR(10000 )	NOT NULL	COMMENT '게시글내용',
	`IS_DEL`	bool	NULL	DEFAULT 0	COMMENT '삭제여부'
);

DROP TABLE IF EXISTS `RENT_MASTER`;

CREATE TABLE `RENT_MASTER` (
	`RM_IDX`	int	NOT NULL primary key auto_increment	COMMENT '대출번호',
	`USER_ID`	VARCHAR(36 )	NOT NULL	COMMENT '회원 아이디',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '대출일자',
	`IS_RETURN`	bool	NULL	DEFAULT 0	COMMENT '반납여부',
	`TITLE`	VARCHAR(50)	NOT NULL	COMMENT '대출건제목',
	`RENT_BOOK_CNT`	int	NOT NULL	COMMENT '대출도서권수'
);

DROP TABLE IF EXISTS `CODE`;

CREATE TABLE `CODE` (
	`CODE`	VARCHAR(4 )	NOT NULL primary key COMMENT '코드',
	`UPPER_CODE`	VARCHAR(4 )	NULL	COMMENT '상위코드',
	`INFO`	VARCHAR(100 )	NULL	COMMENT '설명'
);

DROP TABLE IF EXISTS `MEMBER_INFO`;

CREATE TABLE `MEMBER_INFO` (
	`USER_ID`	VARCHAR(36 )	NOT NULL 	COMMENT '회원 아이디',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '가입일자',
	`LOGIN_DATE`	timestamp	NOT NULL	COMMENT '마지막로그인일자',
	`MODIFY_DATE`	timestamp	NOT NULL	COMMENT '마지막수정일자',
	`LEAVE_DATE`	timestamp	NULL	COMMENT '탈퇴일자'
);

ALTER TABLE `MEMBER_INFO` ADD CONSTRAINT `FK_MEMBER_TO_MEMBER_INFO_1` FOREIGN KEY (
	`USER_ID`
)
REFERENCES `MEMBER` (
	`USER_ID`
);

-- MEMBER 테이블 더미 데이터 생성
INSERT INTO MEMBER (USER_ID, PASSWORD, EMAIL, GRADE, TELL, IS_LEAVE)
VALUES
('Socrates', UUID(), 'Socrates@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Plato', UUID(), 'Plato@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Aristotle', UUID(), 'Aristotle@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Immanuel Kant', UUID(), 'ImmanuelKant@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Friedrich Nietzsche', UUID(), 'FriedrichNietzsche@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Jean-Jacques Rousseau', UUID(), 'JeanJacquesRousseau@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Thomas Hobbes', UUID(), 'ThomasHobbes@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('John Locke', UUID(), 'JohnLocke@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Karl Marx', UUID(), 'KarlMarx@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Søren Kierkegaard', UUID(), 'SorenKierkegaard@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Albert Camus', UUID(), 'AlbertCamus@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Jean-Paul Sartre', UUID(), 'JeanPaulSartre@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('René Descartes', UUID(), 'ReneDescartes@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('John Stuart Mill', UUID(), 'JohnStuartMill@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('David Hume', UUID(), 'DavidHume@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Blaise Pascal', UUID(), 'BlaisePascal@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Baruch Spinoza', UUID(), 'BaruchSpinoza@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Georg Wilhelm Friedrich Hegel', UUID(), 'GeorgWilhelmFriedrichHegel@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Arthur Schopenhauer', UUID(), 'ArthurSchopenhauer@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Confucius', UUID(), 'Confucius@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Laozi', UUID(), 'Laozi@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Epicurus', UUID(), 'Epicurus@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Diogenes', UUID(), 'Diogenes@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Seneca', UUID(), 'Seneca@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Heraclitus', UUID(), 'Heraclitus@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Pythagoras', UUID(), 'Pythagoras@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Zeno', UUID(), 'Zeno@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false),
('Marcus Aurelius', UUID(), 'MarcusAurelius2@dev.com', 'ROLE_USER', CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'),  LPAD(FLOOR(RAND() * 10000), 4, '0')), false);

-- MEMBER_INFO 테이블 더미 데이터 생성
INSERT INTO MEMBER_INFO (USER_ID, REG_DATE, LOGIN_DATE, MODIFY_DATE, LEAVE_DATE)
SELECT
    USER_ID,
    DATE_ADD(NOW(), INTERVAL -FLOOR(RAND() * 365) DAY),
    DATE_ADD(NOW(), INTERVAL -FLOOR(RAND() * 365) DAY),
    DATE_ADD(NOW(), INTERVAL -FLOOR(RAND() * 365) DAY),
    NULL
FROM MEMBER;

insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791163560449','B000','(사회초년생, 직장인, 부모님들께 꼭! 들려주고 싶은) 바보아저씨의 경제 이야기 :사회초년생, 직장인, 결혼 시 증여, 노후 부동산까지 생애 생활경제를 총망라한 경제 비법서 .2권','바보아저씨 지음','도서내용',3,  '20/04/01',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788933870839','B000','(설민석의) 삼국지 :누구나 쉽게 시작하고 모두가 빠져드는 이야기 .2','설민석 [지음]','도서내용',3,  '20/04/02',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196067694','B000','12가지 인생의 법칙 :혼돈의 해독제','조던 B. 피터슨 지음','도서내용',3,  '20/04/03',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788947544337','B000','6개월에 천만 원 모으기 :당신의 지갑은 안녕하신가요?: EBS 특별기획 <호모이코노미쿠스>','이대표','도서내용',3,  '20/04/04',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788952240569','B000','가재가 노래하는 곳 :델리아 오언스 장편소설','델리아 오언스 [지음]','도서내용',3,  '20/04/05',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936434311','B000','경애의 마음 :김금희 장편소설','김금희 [지음]','도서내용',3,  '20/04/06',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196316808','B000','공부머리 독서법 :실현 가능하고 지속 가능한 독서교육의 모든 것','최승필 지음','도서내용',3,  '20/04/07',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788990982674','B000','기린의 날개','히가시노 게이고 지음','도서내용',3,  '20/04/08',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934999348','B000','나를 돌보지 않는 나에게 :정여울의 심리테라피','정여울 지음','도서내용',3,  '20/04/09',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791159099694','B000','내가 죽인 남자가 돌아왔다','황세연 지음','도서내용',3,  '20/04/10',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936437978','B000','대도시의 사랑법 :박상영 연작소설','박상영 [지음]','도서내용',3,  '20/04/11',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936437541','B000','디디의 우산 :황정은 연작소설','황정은 [지음]','도서내용',3,  '20/04/12',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788972757573','B000','라플라스의 마녀 :히가시노 게이고 장편소설','히가시노 게이고 [지음]','도서내용',3,  '20/04/13',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788972759546','B000','마력의 태동 :라플라스의 탄생: 히가시노 게이고 소설','히가시노 게이고 [지음]','도서내용',3,  '20/04/14',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788998342296','B000','마법의 돈 굴리기 :자산배분을 이용한 스노우볼 투자법','김성일 지음','도서내용',3,  '20/04/15',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788957369364','B000','무례한 사람에게 웃으며 대처하는 법 :인생 자체는 긍정적으로 개소리에는 단호하게','정문정 지음','도서내용',3,  '20/04/16',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788994702346','B000','부의 추월차선 :부자들이 말해 주지 않는 진정한 부를 얻는 방법','엠제이 드마코 지음','도서내용',3,  '20/04/17',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934981213','B000','생각에 관한 생각 :우리의 행동을 지배하는 생각의 반란','대니얼 카너먼 [지음]','도서내용',3,  '20/04/18',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791157061402','B000','수축사회 :성장 신화를 버려야 미래가 보인다','홍성국 지음','도서내용',3,  '20/04/19',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965961956','B001','숨결이 바람 될 때 :서른여섯 젊은 의사의 마지막 순간','폴 칼라니티 지음','도서내용',3,  '20/04/20',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196722005','B001','시절일기 :우리가 함께 지나온 밤','김연수 지음','도서내용',3,  '20/04/21',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788901219943','B001','신경 끄기의 기술 :인생에서 가장 중요한 것만 남기는 힘','마크 맨슨 지음','도서내용',3,  '20/04/22',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791162540640','B001','아주 작은 습관의 힘 :최고의 변화는 어떻게 만들어지는가','제임스 클리어 지음','도서내용',3,  '20/04/23',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791188388905','B001','에이트 :인공지능에 대체되지 않는 나를 만드는 법 =eight','이지성 지음','도서내용',3,  '20/04/24',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791195322183','B001','완벽하지 않은 것들에 대한 사랑 :온전한 나를 위한 혜민 스님의 따뜻한 응원','혜민 지음','도서내용',3,  '20/04/25',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788950979492','B001','잠중록 :처처칭한 장편소설 .1','처처칭한 [지음]','도서내용',3,  '20/04/26',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788937834790','B001','정의란 무엇인가','마이클 샌델 [저]','도서내용',3,  '20/04/27',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788956609959','B001','종의 기원 :정유정 장편소설 =The origin of species','정유정 [지음]','도서내용',3,  '20/04/28',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788974839840','B001','지도에서 사라진 나라들 :오늘의 세계를 만들고 소멸한 나라들의 역사','도현신 지음','도서내용',3,  '20/04/29',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788901229614','B001','초예측 :세계 석학 8인에게 인류의 미래를 묻다 =Super-forecast','유발 하라리','도서내용',3,  '20/04/30',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788983711892','B001','코스모스','칼 세이건 지음','도서내용',3,  '20/05/01',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788990982278','B001','탐정 갈릴레오 :히가시노 게이고 소설','히가시노 게이고 [지음]','도서내용',3,  '20/05/02',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965707691','B001','포노 사피엔스 :스마트폰이 낳은 신인류 =Phono sapiens','최재붕 지음','도서내용',3,  '20/05/03',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788983925558','B001','해리포터와 마법사의 돌 .제1권','J.K. 롤링 지음','도서내용',3,  '20/05/04',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788932919874','B001','핵을 들고 도망친101세 노인 :요나스 요나손 장편소설','요나스 요나손 [지음]','도서내용',3,  '20/05/05',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788950955779','B001','행복의 기원 :인간의 행복은 어디서 오는가 : 생존과 번식, 행복은 진화의 산물이다','서은국 지음','도서내용',3,  '20/05/06',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791158161026','B001','혼자가 혼자에게 :이병률 산문집','이병률 지음','도서내용',3,  '20/05/07',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788901093154','B002','(똑똑한 선택을 이끄는 힘) 넛지','리처드 탈러','도서내용',3,  '20/05/08',  7); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791186647271','B002','(미국 배당주) 투자지도','서승용 지음','도서내용',3,  '20/05/09',  7); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936434120','B002','소년이 온다 :한강 장편소설','한강 [지음]','도서내용',3,  '20/05/10',  20); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788937473135','B002','82년생 김지영 :조남주 장편소설','조남주 [지음]','도서내용',3,  '20/05/11',  15); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954646079','B002','바깥은 여름 :김애란 소설','김애란 [지음]','도서내용',3,  '20/05/12',  15); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954655972','B002','여행의 이유 :김영하 산문','김영하 [지음]','도서내용',3,  '20/05/13',  15); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788994120997','B002','지적 대화를 위한 넓고 얕은 지식 ,철학, 과학, 예술, 종교, 신비 편','채사장 지음','도서내용',3,  '20/05/14',  15); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788972756194','B002','나미야 잡화점의 기적 :히가시노 게이고 장편소설','히가시노 게이고 지음','도서내용',3,  '20/05/15',  14); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934972464','B002','사피엔스 :유인원에서 사이보그까지, 인간 역사의 대담하고 위대한 질문','유발 하라리 [지음]','도서내용',3,  '20/05/16',  14); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788932916194','B002','창문 넘어 도망친 100세 노인 :요나스 요나손 장편소설','요나스 요나손 [지음]','도서내용',3,  '20/05/17',  15); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965746829','B002','천년의 질문 :조정래 장편소설 .1','조정래 [저]','도서내용',3,  '20/05/18',  14); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791188020751','B002','(역사·철학·문화를 스토리텔링으로 엮은) 1800자 한자(漢字) :중고생·공무원 한문 학습 기본서','송영일 지음','도서내용',3,  '20/05/19',  13); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954645614','B002','오직 두 사람 :김영하 소설 : 그 두 사람, 오직 두 사람만이 느꼈을 어떤 어둠에 대해서','김영하 [지음]','도서내용',3,  '20/05/20',  13); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954636858','B002','최선의 삶 :임솔아 장편소설','임솔아 지음','도서내용',3,  '20/05/21',  13); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954637756','B002','개인주의자 선언 :판사 문유석의 일상유감','문유석 [지음]','도서내용',3,  '20/05/22',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788984373617','B002','아가씨와 밤 :기욤 뮈소 장편소설','기욤 뮈소 [지음]','도서내용',3,  '20/05/23',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791160486735','B002','완벽한 공부법 :모든 공부의 최고의 지침서','고영성','도서내용',3,  '20/05/24',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791170400011','B003','잊기 좋은 이름 :김애란 산문','김애란 [지음]','도서내용',3,  '20/05/25',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788994120966','B003','지적 대화를 위한 넓고 얕은 지식 .[2] ,역사, 경제, 정치, 사회, 윤리 편','채사장 지음','도서내용',3,  '20/05/26',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965746836','B003','천년의 질문 :조정래 장편소설 .2','조정래 [저]','도서내용',3,  '20/05/27',  12); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788950973759','B003','곰탕 :김영탁 장편소설 .1 ,미래에서 온 살인자','김영탁 [지음]','도서내용',3,  '20/05/28',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788901230801','B003','나의 월급 독립 프로젝트 :3년 만에 30억 벌고 퇴사한 슈퍼개미의 실전 주식투자 생중계','유목민 지음','도서내용',3,  '20/05/29',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934995791','B003','대변동 :위기, 선택, 변화: 무엇을 선택하고 어떻게 변화할 것인가','재레드 다이아몬드 지음','도서내용',3,  '20/06/01',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788998274795','B003','돌이킬 수 없는 약속 :야쿠마루 가쿠 장편소설','야쿠마루 가쿠 지음','도서내용',3,  '20/06/02',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788990982810','B003','살인 현장은 구름 위','히가시노 게이고 지음','도서내용',3,  '20/06/03',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965132288','B003','어떻게 살 것인가','유시민 [지음]','도서내용',3,  '20/06/04',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791186560952','B003','이제껏 너를 친구라고 생각했는데 :친구가 친구가 아니었음을 깨달은 당신을 위한 관계심리학','성유미 지음','도서내용',3,  '20/06/05',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965746843','B003','천년의 질문 :조정래 장편소설 .3','조정래 [저]','도서내용',3,  '20/06/06',  11); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788954653817','B003','걷는 사람, 하정우','하정우 글·사진','도서내용',3,  '20/06/07',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791187498384','B003','고요할수록 밝아지는 것들 :혜민 스님과 함께 지혜와 평온으로 가는 길','혜민 지음','도서내용',3,  '20/06/08',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791189932084','B003','나는 내 파이를 구할 뿐 인류를 구하러 온 게 아니라고 :자기 몫을 되찾고 싶은 여성들을 위한 야망 에세이','김진아 지음','도서내용',3,  '20/06/09',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788952773487','B003','나는 부동산과 맞벌이한다 :배우자 대신 꼬박꼬박 월급을 가져오는 시스템 만들기','너바나 지음','도서내용',3,  '20/06/10',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788998441074','B004','나는 소망한다 내게 금지된 것을 :양귀자 장편소설','양귀자 [지음]','도서내용',3,  '20/06/11',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791155426586','B004','난생처음 내 아파트 갖기 :처음이지만 내 집 잘 고르고 싶은 당신을 위한 부동산 맞춤 가이드','카스파파 지음','도서내용',3,  '20/06/12',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196625900','B004','다시 부동산을 생각한다 :부동산 규제 시대, 세그먼트가 답이다','채상욱 지음','도서내용',3,  '20/06/13',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791190182591','B004','루거 총을 든 할머니 :브누아 필리퐁 장편소설','브누아 필리퐁 [지음]','도서내용',3,  '20/06/14',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936434267','B004','아몬드 :손원평 장편소설','손원평 [지음]','도서내용',3,  '20/06/15',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788935703463','B004','왓칭 : 신이 부리는 요술 =Watching','김상운 지음','도서내용',3,  '20/06/16',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788990982773','B004','인어가 잠든 집','히가시노 게이고 [지음]','도서내용',3,  '20/06/17',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965708339','B004','직지 :아모르 마네트. 김진명 장편소설 .2','김진명 [지음]','도서내용',3,  '20/06/18',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788936433598','B004','채식주의자 :한강 연작소설','한강 [지음]','도서내용',3,  '20/06/19',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788937473166','B004','해가 지는 곳으로 :최진영 장편소설','최진영 [지음]','도서내용',3,  '20/06/20',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934977841','B004','호모 데우스 :미래의 역사','유발 하라리 [지음]','도서내용',3,  '20/06/21',  10); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788960516175','B004','검사내전 :생활형 검사의 사람 공부, 세상 공부','김웅 지음','도서내용',3,  '20/06/22',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788990982780','B004','기도의 막이 내릴 때','히가시노 게이고 [지음]','도서내용',3,  '20/06/23',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791187119845','B004','나는 나로 살기로 했다 :냉담한 현실에서 어른살이를 위한 to do list','김수현 글·그림','도서내용',3,  '20/06/24',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791130621128','B005','대한민국 청약지도 :한 권으로 끝내는 청약 당첨 전략의 모든 것','정지영 지음','도서내용',3,  '20/06/25',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791162202913','B005','모든 순간이 너였다 :하태완 에세이','하태완 [지음]','도서내용',3,  '20/06/26',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791190065672','B005','박막례, 이대로 죽을순 없다','박막례','도서내용',3,  '20/06/27',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788934984566','B005','사소한 변화','히가시노 게이고 [지음]','도서내용',3,  '20/06/28',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788937441912','B005','산 자들 :장강명 연작소설','장강명 [지음]','도서내용',3,  '20/06/29',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788933870693','B005','설민석의 조선왕조실록 :대한민국이 선택한 역사 이야기','설민석 [지음]','도서내용',3,  '20/06/30',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788956056531','B005','여덟 단어 :인생을 대하는 우리의 자세','박웅현 지음','도서내용',3,  '20/07/01',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965133520','B005','유시민의 글쓰기 특강','유시민 지음','도서내용',3,  '20/07/02',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788984371071','B005','종이 여자 :기욤 뮈소 장편소설','기욤 뮈소 지음','도서내용',3,  '20/07/03',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196394509','B005','죽고 싶지만 떡볶이는 먹고 싶어 :백세희 에세이','백세희 [지음]','도서내용',3,  '20/07/04',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791196797706','B005','지쳤거나 좋아하는 게 없거나','글배우 지음','도서내용',3,  '20/07/05',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788965708322','B005','직지 :아모르 마네트. 김진명 장편소설 .1','김진명 [지음]','도서내용',3,  '20/07/06',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788970128856','B005','총, 균, 쇠 :무기, 병균, 금속은 인류의 운명을 어떻게 바꿨는가','재레드 다이아몬드 지음','도서내용',3,  '20/07/07',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9788901223032','B005','하마터면 열심히 살 뻔했다 :야매 득도 에세이','하완 지음','도서내용',3,  '20/07/08',  9); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791135422225','B005','(50대 사건으로 보는) 돈의 역사 =The history of Money','홍춘욱 지음','도서내용',3,  '20/07/09',  8); 
 insert into book(isbn, category, title, author, info, book_amt, reg_date, rent_cnt) values('9791188248674','B005','(간단함, 병맛, 솔직함으로 기업의 흥망성쇠를 좌우하는) 90년생이 온다','임홍택 지음','도서내용',3,  '20/07/10',  8); 
commit;

INSERT INTO BOARD (USER_ID, REG_DATE, TITLE, CONTENT, IS_DEL)
SELECT
    USER_ID,
    NOW(),
    CONCAT(USER_ID, '의 명언'),
    CASE
        WHEN USER_ID = 'Socrates' THEN '지혜란 자신의 무지를 안다는 것이다.'
        WHEN USER_ID = 'Plato' THEN '사람은 알지 못하는 것에 대해 묻고, 철학자는 아는 것에 대해 묻는다.'
        WHEN USER_ID = 'Aristotle' THEN '무엇을 배워야 할 지 알려주고, 왜 그런 것을 배워야 하는 지도 가르쳐라.'
        WHEN USER_ID = 'Immanuel Kant' THEN '성실함은 천재를 대체할 수 있는 유일한 것이다.'
        WHEN USER_ID = 'Friedrich Nietzsche' THEN '네 자신을 찾아라. 다른 누구의 흉내를 내지 마라.'
        WHEN USER_ID = 'Jean-Jacques Rousseau' THEN '사람들은 만족스러운 삶을 살기 위해 노력해야 한다.'
        WHEN USER_ID = 'Thomas Hobbes' THEN '인간은 자신의 이익을 위해 국가에 복종해야 한다.'
        WHEN USER_ID = 'John Locke' THEN '모든 사람들은 평등하게 태어났다.'
        WHEN USER_ID = 'Karl Marx' THEN '노동자들이여, 당신들은 모든 국가에서 연합하라.'
        WHEN USER_ID = 'Søren Kierkegaard' THEN '인간은 믿음을 통해 이성을 초월할 수 있다.'
        WHEN USER_ID = 'Albert Camus' THEN '인생은 혼란과 의미 없는 것이다.'
        WHEN USER_ID = 'Jean-Paul Sartre' THEN '존재는 본질에 앞서간다.'
        WHEN USER_ID = 'René Descartes' THEN '나는 생각한다, 고로 나는 존재한다.'
        WHEN USER_ID = 'John Stuart Mill' THEN '자유는 다른 모든 가치의 기초이자 꼭두각시이다.'
        WHEN USER_ID = 'David Hume' THEN '모든 지식은 경험에서 유래된다.'
        WHEN USER_ID = 'Blaise Pascal' THEN '하나님의 존재는 이성으로는 증명할 수 없다.'
        WHEN USER_ID = 'Baruch Spinoza' THEN '인간은 자연의 일부로서 존재한다.'
        WHEN USER_ID = 'Georg Wilhelm Friedrich Hegel' THEN '진리는 전체에 머물러 있다.'
        WHEN USER_ID = 'Arthur Schopenhauer' THEN '인간은 욕망의 불만으로부터 고통받는다.'
        WHEN USER_ID = 'Confucius' THEN '미움을 품고 있는 동안에는 어떠한 좋은 행동도 할 수 없다.'
        WHEN USER_ID = 'Laozi (Lao Tzu)' THEN '최고의 지도자는 사람들이 모르는 것처럼 하는 것이다.'
        WHEN USER_ID = 'Epicurus' THEN '즐거움은 최고의 목적이다.'
        WHEN USER_ID = 'Diogenes' THEN '빈곤은 자유다.'
        WHEN USER_ID = 'Seneca' THEN '진정으로 부유한 사람은 만족하는 사람이다.'
        WHEN USER_ID = 'Heraclitus' THEN '모든 것은 변하고, 아무것도 영원하지 않다.'
        WHEN USER_ID = 'Pythagoras' THEN '수는 모든 것의 근원이다.'
        WHEN USER_ID = 'Zeno of Citium' THEN '우리가 통제할 수 없는 것에 대해 걱정하지 말라.'
        WHEN USER_ID = 'Marcus Aurelius' THEN '당신이 가진 일을 사랑하라, 그것이 당신의 일이다.'
    END AS CONTENT,
    0
FROM (
    SELECT 'Socrates' AS USER_ID
    UNION SELECT 'Plato'
    UNION SELECT 'Aristotle'
    UNION SELECT 'Immanuel Kant'
    UNION SELECT 'Friedrich Nietzsche'
    UNION SELECT 'Jean-Jacques Rousseau'
    UNION SELECT 'Thomas Hobbes'
    UNION SELECT 'John Locke'
    UNION SELECT 'Karl Marx'
    UNION SELECT 'Søren Kierkegaard'
    UNION SELECT 'Albert Camus'
    UNION SELECT 'Jean-Paul Sartre'
    UNION SELECT 'René Descartes'
    UNION SELECT 'John Stuart Mill'
    UNION SELECT 'David Hume'
    UNION SELECT 'Blaise Pascal'
    UNION SELECT 'Baruch Spinoza'
    UNION SELECT 'Georg Wilhelm Friedrich Hegel'
    UNION SELECT 'Arthur Schopenhauer'
    UNION SELECT 'Confucius'
    UNION SELECT 'Laozi (Lao Tzu)'
    UNION SELECT 'Epicurus'
    UNION SELECT 'Diogenes'
    UNION SELECT 'Seneca'
    UNION SELECT 'Epicurus'
    UNION SELECT 'Heraclitus'
    UNION SELECT 'Pythagoras'
    UNION SELECT 'Zeno of Citium'
    UNION SELECT 'Epicurus'
    UNION SELECT 'Marcus Aurelius'
) AS USERS;


-- RENT_MASTER 테이블 더미 데이터 생성
INSERT INTO RENT_MASTER (USER_ID, REG_DATE, IS_RETURN, TITLE, RENT_BOOK_CNT)
VALUES
    ('Søren Kierkegaard', '2023-06-16 00:00:00', 1, '내가 죽인 남자가 돌아왔다', 1),
    ('Albert Camus', '2023-06-21 00:00:00', 1, '시절일기 :우리가 함께 지나온 밤 외 1권', 2),
    ('Jean-Paul Sartre', '2023-06-26 00:00:00', 1, '내가 죽인 남자가 돌아왔다 외 1권', 2),
    ('René Descartes', '2023-06-16 00:00:00', 0, '디디의 우산 :황정은 연작소설', 1),
    ('John Stuart Mill', '2023-06-07 00:00:00', 0, '대도시의 사랑법', 1),
    ('David Hume', '2023-06-29 00:00:00', 1, '디디의 우산 :황정은 연작소설 외 2권', 3),
    ('Blaise Pascal', '2023-06-16 00:00:00', 1, '대도시의 사랑법', 1);


INSERT INTO RENT_BOOK (RM_IDX, BK_IDX, REG_DATE, STATE, RETURN_DATE)
VALUES
    (4, 12, '2023-06-18 00:00', 'RE01', '2023-06-19 00:00'),
    (6, 12, '2023-06-28 00:00', 'RE02', '2023-06-30 00:00'),
    (6, 10, '2023-06-28 00:00', 'RE02', '2023-06-30 00:00'),
    (6, 1, '2023-06-28 00:00', 'RE02', '2023-06-30 00:00'),
    (1, 10, '2023-06-09 00:00', 'RE02', '2023-06-14 00:00'),
    (2, 21, '2023-06-07 00:00', 'RE02', '2023-06-11 00:00'),
    (2, 1, '2023-06-07 00:00', 'RE02', '2023-06-11 00:00'),
    (3, 10, '2023-06-15 00:00', 'RE02', '2023-06-18 00:00'),
    (3, 2, '2023-06-15 00:00', 'RE02', '2023-06-18 00:00'),
    (5, 11, '2023-06-05 00:00', 'RE01', '2023-06-06 00:00'),
    (7, 11, '2023-06-08 00:00', 'RE01', '2023-06-10 00:00');


INSERT INTO CODE (CODE, UPPER_CODE, INFO) VALUES
    ('B', NULL, '도서분야'),
    ('B001', 'B', '소설'),
    ('B002', 'B', '시'),
    ('B003', 'B', '수필'),
    ('B004', 'B', '전문서적'),
    ('B005', 'B', '자기계발서'),
    ('RE', NULL, '대출상태'),
    ('RE01', 'RE', '대출 중'),
    ('RE02', 'RE', '연체'),
    ('RE03', 'RE', '반납');