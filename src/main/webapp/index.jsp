<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Projeto JSP</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	background-color: #f8f9fa;
}

.msg {
	font-size: 15px;
	color: #664d03;
	background-color: #fff3cd;
	border: 1px solid #ffecb5;
	padding: 10px;
	border-radius: 5px;
	text-align: center;
	margin-bottom: 15px;
}

/* Corpo do container com fundo claro e suave */
.container-login {
    background-color: #A4D8D5; /* Fundo verde para o container */
    padding: 2rem; /* Espaçamento interno */
    border-radius: 10px; /* Bordas arredondadas */
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Sombra suave para destacar */
    max-width: 450px; /* Limita a largura do container */
    width: 100%;
    margin: 50px auto; /* Centraliza o container */
}

/* Botão de login com o estilo do Swagger (verde) */
.btn-primary {
    background-color: #28a745; /* Verde do Swagger */
    border-color: #28a745; /* Cor da borda */
    color: white; /* Texto branco */
    font-weight: bold;
    padding: 10px 20px;
    border-radius: 5px;
    width: 100%; /* Ocupa toda a largura */
    transition: background-color 0.3s, border-color 0.3s; /* Transição suave */
}

.btn-primary:hover {
    background-color: #218838; /* Cor mais escura para hover */
    border-color: #1e7e34;
}

/* Estilo do título e subtítulo */
.titulo-login, .subtitulo-login {
    text-align: center;
    font-weight: bold;
    color: #2c3e50;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.titulo-login {
    font-size: 1.8rem; /* Título maior */
    margin-top: 20px; /* Espaço superior */
}

.subtitulo-login {
    font-size: 1.1rem; /* Subtítulo um pouco menor */
    margin-top: 10px;
    color: #6c757d; /* Cor suave para o subtítulo */
}

/* Animação suave para fade-in */
@keyframes fadeIn {
    0% {
        opacity: 0;
        transform: translateY(-10px);
    }
    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Caixa de mensagens de erro */
.msg {
    font-size: 15px;
    color: #664d03;
    background-color: #fff3cd;
    border: 1px solid #ffecb5;
    padding: 10px;
    border-radius: 5px;
    text-align: center;
    margin-bottom: 15px;
}


.alert:empty {
        display: none;
    }
</style>
</head>

<body>
	<div class="container-login">
		<h3 class="titulo-login">Seja bem-vindo!</h3>
        <h3 class="subtitulo-login">Insira suas credenciais para entrar.</h3>

		<c:if test="${not empty msg and fn:length(fn:trim(msg)) > 0}">
			<div class="alert alert-danger text-center">${msg}</div>
		</c:if>

		<form action="<%=request.getContextPath()%>/ServletLogin"
			method="post" class="needs-validation" novalidate>
			<input type="hidden" value="<%=request.getParameter("url")%>"
				name="url">

			<div class="mb-3">
				<label class="form-label" for="login">Login</label> <input
					class="form-control" id="login" name="login" type="text" required>
				<div class="invalid-feedback">Informe o login!</div>
			</div>

			<div class="mb-3">
				<label class="form-label" for="senha">Senha</label> <input
					class="form-control" id="senha" name="senha" type="password"
					required>
				<div class="invalid-feedback">Informe a senha!</div>
			</div>

			<button type="submit" class="btn btn-primary w-100">Efetuar
				Login</button>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<script>
		(function() {
			'use strict'
			var forms = document.querySelectorAll('.needs-validation')
			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}
					form.classList.add('was-validated')
				}, false)
			})
		})()
	</script>
</body>
</html>
