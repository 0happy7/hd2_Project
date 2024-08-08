drop database hd2;
create database hd2;
use hd2;

/* 테이블 생성 */
create table user (
	userno int auto_increment primary key comment '회원번호',
	userid varchar(20) comment '아이디',
	userpw varchar(255) comment '비밀번호',
	uname varchar(30) comment '이름',
	gender varchar(2) comment '성별',
	email varchar(50) comment '이메일',
	uwdate datetime default now() comment '가입날짜',
	isretire varchar(2) default 'N' comment '탈퇴여부',
	ugrade int default '1' comment '회원 등급',
	reason varchar(255) comment '탈퇴사유',
    withdrawaldate datetime comment '탈퇴일',
	adminmemo varchar(255) default '정상회원' comment '관리자메모'
);

CREATE TABLE entity (
    entityid int primary key auto_increment comment '엔티티 ID',
    entitytype varchar(10) comment '엔티티 타입 (item 또는 board)'
);
ALTER TABLE entity ADD INDEX idx_entity_type (entitytype);
ALTER TABLE entity ADD INDEX idx_entity_id (entityid);

INSERT INTO entity (entitytype) values ("board");
INSERT INTO entity (entitytype) values ("item");

create table board (
	bno int auto_increment primary key comment '게시물 번호',
	userno int comment '회원 번호',
	bkind varchar(3) comment '게시판종류',
	name varchar(50) comment '회원이름',
	bname varchar(50) comment '제목',
	addr varchar(100) comment '주소',
	area varchar(10) comment '지역명',
	tel varchar(20) comment '전화번호1',
	tel1 varchar(20) comment '전화번호2',
	tel2 varchar(20) comment '전화번호3',
	btime1 varchar(30) comment '영업시간시작',
	btime2 varchar(30) comment '영업시간종료',
	bcontent text comment '내용',
	bwdate datetime default now() comment '등록일',
	bhit int default 0 comment '조회수',
	entityid int,
	foreign key (userno) references user(userno),
	foreign key (entityid) references entity(entityid)
);

create table reply
(
	rno int primary key auto_increment comment '댓글번호',
	bno int comment '게시물번호',
	ruserno int comment '댓글작성회원번호',
	runame varchar(20) comment '댓글작성자', 
	rcontent text comment '댓글내용',
	rwdate datetime default now() comment '작성일자',
	foreign key (bno) references board(bno) ON DELETE CASCADE,
	foreign key (ruserno) references user(userno)
);

CREATE TABLE addr
(
	addrno int primary key AUTO_INCREMENT comment '배송지번호',
    dname varchar(30) comment '배송지명',
	auserno int comment '회원번호',
	addrname varchar(30) comment '수취인명',
	addrtel varchar(20) comment '수취인 전화번호',
	addr varchar(255) comment '수취인 주소',
	addrdetail varchar(100) comment '상세주소',
	req varchar(255) comment '요청사항',
	def varchar(1) DEFAULT 'N' comment '기본배송지여부',
	foreign key (auserno) references user(userno)
);

CREATE TABLE item
(
	itemno int primary key AUTO_INCREMENT comment '상품번호',
	iuserno int comment '상품등록회원번호',
	category varchar(3) comment '상품분류',
	icode varchar(30) comment '상품코드',
	iname varchar(100) comment '상품명',
	maker varchar(100) comment '제조사',
	price int comment '판매가격',
	shippingfee int comment '배송비',
	stockSet varchar(3) DEFAULT 'Y' comment '재고설정',
	stock int comment '재고량',
	thumbnailF varchar(255) comment '상품 대표이미지 원본파일명',
	thumbnailP varchar(255) comment '상품 대표이미지 저장파일명',
	icontent text comment '상품 내용',
	entityid int,
	rating double,
	foreign key (iuserno) references user(userno),
	foreign key (entityid) references entity(entityid)
);

CREATE TABLE file (
    fid int primary key auto_increment comment '파일 ID',
    entityid int comment '엔티티 ID (itemno 또는 bno)',
    bfname varchar(255) comment '원본 파일 이름',
    bpname varchar(255) comment '저장된 파일 이름',
    bno int,
    fitemno int,
    foreign key (entityid) references entity(entityid),
    foreign key (bno) references board(bno) ON DELETE CASCADE,
    foreign key (fitemno) references item(itemno)
);

CREATE TABLE ordertable
(
	orderno int primary key AUTO_INCREMENT comment '주문순서번호',
	ordernum varchar(50) comment '주문번호',
	ouserno int comment '회원번호',
	oitemno int comment '상품번호',
	status varchar(30) comment '주문상태',
	odate datetime DEFAULT now() comment '주문일시',
	deliveryc varchar(30) comment '택배회사',
	trackingno varchar(30) comment '운송장번호',
	tprice int comment '총주문금액',
	oitemcnt int comment '수량',
	oaddrname varchar(30) comment '수취인명',
	oaddrtel varchar(30) comment '수취인번호',
	oaddr varchar(255) comment '주소',
	oaddrdetail varchar(100) comment '상세주소',
	oreq varchar(100) comment '요청사항',
	omemo varchar(255) comment '관리자메모',
	foreign key (ouserno) references user(userno),
	foreign key (oitemno) references item(itemno)
);


CREATE TABLE pay
(
	payno int PRIMARY KEY AUTO_INCREMENT comment '결제번호',
	porderno int comment '주문번호',
	puserno int comment '회원번호',
	payment varchar(100) comment '결제수단',
	paydate datetime DEFAULT now() comment '결제일시',
	payprice int comment '결제금액',
	cardcom varchar(100) comment '카드사',
	Installment int comment '할부개월',
	bank varchar(100) comment '입금자은행',
	depositor varchar(100) comment '입금자명',
	foreign key (porderno) references ordertable(orderno),
	foreign key (puserno) references user(userno)
);

CREATE TABLE review
(
	reviewno int PRIMARY KEY AUTO_INCREMENT comment '리뷰번호',
	reitemno int comment '상품번호',
	reuserno int comment '회원번호',
	rate double comment '별점',
	recontent text comment '내용',
	redate datetime DEFAULT now() comment '작성일',
	foreign key (reitemno) references item(itemno),
	foreign key (reuserno) references user(userno)
);

