### 프로젝트 소개
시큐리티를 이용해서 권한별로 페이지를 나누고 CRUD를 할 수 있도록 했습니다.

---
### 프로젝트 설명
이 프로젝트는 크게 3가지 페이지로 나눌 수 있습니다.

#### 1. 모두가 접근가능한 메인페이지
  * 회원가입/로그인
    * 비밀번호 찾기(수정)
  * 게시글 정렬/검색
  * 관리자페이지에서 작성한 게시글 조회
    * url 복사, 공유
    * 추천
  * (회원권한만 보이는) 문의하기
  
#### 2. 회원만 접근가능한 회원페이지
  * 회원정보
    * 조회, 수정
  * 문의내역
    * 조회, 삭제
    
#### 3. 관리자만 접근가능한 관리자페이지
  * 게시글
    * 작성, 조회, 수정, 삭제
  * 삭제한 게시글 관리
    * 복원, 삭제
  * 회원정보
    * 조회, 삭제
  * 문의내역
    * 조회, 답변작성, 수정, 삭제

---
### 개발환경
* OS - Windows10
* IDE - Eclipse
* 언어 - Java
* 데이터베이스 - Oracle
* 프레임워크 - Spring
* 서버 - Apache Tomcat 8.5

---
### 사용한 테이블
* 관리자(게시판) 테이블
``` SQL
CREATE TABLE TBL_ADMIN 
(
  BNUM NUMBER(10, 0) NOT NULL PRIMARY KEY
, TITLE VARCHAR2(200 BYTE) NOT NULL 
, CONTENT VARCHAR2(2000 BYTE) 
, WRITER VARCHAR2(50 BYTE) NOT NULL 
, REGDATE DATE DEFAULT sysdate 
, UPDATEDATE DATE DEFAULT sysdate 
, AREA VARCHAR2(10 BYTE) 
, STARTDATE VARCHAR2(20 BYTE) 
, ENDDATE VARCHAR2(20 BYTE) 
, IMG VARCHAR2(200 BYTE) 
, THUMBIMG VARCHAR2(200 BYTE) 
, REMOVE CHAR(10 BYTE) DEFAULT 'n' 
, CNT NUMBER(5, 0) DEFAULT 0
);
CREATE SEQUENCE SEQ_ADMIN;
``` 
* 추천 테이블
``` SQL
CREATE TABLE TBL_RECOMMEND 
(
  BNUM NUMBER(10, 0) NOT NULL REFERENCES TBL_ADMIN(BNUM)
, USER_ID VARCHAR2(50 BYTE) NOT NULL 
) ;
```
* 회원(회원가입) 테이블
``` SQL
CREATE TABLE TBL_MEMBER
(
USER_ID VARCHAR2(50) NOT NULL PRIMARY KEY,
USER_PW VARCHAR2(100) NOT NULL,
USER_NAME VARCHAR2(100) NOT NULL,
REGDATE DATE DEFAULT SYSDATE,
UPDATEDATE DATE DEFAULT SYSDATE,
ENABLED CHAR(1) DEFAULT '1'
);
```
* 회원(권한) 테이블
``` SQL
CREATE TABLE TBL_MEMBER_AUTH
(
USER_ID VARCHAR2(50) NOT NULL,
AUTH VARCHAR2(50) NOT NULL,
CONSTRAINT FK_MEMBER_AUTH FOREIGN KEY(USER_ID) REFERENCES TBL_MEMBER(USER_ID)
);
```
* 자동로그인 테이블
``` SQL
CREATE TABLE PERSISTENT_LOGINS
(
USERNAME VARCHAR(64) NOT NULL,
SERIES VARCHAR(64) PRIMARY KEY,
TOKEN VARCHAR(64) NOT NULL,
LAST_USED TIMESTAMP NOT NULL
);
```
* 문의 테이블
``` SQL
CREATE TABLE TBL_REQUEST 
(
  RNUM NUMBER(10, 0) NOT NULL PRIMARY KEY
, TITLE VARCHAR2(200 BYTE) NOT NULL 
, CONTENT VARCHAR2(2000 BYTE) 
, USER_ID VARCHAR2(50 BYTE) NOT NULL 
, REGDATE DATE DEFAULT SYSDATE 
, GRPNUM NUMBER(10, 0) 
, GRPORD NUMBER(10, 0) DEFAULT 0 
, DEPTH NUMBER(10, 0) DEFAULT 1 
);
CREATE SEQUENCE SEQ_REQUEST;
```
* ERD

![image](https://user-images.githubusercontent.com/75934431/106018389-cd79b100-6104-11eb-96ca-558f5ddf2e83.png)

---
### 기능 구현
기능 구현은 시연 영상을 통해 보여드리겠습니다.<br>
순서는 '메인페이지->회원페이지->관리자페이지->각 권한 접근시도' 입니다.

[![프로젝트 시연 영상](http://img.youtube.com/vi/yF0FSMgxf_8/0.jpg)](https://youtu.be/yF0FSMgxf_8?t=0s) 

---
### 프로젝트 보완점
완성도가 떨어지는 점을 보완하고 싶습니다.

아무래도 혼자서 진행하다 보니 나름 필요한 기능을 구현했다고 생각하지만 전체적으로 웹사이트라는 느낌이 들지 않는게 아쉬웠습니다.
테스트 할 때마다 다른 기능을 추가하고싶거나 수정하고 싶을 때가 많았는데 그 중 제일 아쉬운 부분은 '로그인/회원가입' 이었습니다.
마지막에 시큐리티를 적용하면서 추가한거라 시간이 부족해서 미흡한 점이 있다고 생각합니다.

예를 들면 회원을 삭제(탈퇴)할 때 그 사용자의 데이터(개인정보가 아닌 추천이나 문의내역)를 남겨두고 싶었는데 
설계를 제대로 하지 못해 같은 아이디로 재가입이 가능하고, 새로 가입했지만 이전 사용자가 추천/문의한 내역이 남아있는 문제가 발생했습니다.

그래서 다음과 같은 보완점을 생각했습니다.

1. 같은 아이디로 재가입 막기<br>
회원을 삭제해도 데이터를 완전히 삭제하는게 아닌 따로 탈퇴컬럼을 만들어서 분류하는 것입니다.

2. 회원정보를 조회할 때 조건을 다양하게 설정하기<br>
현재는 아이디,비밀번호,이름만 있으면 가입이 되고 추천이나 문의내역은 아이디를 이용해서 조회를 하고있습니다.
때문에 같은 아이디로 재가입 시 이전 내역을 불러오게 되는게 이를 아이디만 아니라 이름, 이메일 등 여러 개의 조건이 모두 일치하는 경우 조회가 가능하도록 하는 것입니다.

처음부터 제대로 설계했으면 좋았겠지만 이렇게 시행착오를 거치면서 더 발전할 수 있다고 생각합니다.
다음부터는 이러한 보완점을 적용해서 더 완성도를 높이도록 하겠습니다.

---
### 프로젝트를 마치며

