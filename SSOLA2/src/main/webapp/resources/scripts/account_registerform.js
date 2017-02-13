/**
 * registerform 내 정규식 등 
 */

var idCheck = false;
var passCheck = false;
var nameCheck = false;
var emailCheck = false;
var birthCheck = false;
var befName; // 이전 닉네임을 저장할 값
var befId; // 이전 아이디를 저장할 값

$(function() {
	$("#submitButton").on("click", function(event) {
		if(!idCheck) {
			alert("잘못된 ID 입력입니다. ID를 확인해주세요.");
			$("#id").focus();
		} else if (!passCheck) {
			alert("잘못된 password 입력입니다. password를 확인해주세요.");
			$("#password").focus();
		} else if (!nameCheck) {
			alert("잘못된 nickname 입력입니다. nickname을 확인해주세요.")
			$("#nickname").focus();
		} else if (!emailCheck) {
			alert("잘못된 email 입력입니다. email을 확인해주세요.")
			$("#email").focus();
		} else if (!birthCheck) {
			alert("잘못된 birth 입력입니다. birth를 확인해주세요.")
			$("#birth").focus();
		} else {
			$("#submitForm").submit();
		}
	});

	$("#idCheckButton").on("click", function(event) {
		// 중복 확인 버튼 누를 시 id 내용 가져와 db와 대조 필요
		var id = /^[a-zA-Z0-9]{4,20}$/;
		if (id.test($("#id").val())) {
			$.ajax({
				"url" : "/ssola2/account/idcheck.action",
				"method" : "get",
				"data" : { id : $("#id").val() },
				"dataType" : "text",
				success : function(data) {
					if (!data) {
						$("#idMessage").css('color', 'red').text("다른 아이디를 입력하세요");
						idCheck = false;
						return false;
					}
					$("#idMessage").css('color', 'blue').text("사용할 수 있는 아이디 입니다.");
					befId = $("#id").val();
					idCheck = true;
					return;
				}
			});
		} else {
			$("#idMessage").css('color', 'red').text("아이디가 형식에 맞지 않습니다.");
		}
	});

	$("#nicknameCheckButton").on("click", function(event) {
		// 중복 확인 버튼 누를 시 id 내용 가져와 db와 대조 필요
		var nickname = /^.*(?=.{2,15})(?=.*[ㄱ-ㅎ가-힣a-zA-Z0-9]).*$/;
		if (nickname.test($("#nickname").val())){
			$.ajax({
				"url" : "/ssola2/account/nicknamecheck.action",
				"method" : "get",
				"data" : { nickname : $("#nickname").val() },
				"dataType" : "text",
				success : function(data) {
					if (!data) {
						$("#nicknameMessage").css('color', 'red').text("다른 닉네임을 입력하세요");
						nameCheck = false;
						return false;
					}
					$("#nicknameMessage").css('color', 'blue').text("사용할 수 있는 닉네임 입니다.");
					befName = $("#nickname").val();
					nameCheck = true;
					return;
				}
			});
		} else {
			$("#nicknameMessage").css('color', 'red').text("닉네임이 형식에 맞지 않습니다.");
		}
	});

	$("#id").on('keyup', function(event) {
		var id = /^[a-zA-Z0-9]{4,20}$/;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(id.test($("#id").val())){
			if($("#id").val() != befId) {
				idCheck = false;
				$("#idMessage").css('color', 'gray').text("중복 확인이 필요합니다.");
			} else {
				if($("#id").val().length > 3){
					idCheck = true;
					$("#idMessage").css('color', 'blue').text("사용할 수 있는 아이디 입니다.");
				}
			}
		} else {
			$("#idMessage").css('color', 'red').text("사용할 수 없는 형식입니다.(4-12글자 영어,숫자)");
		}
	});

	$("#password").on('keyup', function (event) {
		var password = /^.*(?=.{8,16})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(password.test($("#password").val())){
			if($("#password").val() != $("#confirm").val()) {
				passCheck = false;
				$("#passwordMessage").css('color', 'red').text("비밀번호가 일치하지 않습니다.");
				$("#confirmMessage").text("");
			} else {
				$("#passwordMessage").text("");
				$("#confirmMessage").text("");
				passCheck = true;
			}
		} else {
			$("#passwordMessage").css('color', 'red').text("사용할 수 없는 형식입니다.(6-20글자 영어 숫자 최소 1)");
		}
	});

	$("#confirm").on('keyup', function (event) {
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if($("#password").val() != $("#confirm").val()) {
			passCheck = false;
			$("#confirmMessage").css('color', 'red').text("비밀번호가 일치하지 않습니다.");
			$("#passwordMessage").text("");
		} else {
			$("#passwordMessage").text("");
			$("#confirmMessage").text("");
			passCheck = true;
		}
	});

	$("#nickname").on('keyup', function(event) {
		var nickname = /^.*(?=.{2,15})(?=.*[ㄱ-ㅎ가-힣a-zA-Z0-9]).*$/;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
				$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(nickname.test($("#nickname").val())){
			if($("#nickname").val() != befName) {
				nameCheck = false;
				$("#nicknameMessage").css('color', 'gray').text("중복 확인이 필요합니다.");
			} else {
				if($("#nickname").val().length > 1){
					nameCheck = true;
					$("#nicknameMessage").css('color', 'blue').text("사용할 수 있는 닉네임 입니다.");
				}
			}
		} else {
			$("#nicknameMessage").css('color', 'red').text("사용할 수 없는 형식입니다.(2-15글자 한글,영어,숫자)");
		}
	});

	$("#email").on('keyup', function(event) {
		emailCheck = false;
		var email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
			$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if(!$("#email").val()) {
			$("#emailMessage").css('color', 'gray').text("이메일을 입력해 주세요");
		} else {
			if(!email.test($("#email").val())) {
				$("#emailMessage").css('color', 'red').text("이메일 주소가 유효하지 않습니다.");
			} else {
				$("#emailMessage").css('color', 'blue').text("Good");
				emailCheck = true;
			}
		}
	});

	$("#birth").on('keyup', function(event) {
		birthCheck = false;
		var birth = /[12][0-9]{3}-[0-9]{2}-[0-9]{2}/;
		if ($(this).val().length > $(this).attr("maxlength")) {
			alert("제한길이 초과");
			$(this).val($(this).val().substr(0, $(this).attr("maxlength")));
		}
		if (!$("#birth").val()) {
			$("#birthMessage").css('color', 'gray').text("생일을 입력해 주세요.");
		} else {
			if (!birth.test($("#birth").val())) {
				$("#birthMessage").css('color', 'red').text("생일이 유효하지 않습니다.");
			} else {
				$("#birthMessage").css('color', 'blue').text("Good");
				birthCheck = true;
			}
		}
	});
});
