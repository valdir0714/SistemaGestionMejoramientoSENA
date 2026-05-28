<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuInstructor.aspx.cs" Inherits="SistemaPlanMejoramiento.MenuInstructor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Panel Instructor - SENA</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        :root {
            --green: #2e7d32;
            --green-light: #43a047;
            --green-soft: #e8f5e9;
            --blue: #1565c0;
            --blue-soft: #e3f2fd;
            --orange: #e65100;
            --orange-soft: #fff3e0;
            --purple: #6a1b9a;
            --purple-soft: #f3e5f5;
            --red: #c62828;
            --red-soft: #ffebee;
            --sidebar-w: 240px;
            --bg: #f0f2f5;
            --card: #ffffff;
            --border: #e2e8f0;
            --text: #1e293b;
            --muted: #64748b;
            --radius: 12px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: var(--sidebar-w);
            height: 100vh;
            background: #fff;
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            z-index: 100;
            box-shadow: 2px 0 12px rgba(0,0,0,0.06);
        }

        .sidebar-brand {
            padding: 20px 20px 16px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .brand-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--green), var(--green-light));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
            font-size: 16px;
        }

        .brand-text { font-size: 15px; font-weight: 700; color: var(--text); }
        .brand-sub { font-size: 11px; color: var(--muted); }

        .sidebar-nav {
            flex: 1;
            padding: 16px 0;
            overflow-y: auto;
        }

        .nav-section {
            padding: 6px 16px 4px;
            font-size: 10px;
            font-weight: 700;
            color: var(--muted);
            letter-spacing: 1.2px;
            text-transform: uppercase;
            margin-top: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 9px 16px;
            color: var(--muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            border-radius: 8px;
            margin: 1px 8px;
            transition: all 0.18s;
        }

        .nav-link:hover,
        .nav-link.active {
            background: var(--green-soft);
            color: var(--green);
            font-weight: 600;
        }

        .nav-link i {
            width: 18px;
            text-align: center;
            font-size: 14px;
        }

        .sidebar-footer {
            padding: 16px;
            border-top: 1px solid var(--border);
        }

        .user-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .user-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), #1976d2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 13px;
        }

        .user-name { font-size: 13px; font-weight: 600; color: var(--text); }
        .user-role { font-size: 11px; color: var(--muted); }

        .btn-logout {
            width: 100%;
            padding: 8px;
            background: #fff1f2;
            border: 1px solid #fecdd3;
            border-radius: 8px;
            color: #e11d48;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-logout:hover { background: #ffe4e6; }

        .main {
            margin-left: var(--sidebar-w);
            min-height: 100vh;
        }

        .topbar {
            background: #fff;
            border-bottom: 1px solid var(--border);
            padding: 14px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: var(--green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--green);
            font-size: 16px;
        }

        .page-title { font-size: 16px; font-weight: 700; color: var(--text); }
        .page-sub { font-size: 12px; color: var(--muted); }

        .role-badge {
            padding: 6px 14px;
            border-radius: 20px;
            background: var(--green-soft);
            color: var(--green);
            font-size: 12px;
            font-weight: 700;
        }

        .content { padding: 28px; }

        .welcome-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 22px 24px;
            margin-bottom: 22px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .welcome-card h2 {
            font-size: 20px;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 4px;
        }

        .welcome-card p {
            font-size: 13px;
            color: var(--muted);
            margin: 0;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .stat-icon {
            width: 42px;
            height: 42px;
            border-radius: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
        }

        .stat-card p {
            font-size: 12px;
            color: var(--muted);
            margin: 0;
            font-weight: 600;
        }

        .stat-card h3 {
            font-size: 22px;
            font-weight: 800;
            color: var(--text);
            margin: 2px 0 0;
        }

        .icon-green { background: var(--green-soft); color: var(--green); }
        .icon-blue { background: var(--blue-soft); color: var(--blue); }
        .icon-orange { background: var(--orange-soft); color: var(--orange); }
        .icon-purple { background: var(--purple-soft); color: var(--purple); }
        .icon-red { background: var(--red-soft); color: var(--red); }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.4fr 0.8fr;
            gap: 18px;
        }

        .panel-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .panel-header {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .ch-icon {
            width: 30px;
            height: 30px;
            border-radius: 8px;
            background: var(--green-soft);
            color: var(--green);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
        }

        .panel-header h3 {
            font-size: 14px;
            font-weight: 700;
            color: var(--text);
            margin: 0;
        }

        .panel-header p {
            font-size: 11px;
            color: var(--muted);
            margin: 1px 0 0;
        }

        .activity-list { padding: 10px 20px 14px; }

        .activity-item {
            display: flex;
            gap: 12px;
            padding: 14px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .activity-item:last-child { border-bottom: none; }

        .activity-dot {
            width: 9px;
            height: 9px;
            border-radius: 50%;
            margin-top: 6px;
            flex-shrink: 0;
        }

        .dot-orange { background: var(--orange); }
        .dot-blue { background: var(--blue); }
        .dot-green { background: var(--green); }

        .activity-item h4 {
            font-size: 13px;
            font-weight: 700;
            color: var(--text);
            margin: 0 0 3px;
        }

        .activity-item p {
            font-size: 12px;
            color: var(--muted);
            margin: 0;
        }

        .quick-actions {
            padding: 14px;
            display: grid;
            gap: 10px;
        }

        .quick-action {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 10px;
            text-decoration: none;
            color: var(--text);
            font-size: 13px;
            font-weight: 600;
            transition: all 0.18s;
        }

        .quick-action:hover {
            border-color: var(--green);
            background: var(--green-soft);
            color: var(--green);
        }

        .qa-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            flex-shrink: 0;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="sidebar">
        <div class="sidebar-brand">
            <div class="brand-icon">S</div>
            <div>
                <div class="brand-text">SENA</div>
                <div class="brand-sub">Sistema de Gestión</div>
            </div>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">Mis Fichas</div>
            <a href="MisFichas.aspx" class="nav-link"><i class="fa-solid fa-folder-open"></i> Mis Fichas</a>
            <a href="MisAprendices.aspx" class="nav-link"><i class="fa-solid fa-user-graduate"></i> Mis Aprendices</a>

            <div class="nav-section">Planes</div>
            <a href="GestionPlanes.aspx" class="nav-link"><i class="fa-solid fa-clipboard-list"></i> Planes de Mejoramiento</a>
            <a href="EvaluarPlan.aspx" class="nav-link"><i class="fa-solid fa-star"></i> Evaluar Plan</a>
            <a href="RevisarEvidencias.aspx" class="nav-link"><i class="fa-solid fa-paperclip"></i> Revisar Evidencias</a>
        </nav>

        <div class="sidebar-footer">
            <div class="user-row">
                <div class="user-avatar">I</div>
                <div>
                    <div class="user-name">
                        <asp:Label ID="lblUsuario" runat="server" Text="" />
                    </div>
                    <div class="user-role">Instructor</div>
                </div>
            </div>

            <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn-logout" OnClick="btnSalir_Click" />
        </div>
    </div>

    <div class="main">
        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-chalkboard-user"></i></div>
                <div>
                    <div class="page-title">Panel del Instructor</div>
                    <div class="page-sub">Gestiona fichas, aprendices, planes y evidencias asignadas</div>
                </div>
            </div>

            <span class="role-badge"><i class="fa-solid fa-user-tie"></i> Instructor</span>
        </div>

        <div class="content">
            <div class="welcome-card">
                <h2>Bienvenido, <asp:Label ID="lblUsuarioBienvenida" runat="server" Text="" /></h2>
                <p>Consulta tus fichas asignadas y realiza seguimiento a los planes de mejoramiento.</p>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon icon-blue"><i class="fa-solid fa-folder-open"></i></div>
                    <div>
                        <p>Mis Fichas</p>
                        <h3><asp:Label ID="lblTotalFichas" runat="server" Text="0" /></h3>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-green"><i class="fa-solid fa-user-graduate"></i></div>
                    <div>
                        <p>Aprendices</p>
                        <h3><asp:Label ID="lblTotalAprendices" runat="server" Text="0" /></h3>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-orange"><i class="fa-solid fa-clock"></i></div>
                    <div>
                        <p>Planes Pendientes</p>
                        <h3><asp:Label ID="lblPlanesPendientes" runat="server" Text="0" /></h3>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon icon-red"><i class="fa-solid fa-paperclip"></i></div>
                    <div>
                        <p>Evidencias Nuevas</p>
                        <h3><asp:Label ID="lblEvidenciasNuevas" runat="server" Text="0" /></h3>
                    </div>
                </div>
            </div>

            <div class="dashboard-grid">
                <div class="panel-card">
                    <div class="panel-header">
                        <div class="ch-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                        <div>
                            <h3>Actividad Reciente</h3>
                            <p>Últimos movimientos registrados</p>
                        </div>
                    </div>

                    <div class="activity-list">
                        <asp:Literal ID="ltActividadReciente" runat="server" />
                    </div>
                </div>

                <div class="panel-card">
                    <div class="panel-header">
                        <div class="ch-icon"><i class="fa-solid fa-bolt"></i></div>
                        <div>
                            <h3>Acciones Rápidas</h3>
                            <p>Atajos frecuentes del instructor</p>
                        </div>
                    </div>

                    <div class="quick-actions">
                        <a href="GestionPlanes.aspx" class="quick-action">
                            <span class="qa-icon icon-purple"><i class="fa-solid fa-plus"></i></span>
                            <span>Crear plan</span>
                        </a>

                        <a href="EvaluarPlan.aspx" class="quick-action">
                            <span class="qa-icon icon-orange"><i class="fa-solid fa-star"></i></span>
                            <span>Evaluar plan</span>
                        </a>

                        <a href="RevisarEvidencias.aspx" class="quick-action">
                            <span class="qa-icon icon-red"><i class="fa-solid fa-paperclip"></i></span>
                            <span>Revisar evidencias</span>
                        </a>

                        <a href="MisAprendices.aspx" class="quick-action">
                            <span class="qa-icon icon-green"><i class="fa-solid fa-user-graduate"></i></span>
                            <span>Ver aprendices</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</form>
</body>
</html>