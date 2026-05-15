<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaPlanMejoramiento.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sistema Plan de Mejoramiento - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Outfit', sans-serif;
            background: #0a1628;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .fondo {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            z-index: 0;
        }

        .circulo1 {
            position: absolute;
            width: 500px; height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(57,169,0,0.15) 0%, transparent 70%);
            top: -100px; left: -100px;
        }

        .circulo2 {
            position: absolute;
            width: 400px; height: 400px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(57,169,0,0.1) 0%, transparent 70%);
            bottom: -80px; right: -80px;
        }

        .lineas {
            position: absolute;
            width: 100%; height: 100%;
            background-image: 
                linear-gradient(rgba(57,169,0,0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(57,169,0,0.03) 1px, transparent 1px);
            background-size: 50px 50px;
        }

        .contenedor {
            position: relative;
            z-index: 1;
            display: flex;
            width: 900px;
            min-height: 540px;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 40px 80px rgba(0,0,0,0.5);
        }

        .panel-izquierdo {
            width: 45%;
            background: linear-gradient(145deg, #39a900 0%, #2d8200 50%, #1a5c00 100%);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .panel-izquierdo::before {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,0.1);
            top: -80px; right: -80px;
        }

        .panel-izquierdo::after {
            content: '';
            position: absolute;
            width: 200px; height: 200px;
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,0.08);
            bottom: -50px; left: -50px;
        }

        .logo-sena {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icono {
            width: 44px; height: 44px;
            background: rgba(255,255,255,0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 700;
            color: white;
            backdrop-filter: blur(10px);
        }

        .logo-texto { color: white; }

        .logo-texto h1 {
            font-size: 18px;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .logo-texto p {
            font-size: 11px;
            opacity: 0.7;
            letter-spacing: 1px;
        }

        .info-centro { position: relative; z-index: 1; }

        .info-centro h2 {
            font-size: 28px;
            font-weight: 700;
            color: white;
            line-height: 1.3;
            margin-bottom: 16px;
        }

        .info-centro p {
            font-size: 14px;
            color: rgba(255,255,255,0.7);
            line-height: 1.7;
        }

        .badges {
            display: flex;
            flex-direction: column;
            gap: 10px;
            position: relative;
            z-index: 1;
        }

        .badge {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 10px 14px;
            backdrop-filter: blur(10px);
        }

        .badge-icono {
            width: 32px; height: 32px;
            background: rgba(255,255,255,0.15);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .badge span {
            font-size: 13px;
            color: rgba(255,255,255,0.85);
            font-weight: 500;
        }

        .panel-derecho {
            width: 55%;
            background: #111827;
            padding: 50px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .titulo-login { margin-bottom: 36px; }

        .titulo-login h2 {
            font-size: 26px;
            font-weight: 700;
            color: #f9fafb;
            margin-bottom: 8px;
        }

        .titulo-login p {
            font-size: 14px;
            color: #6b7280;
        }

        .grupo-campo { margin-bottom: 20px; }

        .grupo-campo label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #9ca3af;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .input-wrapper { position: relative; }

        .input-icono {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #4b5563;
        }

        .input-campo {
            width: 100%;
            padding: 13px 14px 13px 42px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 12px;
            color: #f9fafb;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            transition: all 0.3s;
            outline: none;
        }

        .input-campo:focus {
            border-color: #39a900;
            box-shadow: 0 0 0 3px rgba(57,169,0,0.15);
            background: #1a2535;
        }

        .input-campo::placeholder { color: #4b5563; }

        .select-campo {
            width: 100%;
            padding: 13px 14px 13px 42px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 12px;
            color: #f9fafb;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            transition: all 0.3s;
            outline: none;
            cursor: pointer;
            appearance: none;
        }

        .select-campo:focus {
            border-color: #39a900;
            box-shadow: 0 0 0 3px rgba(57,169,0,0.15);
        }

        .select-campo option {
            background: #1f2937;
            color: #f9fafb;
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #39a900, #2d8200);
            border: none;
            border-radius: 12px;
            color: white;
            font-family: 'Outfit', sans-serif;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #44c200, #39a900);
            transform: translateY(-1px);
            box-shadow: 0 8px 25px rgba(57,169,0,0.3);
        }

        .mensaje-error {
            background: rgba(220,38,38,0.1);
            border: 1px solid rgba(220,38,38,0.3);
            border-radius: 10px;
            padding: 12px 16px;
            color: #fca5a5;
            font-size: 13px;
            margin-top: 16px;
        }

        .footer-login {
            margin-top: 30px;
            text-align: center;
            font-size: 12px;
            color: #374151;
        }
    </style>
</head>
<body>
    <div class="fondo">
        <div class="lineas"></div>
        <div class="circulo1"></div>
        <div class="circulo2"></div>
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
                <p>Plataforma académica para la gestión y seguimiento de planes de mejoramiento de aprendices.</p>
            </div>

            <div class="badges">
                <div class="badge">
                    <div class="badge-icono">👤</div>
                    <span>Administrador de Centro</span>
                </div>
                <div class="badge">
                    <div class="badge-icono">📋</div>
                    <span>Instructor</span>
                </div>
                <div class="badge">
                    <div class="badge-icono">🎓</div>
                    <span>Aprendiz</span>
                </div>
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
                        <span class="input-icono">👤</span>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="input-campo" placeholder="Ingresa tu usuario"/>
                    </div>
                </div>

                <div class="grupo-campo">
                    <label>CONTRASEÑA</label>
                    <div class="input-wrapper">
                        <span class="input-icono">🔒</span>
                        <asp:TextBox ID="txtContrasena" runat="server" CssClass="input-campo" TextMode="Password" placeholder="Ingresa tu contraseña"/>
                    </div>
                </div>

                <div class="grupo-campo">
                    <label>ROL</label>
                    <div class="input-wrapper">
                        <span class="input-icono">🛡️</span>
                        <asp:DropDownList ID="ddlRol" runat="server" CssClass="select-campo">
                            <asp:ListItem Value="">-- Selecciona tu rol --</asp:ListItem>
                            <asp:ListItem Value="Administrador">Administrador de Centro</asp:ListItem>
                            <asp:ListItem Value="Instructor">Instructor</asp:ListItem>
                            <asp:ListItem Value="Aprendiz">Aprendiz</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Ingresar al Sistema" CssClass="btn-login" OnClick="btnLogin_Click"/>

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false"/>
            </form>

            <div class="footer-login">
                Sistema de Gestión Académica &copy; 2024 — SENA Colombia
            </div>
        </div>
    </div>
</body>
</html>