# OurProject

여름방학기간에 작업하는 앱 저장소

스터디 그룹원들이 여름방학기간에 제작하는 앱의 공용 저장소입니다.


마스터 브랜치에서 깃 풀하시면, 각자 이름으로 브랜치를 새롭게 만들어 주세요.
저장소로 깃 푸쉬 하시면, 다같이 내용 확인해서 마스터 브랜치에 추가해 드리겠습니다.

작업 디렉터리는 flutter_main_page입니다. 그 외에 디렉터리는 작업하면 안됩니다.

현재까지 작업된 사항

1차 업로드

로그인 화면, 메인화면 구성

2차 업로드

로그인 화면에서 Textfield가 키보드에 가려지는 현상을 수정했습니다.
비밀번호 Textfield 내용이 가려지게 수정했습니다.

메인화면에서 bottomNavigationBar에 항목이 추가되었고,
홈, 커뮤니티, 알람, 내정보 페이지가 새롭게 추가되었습니다.

홈 페이지에서 상단 페이지와 하단 페이지로 분리하여서,
상단 페이지에는 이벤트 이미지를 삽입할 수 있게 변경했고, 자동으로 좌우 스크롤링 됩니다.
하단 페이지에는 아직까지는 미완성이지만, 공지사항 목록이 출력되게 코드를 추가했습니다.
![로그인 화면](https://user-images.githubusercontent.com/108314973/176630186-41ba3607-a2ef-4dac-9b9a-bc8d062722d8.png)
![로그인 화면 개선사항](https://user-images.githubusercontent.com/108314973/176630226-fee164a2-100d-404a-9bcf-83c4553a9258.png)
![메인_내정보 화면](https://user-images.githubusercontent.com/108314973/176630242-57858f4c-b90c-449e-be1c-446558a64bf5.png)
![메인_알람 화면](https://user-images.githubusercontent.com/108314973/176630250-26f12c7a-ae1e-4878-8700-711d70e35b30.png)
![메인_커뮤니티 화면](https://user-images.githubusercontent.com/108314973/176630311-b8eefef9-45d0-442f-bde0-fef33b5271b2.png)
![메인_홈 화면](https://user-images.githubusercontent.com/108314973/176630330-e169ffff-b40c-42e2-84af-e607fd4b542e.png)


3차 업로드

앱 테마가 별로라는 의견이 있어서 전체적인 앱 테마에 변화를 주었습니다.

![로그인 화면 2](https://user-images.githubusercontent.com/108314973/176837800-e26dd4f2-45af-4eb7-8707-f75a5f6384e8.png)

![메인 화면 2](https://user-images.githubusercontent.com/108314973/176837823-e7bedd39-6169-474c-903a-75c4fcc065af.png)

파이어베이스와 연동하여 회원가입 페이지, 계정과 패스워드를 입력해야 로그인 되는 기능이 추가되었습니다. 현재는 제가 임의로 만든 계정만 존재하니 사용시 꼭 연락해 주세요.


![회원가입 화면](https://user-images.githubusercontent.com/108314973/176837965-6ef02a76-c912-46ef-a45c-9dbcc2d7b01e.png)

![개선사항 1](https://user-images.githubusercontent.com/108314973/176837989-81b5e9a1-7e77-4349-a11f-6607672194c6.png)

4차 업로드

공지사항 게시판에서 데이터베이스의 내용을 리스트로 불러와서 볼 수 있게 되었고, 하단 플로팅 버튼을 이용하면 새로운 글을 적을 수도 있습니다. 아직은 제 계정만 관리자로 부여했기 때문에 실제로 작성은 할 수 없습니다. 이 부분을 참고하면 게시판 부분에서의 파이어베이스 연동사항을 보실 수 있을 겁니다. 하단 이미지 부분 프론트 작업 부탁드립니다.



![개선사항 4-1](https://user-images.githubusercontent.com/108314973/177273576-4dd72daa-43e1-4f3e-81f4-6b373b165d25.png)
![개선사항 4-2](https://user-images.githubusercontent.com/108314973/177273596-3aa05044-82a3-478c-a08b-e7ee12509eed.png)
![개선사항 4-3](https://user-images.githubusercontent.com/108314973/177273605-7fdfe6b8-9bef-4ea8-bfb0-71416368d1db.png)
![개선사항 4-4](https://user-images.githubusercontent.com/108314973/177273616-2b205258-a98b-432b-80a2-0cee91d9cb88.png)

5차 업로드

드디어 커뮤니티 페이지 작업의 끝이 보입니다. 홈 커뮤니티 화면은 여기서 마무리하고, 각 게시판 페이지 작업, 글쓰기 작업을 해야합니다.
홈 커뮤니티에서 각 게시판의 내용이 최근내용으로 5가지씩 미리보기 형식으로 나올 수 있게 랜더링 했습니다.

긴급 6차 업로드

회원가입 절차에서 회원가입햇는데도, 로그인이 되지 않는 버그를 수정했습니다. 새롭게 풀해주세요.

* project 로드맵
![화면 캡처 2022-07-16 174621](https://user-images.githubusercontent.com/108403672/179348003-197fc4c0-9dd9-481a-9e2b-1dde8d88202e.png)


