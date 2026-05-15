<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuInstructor.aspx.cs" Inherits="SistemaPlanMejoramiento.MenuInstructor" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Menu Instructor - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: #0f172a; min-height: 100vh; color: #f9fafb; }
        .sidebar { position: fixed; left: 0; top: 0; width: 260px; height: 100vh; background: #111827; border-right: 1px solid #1f2937; display: flex; flex-direction: column; z-index: 100; }
        .sidebar-logo { padding: 28px 24px; border-bottom: 1px solid #1f2937; display: flex; align-items: center; gap: 12px; }
        .logo-icono { width: 40px; height: 40px; background: linear-gradient(135deg, #39a900, #2d8200); border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: 700; color: white; }
        .logo-info h2 { font-size: 16px; font-weight: 700; color: #f9fafb; }
        .logo-info p { font-size: 11px; color: #6b7280; }
        .sidebar-menu { flex: 1; padding: 20px 0; }
        .menu-seccion { padding: 8px 24px 4px; font-size: 10px; font-weight: 600; color: #4b5563; letter-spacing: 1.5px; text-transform: uppercase; margin-top: 8px; }
        .menu-item { display: flex; align-items: center; gap: 12px; padding: 11px 24px; color: #9ca3af; text-decoration: none; font-size: 14px; font-weight: 500; transition: all 0.2s; }
        .menu-item:hover { background: #1f2937; color: #f9fafb; }
        .menu-icono { font-size: 18px; width: 24px; text-align: center; }
        .sidebar-footer { padding: 20px 24px; border-top: 1px solid #1f2937; }
        .user-info { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }
        .user-avatar { width: 36px; height: 36px; background: linear-gradient(135deg, #3b82f6, #1d4ed8); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 700; color: white; }
        .user-datos h4 { font-size: 13px; font-weight: 600; color: #f9fafb; }
        .user-datos p { font-size: 11px; color: #6b7280; }
        .btn-salir { width: 100%; padding: 10px; background: rgba(220,38,38,0.1); border: 1px solid rgba(220,38,38,0.2); border-radius: 10px; color: #f87171; font-family: 'Outfit', sans-serif; font-size: 13px; font-weight: 500; cursor: pointer; transition: all 0.2s; }
        .btn-salir:hover { background: rgba(220,38,38,0.2); }
        .contenido { margin-left: 260px; padding: 32px; min-height: 100vh; }
        .bienvenida { margin-bottom: 32px; }
        .bienvenida h1 { font-size: 28px; font-weight: 700; color: #f9fafb; margin-bottom: 6px; }
        .bienvenida p { font-size: 14px; color: #6b7280; }
        .tarjetas { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
        .tarjeta { background: #111827; border: 1px solid #1f2937; border-radius: 16px; padding: 24px; cursor: pointer; transition: all 0.3s; text-decoration: none; display: block; }
        .tarjeta:hover { border-color: #39a900; transform: translateY(-3px); box-shadow: 0 12px 30px rgba(0,0,0,0.3); }
        .tarjeta-icono { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px; margin-bottom: 16px; }
        .verde { background: rgba(57,169,0,0.15); }
        .azul { background: rgba(59,130,246,0.15); }
        .morado { background: rgba(139,92,246,0.15); }
        .naranja { background: rgba(249,115,22,0.15); }
        .tarjeta h3 { font-size: 15px; font-weight: 600; color: #f9fafb; margin-bottom: 6px; }
        .tarjeta p { font-size: 12px; color: #6b7280; line-height: 1.5; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <div class="sidebar-logo">
                <div class="logo-icono">S</div>
                <div class="logo-info">
                    <h2>SENA</h2>
                    <p>Instructor</p>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="menu-seccion">Mis Fichas</div>
                <a href="MisFichas.aspx" class="menu-item">
                    <span class="menu-icono">📋</span> Mis Fichas
                </a>
                <a href="MisAprendices.aspx" class="menu-item">
                    <span class="menu-icono">🎓</span> Mis Aprendices
                </a>

                <div class="menu-seccion">Planes</div>
                <a href="PlanesInstructor.aspx" class="menu-item">
                    <span class="menu-icono">📝</span> Planes de Mejoramiento
                </a>
                <a href="Evaluaciones.aspx" class="menu-item">
                    <span class="menu-icono">✅</span> Evaluaciones
                </a>
                <a href="Evidencias.aspx" class="menu-item">
                    <span class="menu-icono">📎</span> Evidencias
                </a>
            </div>

            <div class="sidebar-footer">
                <div class="user-info">
                    <div class="user-avatar">I</div>
                    <div class="user-datos">
                        <h4><asp:Label ID="lblUsuario" runat="server" Text=""/></h4>
                        <p>Instructor</p>
                    </div>
                </div>
                <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn-salir" OnClick="btnSalir_Click"/>
            </div>
        </div>

        <div class="contenido">
            <div class="bienvenida">
                <h1>Panel del Instructor</h1>
                <p>Gestiona los planes de mejoramiento de tus aprendices</p>
            </div>

            <div class="tarjetas">
                <a href="MisFichas.aspx" class="tarjeta">
                    <div class="tarjeta-icono azul">📋</div>
                    <h3>Mis Fichas</h3>
                    <p>Consultar fichas asignadas</p>
                </a>
                <a href="MisAprendices.aspx" class="tarjeta">
                    <div class="tarjeta-icono verde">🎓</div>
                    <h3>Mis Aprendices</h3>
                    <p>Ver aprendices de mis fichas</p>
                </a>
                <a href="PlanesInstructor.aspx" class="tarjeta">
                    <div class="tarjeta-icono morado">📝</div>
                    <h3>Planes</h3>
                    <p>Crear y gestionar planes de mejoramiento</p>
                </a>
                <a href="Evaluaciones.aspx" class="tarjeta">
                    <div class="tarjeta-icono naranja">✅</div>
                    <h3>Evaluaciones</h3>
                    <p>Evaluar producto, conocimiento y desempeño</p>
                </a>
            </div>
        </div>
    </form>
</body>
</html>