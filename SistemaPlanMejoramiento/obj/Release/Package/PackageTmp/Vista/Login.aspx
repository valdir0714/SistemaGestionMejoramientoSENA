<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaPlanMejoramiento.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sistema Plan de Mejoramiento - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #e8f5e9 0%, #f0fdf4 30%, #f8fafc 70%, #e8f5e9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
            position: relative;
        }

        .bg-animated {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.4;
            animation: floatCircle 20s ease-in-out infinite;
        }

            .bg-circle:nth-child(1) {
                width: 500px;
                height: 500px;
                background: rgba(57,169,0,0.12);
                top: -150px;
                left: -100px;
                animation-delay: 0s;
            }

            .bg-circle:nth-child(2) {
                width: 400px;
                height: 400px;
                background: rgba(16,185,129,0.1);
                bottom: -100px;
                right: -80px;
                animation-delay: -5s;
            }

            .bg-circle:nth-child(3) {
                width: 300px;
                height: 300px;
                background: rgba(34,197,94,0.08);
                top: 50%;
                left: 60%;
                animation-delay: -10s;
            }

            .bg-circle:nth-child(4) {
                width: 200px;
                height: 200px;
                background: rgba(74,222,128,0.1);
                bottom: 20%;
                left: 10%;
                animation-delay: -15s;
            }

        @keyframes floatCircle {
            0% {
                transform: translate(0,0) scale(1);
            }

            25% {
                transform: translate(30px,-40px) scale(1.05);
            }

            50% {
                transform: translate(-20px,20px) scale(0.95);
            }

            75% {
                transform: translate(40px,30px) scale(1.02);
            }

            100% {
                transform: translate(0,0) scale(1);
            }
        }

        .grid-pattern {
            position: fixed;
            inset: 0;
            background-image: linear-gradient(rgba(57,169,0,0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(57,169,0,0.03) 1px, transparent 1px);
            background-size: 60px 60px;
            pointer-events: none;
            z-index: 0;
            animation: gridPulse 8s ease-in-out infinite;
        }

        @keyframes gridPulse {
            0%, 100% {
                opacity: 0.5;
            }

            50% {
                opacity: 1;
            }
        }

        .particles {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(57,169,0,0.25);
            border-radius: 50%;
            animation: particleFloat 12s linear infinite;
        }

            .particle:nth-child(1) {
                top: 10%;
                left: 20%;
                animation-delay: 0s;
                animation-duration: 14s;
            }

            .particle:nth-child(2) {
                top: 30%;
                left: 70%;
                animation-delay: -2s;
                animation-duration: 10s;
                width: 3px;
                height: 3px;
            }

            .particle:nth-child(3) {
                top: 60%;
                left: 15%;
                animation-delay: -5s;
                animation-duration: 16s;
                width: 5px;
                height: 5px;
            }

            .particle:nth-child(4) {
                top: 80%;
                left: 80%;
                animation-delay: -8s;
                animation-duration: 12s;
            }

            .particle:nth-child(5) {
                top: 45%;
                left: 50%;
                animation-delay: -3s;
                animation-duration: 15s;
                width: 3px;
                height: 3px;
            }

            .particle:nth-child(6) {
                top: 15%;
                left: 90%;
                animation-delay: -7s;
                animation-duration: 11s;
            }

            .particle:nth-child(7) {
                top: 70%;
                left: 35%;
                animation-delay: -10s;
                animation-duration: 13s;
                width: 5px;
                height: 5px;
            }

            .particle:nth-child(8) {
                top: 90%;
                left: 5%;
                animation-delay: -4s;
                animation-duration: 17s;
            }

        @keyframes particleFloat {
            0% {
                transform: translateY(0) scale(1);
                opacity: 0.15;
            }

            50% {
                transform: translateY(-30px) scale(1.3);
                opacity: 0.5;
            }

            100% {
                transform: translateY(-60px) scale(0.6);
                opacity: 0;
            }
        }

        .contenedor {
            position: relative;
            z-index: 1;
            display: flex;
            width: 1000px;
            min-height: 560px;
            border-radius: 24px;
            overflow: hidden;
            background: #ffffff;
            box-shadow: 0 30px 80px rgba(0,0,0,0.12);
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }

            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .panel-izquierdo {
            width: 42%;
            background: linear-gradient(160deg, #1a3a1a 0%, #2d6b2d 40%, #1a4a1a 100%);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

            .panel-izquierdo::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(74,222,128,0.08) 0%, transparent 70%);
                top: -200px;
                right: -150px;
            }

            .panel-izquierdo::after {
                content: '';
                position: absolute;
                width: 350px;
                height: 350px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(74,222,128,0.05) 0%, transparent 70%);
                bottom: -100px;
                left: -80px;
            }

        .logo-sena {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
            position: relative;
            z-index: 2;
            margin-bottom: 40px;
        }

        .logo-icono {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, rgba(255,255,255,0.2), rgba(255,255,255,0.05));
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 800;
            color: #fff;
        }

        .logo-texto h1 {
            font-size: 28px;
            font-weight: 800;
            color: #fff;
            letter-spacing: 3px;
            line-height: 1;
        }

        .logo-texto p {
            font-size: 9px;
            color: rgba(255,255,255,0.6);
            letter-spacing: 2px;
            margin-top: 4px;
            text-transform: uppercase;
        }

        .info-centro {
            position: relative;
            z-index: 2;
            max-width: 280px;
        }

            .info-centro h2 {
                font-size: 26px;
                font-weight: 700;
                color: #fff;
                line-height: 1.3;
                margin-bottom: 16px;
                letter-spacing: -0.3px;
            }

            .info-centro p {
                font-size: 14px;
                color: rgba(255,255,255,0.75);
                line-height: 1.7;
                font-weight: 400;
            }

        .panel-derecho {
            width: 58%;
            background: #ffffff;
            padding: 55px 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .titulo-login {
            margin-bottom: 32px;
        }

            .titulo-login h2 {
                font-size: 30px;
                font-weight: 700;
                color: #0f172a;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }

            .titulo-login p {
                font-size: 15px;
                color: #64748b;
            }

        .grupo-campo {
            margin-bottom: 22px;
        }

            .grupo-campo label {
                display: block;
                font-size: 11px;
                font-weight: 600;
                color: #475569;
                margin-bottom: 7px;
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }

        .input-wrapper {
            position: relative;
        }

        .input-icono {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            color: #94a3b8;
            transition: color 0.2s;
            z-index: 2;
        }

        .input-campo {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            color: #0f172a;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            transition: all 0.2s;
            outline: none;
        }

            .input-campo:focus {
                border-color: #2d8a2d;
                background: #ffffff;
                box-shadow: 0 0 0 4px rgba(45,138,45,0.08);
            }

            .input-campo::placeholder {
                color: #94a3b8;
            }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #2d8a2d, #1a5c1a);
            border: none;
            border-radius: 12px;
            color: #fff;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 12px;
            transition: all 0.25s;
            box-shadow: 0 4px 16px rgba(45,138,45,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 24px rgba(45,138,45,0.3);
            }

            .btn-login:active {
                transform: translateY(0);
            }

        .mensaje-error {
            display: block;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 12px;
            padding: 14px 16px;
            color: #dc2626;
            font-size: 13px;
            margin-top: 18px;
            text-align: center;
            font-weight: 500;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }

            20% {
                transform: translateX(-6px);
            }

            40% {
                transform: translateX(6px);
            }

            60% {
                transform: translateX(-4px);
            }

            80% {
                transform: translateX(4px);
            }
        }

        .footer-login {
            margin-top: 36px;
            text-align: center;
            font-size: 12px;
            color: #94a3b8;
            letter-spacing: 0.3px;
        }

            .footer-login span {
                color: #2d8a2d;
            }

        @media (max-width: 900px) {
            .contenedor {
                width: 92%;
                flex-direction: column;
                margin: 20px;
                min-height: auto;
            }

            .panel-izquierdo, .panel-derecho {
                width: 100%;
                padding: 35px 30px;
            }

            .panel-izquierdo {
                min-height: 260px;
            }

            .info-centro h2 {
                font-size: 22px;
            }

            body {
                overflow-y: auto;
            }
        }
    </style>
</head>
<body>
    <div class="bg-animated">
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
    </div>
    <div class="grid-pattern"></div>
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="contenedor">
        <div class="panel-izquierdo">
            <div class="logo-sena">
                <div class="logo-icono">S</div>
                <div class="logo-texto">
                    <h1>SENA</h1>
                    <p>SERVICIO NACIONAL DE APRENDIZAJE</p>
                </div>
            </div>

            <div class="info-centro">
                <h2>Sistema de Planes de Mejoramiento</h2>
                <p>Plataforma acad&eacute;mica para la gesti&oacute;n y seguimiento de planes de mejoramiento de aprendices.</p>
            </div>
        </div>

        <div class="panel-derecho">
            <div class="titulo-login">
                <h2>Bienvenido</h2>
                <p>Ingresa tus credenciales para acceder al sistema</p>
            </div>

            <form id="form1" runat="server">
                <div class="grupo-campo">
                    <label>USUARIO</label>
                    <div class="input-wrapper">
                        <span class="input-icono"><i class="fas fa-user"></i></span>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="input-campo" placeholder="Ingresa tu usuario" />
                    </div>
                </div>

                <div class="grupo-campo">
                    <label>CONTRASE&Ntilde;A</label>
                    <div class="input-wrapper">
                        <span class="input-icono"><i class="fas fa-lock"></i></span>
                        <asp:TextBox ID="txtContrasena" runat="server" CssClass="input-campo" TextMode="Password" placeholder="Ingresa tu contrase&ntilde;a" />
                    </div>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Ingresar al Sistema" CssClass="btn-login" OnClick="btnLogin_Click" />

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false" />
            </form>

            <div class="footer-login">
                Sistema de Gesti&oacute;n Acad&eacute;mica &copy; 2024 &mdash; <span>SENA Colombia</span>
            </div>
        </div>
    </div>
</body>
</html>