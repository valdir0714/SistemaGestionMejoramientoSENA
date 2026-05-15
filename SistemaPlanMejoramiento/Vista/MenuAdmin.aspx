<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuAdmin.aspx.cs" Inherits="SistemaPlanMejoramiento.MenuAdmin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Menu Administrador - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Outfit', sans-serif;
            background: #0f172a;
            min-height: 100vh;
            color: #f9fafb;
        }

        .sidebar {
            position: fixed;
            left: 0; top: 0;
            width: 260px;
            height: 100vh;
            background: #111827;
            border-right: 1px solid #1f2937;
            display: flex;
            flex-direction: column;
            z-index: 100;
        }

        .sidebar-logo {
            padding: 28px 24px;
            border-bottom: 1px solid #1f2937;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icono {
            width: 40px; height: 40px;
            background: linear-gradient(135deg, #39a900, #2d8200);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: 700;
            color: white;
        }

        .logo-info h2 {
            font-size: 16px;
            font-weight: 700;
            color: #f9fafb;
        }

        .logo-info p {
            font-size: 11px;
            color: #6b7280;
        }

        .sidebar-menu {
            flex: 1;
            padding: 20px 0;
            overflow-y: auto;
        }

        .menu-seccion {
            padding: 8px 24px 4px;
            font-size: 10px;
            font-weight: 600;
            color: #4b5563;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-top: 8px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 24px;
            color: #9ca3af;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
            cursor: pointer;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
        }

        .menu-item:hover {
            background: #1f2937;
            color: #f9fafb;
        }

        .menu-item.activo {
            background: rgba(57,169,0,0.1);
            color: #39a900;
            border-right: 3px solid #39a900;
        }

        .menu-icono {
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        .sidebar-footer {
            padding: 20px 24px;
            border-top: 1px solid #1f2937;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .user-avatar {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, #39a900, #2d8200);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 700;
            color: white;
        }

        .user-datos h4 {
            font-size: 13px;
            font-weight: 600;
            color: #f9fafb;
        }

        .user-datos p {
            font-size: 11px;
            color: #6b7280;
        }

        .btn-salir {
            width: 100%;
            padding: 10px;
            background: rgba(220,38,38,0.1);
            border: 1px solid rgba(220,38,38,0.2);
            border-radius: 10px;
            color: #f87171;
            font-family: 'Outfit', sans-serif;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-salir:hover {
            background: rgba(220,38,38,0.2);
        }

        .contenido {
            margin-left: 260px;
            padding: 32px;
            min-height: 100vh;
        }

        .bienvenida {
            margin-bottom: 32px;
        }

        .bienvenida h1 {
            font-size: 28px;
            font-weight: 700;
            color: #f9fafb;
            margin-bottom: 6px;
        }

        .bienvenida p {
            font-size: 14px;
            color: #6b7280;
        }

        .tarjetas {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .tarjeta {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 16px;
            padding: 24px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
        }

        .tarjeta:hover {
            border-color: #39a900;
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.3);
        }

        .tarjeta-icono {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 16px;
        }

        .verde { background: rgba(57,169,0,0.15); }
        .azul { background: rgba(59,130,246,0.15); }
        .morado { background: rgba(139,92,246,0.15); }
        .naranja { background: rgba(249,115,22,0.15); }
        .rosa { background: rgba(236,72,153,0.15); }
        .cyan { background: rgba(6,182,212,0.15); }

        .tarjeta h3 {
            font-size: 15px;
            font-weight: 600;
            color: #f9fafb;
            margin-bottom: 6px;
        }

        .tarjeta p {
            font-size: 12px;
            color: #6b7280;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <div class="sidebar-logo">
                <div class="logo-icono">S</div>
                <div class="logo-info">
                    <h2>SENA</h2>
                    <p>Administrador</p>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="menu-seccion">Académico</div>
                <a href="Programas.aspx" class="menu-item">
                    <span class="menu-icono">📚</span> Programas
                </a>
                <a href="Fichas.aspx" class="menu-item">
                    <span class="menu-icono">📋</span> Fichas
                </a>
                <a href="Competencias.aspx" class="menu-item">
                    <span class="menu-icono">🎯</span> Competencias
                </a>
                <a href="ResultadosAprendizaje.aspx" class="menu-item">
                    <span class="menu-icono">📝</span> Resultados de Aprendizaje
                </a>

                <div class="menu-seccion">Personas</div>
                <a href="Instructores.aspx" class="menu-item">
                    <span class="menu-icono">👨‍🏫</span> Instructores
                </a>
                <a href="Aprendices.aspx" class="menu-item">
                    <span class="menu-icono">🎓</span> Aprendices
                </a>

                <div class="menu-seccion">Sistema</div>
                <a href="Usuarios.aspx" class="menu-item">
                    <span class="menu-icono">👥</span> Usuarios
                </a>
                <a href="Centros.aspx" class="menu-item">
                    <span class="menu-icono">🏢</span> Centros
                </a>
            </div>

            <div class="sidebar-footer">
                <div class="user-info">
                    <div class="user-avatar">A</div>
                    <div class="user-datos">
                        <h4><asp:Label ID="lblUsuario" runat="server" Text=""/></h4>
                        <p>Administrador</p>
                    </div>
                </div>
                <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn-salir" OnClick="btnSalir_Click"/>
            </div>
        </div>

        <div class="contenido">
            <div class="bienvenida">
                <h1>Panel de Administración</h1>
                <p>Gestiona toda la información académica del centro de formación</p>
            </div>

            <div class="tarjetas">
                <a href="Programas.aspx" class="tarjeta">
                    <div class="tarjeta-icono verde">📚</div>
                    <h3>Programas</h3>
                    <p>Gestionar programas de formación</p>
                </a>
                <a href="Fichas.aspx" class="tarjeta">
                    <div class="tarjeta-icono azul">📋</div>
                    <h3>Fichas</h3>
                    <p>Registrar y consultar fichas</p>
                </a>
                <a href="Instructores.aspx" class="tarjeta">
                    <div class="tarjeta-icono morado">👨‍🏫</div>
                    <h3>Instructores</h3>
                    <p>Gestionar instructores del centro</p>
                </a>
                <a href="Aprendices.aspx" class="tarjeta">
                    <div class="tarjeta-icono naranja">🎓</div>
                    <h3>Aprendices</h3>
                    <p>Registrar y gestionar aprendices</p>
                </a>
                <a href="Competencias.aspx" class="tarjeta">
                    <div class="tarjeta-icono rosa">🎯</div>
                    <h3>Competencias</h3>
                    <p>Administrar competencias</p>
                </a>
                <a href="Usuarios.aspx" class="tarjeta">
                    <div class="tarjeta-icono cyan">👥</div>
                    <h3>Usuarios</h3>
                    <p>Gestionar usuarios del sistema</p>
                </a>
            </div>
        </div>
    </form>
</body>
</html>