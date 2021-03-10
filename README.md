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
    * 조회, 답변작성(답글), 수정, 삭제

---
### 개발환경
* OS - Windows10
* IDE - Eclipse
* Front-end
  * HTML/CSS, JavaScript, jQuery, Bootstrap
* 언어 - Java
* 데이터베이스 - Oracle
* 프레임워크 - Spring, MyBatis
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
### 기능구현- 영상
시연 영상을 통해 간략한 설명과 함께 기능이 동작하는 전체적인 흐름을 보여드리겠습니다.<br>
순서는 '메인페이지->회원페이지->관리자페이지->각 권한 접근시도' 입니다.

[![프로젝트 시연 영상](http://img.youtube.com/vi/yF0FSMgxf_8/0.jpg)](https://youtu.be/yF0FSMgxf_8?t=0s) 

---
### 기능구현 - 설명

#### ck에디터로 게시글 작성
위지윅에디터 중 ck에디터를 활용했습니다. 내용을 입력하고 이미지를 업로드한 후에 소스를 클릭하면 입력한 텍스트와 등록한 사진의 주소, 사이즈를 태그와 같이 확인할 수 있습니다.

#### 새로운 글 new 띄우기
Date클래스와 JSTL fmt 태그를 이용해서 오늘날짜와 작성일자가 일치하면 new아이콘이 생성됩니다.

#### 조회수 증가
게시글을 조회할 때마다 해당 게시글의 번호를 조건으로 주고 조회수 컬럼을 +1으로 수정해서 조회수가 증가하도록 했습니다.

#### 게시글 체크해서 삭제
input type=checkbox로 게시글을 복수선택해서 배열에 담고 ajax를 이용해서 삭제합니다.

#### 삭제 게시글 복원
게시글을 삭제하면 데이터가 지워지는게 아니라 따로 컬럼을 만들어서 복원이 가능하도록 했습니다.
삭제된 게시글은 '삭제 게시글'메뉴로 이동하고 해당 페이지에서 복원/완전한 데이터삭제가 가능합니다.

#### 페이지 유지
uri를 생성해주는 클래스 UriComponents를 사용해서 페이지 유지 기능을 구현했습니다. 특정 페이지에서 게시글을 조회할 때 url에 해당 페이지 번호와 그 페이지의 게시글 개수를 같이 전달합니다. 조회 후 수정 또는 삭제 후 목록으로 돌아올 때 전달받은 페이지 번호와 게시글 개수를 controller로 전달하고 RedirectAttributes를 사용해 리다이렉트시 각 정보를 포함합니다.

#### 정렬/검색
정렬은 최신순/조회수 높은 순/추천수 높은 순으로, 검색조건은 제목/내용/제목+내용/지역으로 조회가 가능하고 지역은 select option을 사용해서 선택할 수 있도록 했습니다. 정렬/검색도 UriComponents를 사용해서 uri를 생성하였습니다.

#### uri복사/공유

#### 추천
시큐리티 인증을 사용해서 로그인을 안했을 때는 로그인 후 이용해달라는 알림창을 띄웁니다. 로그인을 했을 때는 해당 게시글 번호와 유저의 아이디를 비교해서 추천한 내역이 없으면 추천가능, 내역이 있으면 추천불가하다는 알림창을 띄웁니다. ajax와 getJSON을 이용해서 추천 후 증가한 추천수를 보여줍니다.

#### 회원가입/로그인
회원가입할 때 비밀번호는 PasswordEncoder클래스의 encode메소드를 이용해서 암호화합니다.

#### 비밀번호 찾기
비밀번호는 데이터베이스에 단방향 암호화되어 저장해야 하는데 이는 암호화했으면 다시 복호화할 수 없다는 것입니다. 암호화되기 전의 비밀번호는 찾을 수 없으므로 유저의 아이디와 이름을 조회해서 일치하는 내역이 있으면 새 비밀번호를 설정할 수 있도록 했습니다.

#### 답글달기


---
### 프로젝트 보완점
완성도가 떨어지는 점을 보완하고 싶습니다.

아무래도 혼자서 진행하다 보니 나름 필요한 기능을 구현했다고 생각하지만 전체적으로 웹사이트라는 느낌이 들지 않는 게 아쉬웠습니다.
테스트할 때마다 다른 기능을 추가하고 싶거나 수정하고 싶을 때가 많았는데 그중 제일 아쉬운 부분은 '로그인/회원가입' 입니다.
마지막에 시큐리티를 적용하면서 추가한 거라 시간이 부족해서 미흡한 점이 있다고 생각합니다.

예를 들면 회원을 삭제(탈퇴)할 때 그 사용자의 데이터(개인정보가 아닌 추천이나 문의내역)를 남겨두고 싶었는데 
설계를 제대로 하지 못해 같은 아이디로 재가입이 가능하고, 새로 가입했지만 이전 사용자가 추천/문의한 내역이 남아있는 문제가 발생했습니다.

그래서 다음과 같은 보완점을 생각했습니다.

1. 같은 아이디로 재가입 막기<br>
회원을 삭제해도 데이터를 완전히 삭제하는 게 아닌 따로 탈퇴컬럼을 만들어서 분류하는 것입니다.

2. 회원정보를 조회할 때 조건을 다양하게 설정하기<br>
현재는 아이디,비밀번호,이름만 있으면 가입이 되고 추천이나 문의내역은 아이디를 이용해서 조회를 하고 있습니다.
때문에 같은 아이디로 재가입 시 이전 데이터를 불러오게 되는데 이를 아이디만 아니라 이름, 이메일 등 여러 개의 조건이 모두 일치하는 경우 조회가 가능하도록 하는 것입니다.

처음부터 제대로 설계했으면 좋았겠지만 이렇게 시행착오를 거치면서 더 발전할 수 있다고 생각합니다.
다음부터는 이러한 보완점을 적용해서 더 완성도를 높이도록 하겠습니다.

---
### 프로젝트를 마치며
전반적으로 이번 프로젝트는 수업하면서 배운 내용들을 전체적으로 복습한다고 생각하면서 진행했습니다.<br>
자주 사용해서 익숙한 부분도 있었지만 그와 반대로 새롭게 배운다는 느낌을 받은 부분도 있었습니다.
이를 통해 깨달은 건 내가 직접 해보지 않으면 내 것이 될 수 없다는 것이었습니다.
코드만 보고 이해하는 것, 그냥 코드를 따라치는 것, 내가 직접 코드를 이용해서 구현하는 것은 당연하지만 정말 달랐습니다.
하나씩 복습한다는 차원에서 테스트하고 디버깅하면서 프로젝트에 적용하고 나니 확실히 전보다 이해도가 높아졌고 전체적인 흐름도 파악할 수 있게 되었습니다.

개인적으로 이번 프로젝트를 통해 매력을 느낀 건 ajax랑 security였습니다.<br>
ajax와 security는 위에서 말한 새롭게 배운다는 느낌을 받은 부분이었고 개발할 때 필수적으로 써야 한다고 생각이 들었기 때문에 다시 복습하면서 프로젝트에 적용했습니다.
ajax는 페이지 전체를 새로 고치지 않아도 된다는 게 큰 메리트였고, security는 인증/권한 이 두 가지로 보안성을 높일 수 있고 한 번 설정하고 나면 적용하는 방법도 간단해서 왜 필수적으로 써야 하는지 이해할 수 있었습니다. 특히 암호화 기능을 통해 비밀번호를 찾을 때 왜 새롭게 비밀번호를 설정해야 하는 지 알 수 있게 되었습니다. 

간단하더라도 혼자서 하나의 프로젝트를 진행하고 싶었는데 완벽하게는 아니지만 완성을 하고 나니 스스로 뿌듯하면서 만족스러웠습니다.
개발을 배울 때도 느꼈지만 그동안 내가 실제로 보고 사용하던 기능을 직접 구현하고 작동되는 걸 보는 것은 언제봐도 신기하고 재미있다고 생각합니다.
물론 계획한 대로 문제없이 진행되면 좋겠지만 에러가 나고 그걸 해결하는 과정이 있기에 더 큰 성취감을 느낄 수 있는 것 같습니다.
아는 부분은 더 깊게 공부하고, 부족한 부분은 처음부터 차근차근 공부하면서 지금보다 한층 더 성장한 개발자가 될 수 있도록 꾸준히 노력하겠습니다.
이상으로 글을 마치겠습니다. 감사합니다. 
