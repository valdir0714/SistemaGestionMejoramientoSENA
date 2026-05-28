<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisFichas.aspx.cs" Inherits="SistemaPlanMejoramiento.MisFichas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mis Fichas - SENA</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        :root {
            --green: #2e7d32;
            --green-light: #43a047;
            --green-soft: #e8f5e9;
            --blue: #1565c0;
            --blue-soft: #e3f2fd;
            --sidebar-w: 240px;
            --bg: #f0f2f5;
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
            color: #fff;
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
        }

        .user-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), #1976d2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 13px;
        }

        .user-name { font-size: 13px; font-weight: 600; color: var(--text); }
        .user-role { font-size: 11px; color: var(--muted); }

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

        .btn-back {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 7px 14px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--muted);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.18s;
        }

        .btn-back:hover {
            border-color: var(--green);
            color: var(--green);
        }

        .content { padding: 24px 28px; }

        .alert-err {
            padding: 10px 14px;
            border-radius: 8px;
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #9f1239;
            font-size: 13px;
            margin-bottom: 16px;
            display: block;
        }

        .card-custom {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            margin-bottom: 22px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .card-header-custom {
            padding: 16px 22px 14px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .ch-icon {
            width: 28px;
            height: 28px;
            border-radius: 8px;
            background: var(--green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--green);
            font-size: 13px;
        }

        .ch-title {
            font-size: 14px;
            font-weight: 700;
            color: var(--text);
        }

        .table-wrapper { overflow-x: auto; }

        .table-custom {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .table-custom thead th {
            background: #f8fafc;
            color: var(--muted);
            padding: 10px 14px;
            text-align: left;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border-bottom: 1px solid var(--border);
        }

        .table-custom tbody tr {
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.15s;
        }

        .table-custom tbody tr:hover { background: #f8fafc; }

        .table-custom tbody td {
            padding: 11px 14px;
            color: var(--text);
            vertical-align: middle;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: var(--muted);
        }

        .empty-state i {
            font-size: 36px;
            margin-bottom: 10px;
            opacity: 0.3;
            display: block;
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
            <a href="MisFichas.aspx" class="nav-link active"><i class="fa-solid fa-folder-open"></i> Mis Fichas</a>
            <a href="MisAprendices.aspx" class="nav-link"><i class="fa-solid fa-user-graduate"></i> Mis Aprendices</a>

            <div class="nav-section">Planes</div>
            <a href="GestionPlanes.aspx" class="nav-link"><i class="fa-solid fa-clipboard-list"></i> Planes de Mejoramiento</a>
            <a href="EvaluarPlan.aspx" class="nav-link"><i class="fa-solid fa-star"></i> Evaluar Plan</a>
            <a href="Evidencias.aspx" class="nav-link"><i class="fa-solid fa-paperclip"></i> Evidencias</a>
        </nav>

        <div class="sidebar-footer">
            <div class="user-row">
                <div class="user-avatar">I</div>
                <div>
                    <div class="user-name">Instructor</div>
                    <div class="user-role">Rol activo</div>
                </div>
            </div>
        </div>
    </div>

    <div class="main">
        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-folder-open"></i></div>
                <div>
                    <div class="page-title">Mis Fichas</div>
                    <div class="page-sub">Fichas asignadas a tu perfil</div>
                </div>
            </div>

            <a href="MenuInstructor.aspx" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Volver al menú
            </a>
        </div>

        <div class="content">
            <asp:Label ID="lblError" runat="server" CssClass="alert-err" Visible="false" />

            <div class="card-custom">
                <div class="card-header-custom">
                    <div class="ch-icon"><i class="fa-solid fa-table-list"></i></div>
                    <div class="ch-title">Fichas Asignadas</div>
                </div>

                <div class="table-wrapper">
                    <asp:GridView ID="gvFichas" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table-custom"
                        GridLines="None">

                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fa-solid fa-folder-open"></i>
                                <p>No tienes fichas asignadas.</p>
                            </div>
                        </EmptyDataTemplate>

                        <Columns>
                            <asp:BoundField DataField="CodigoFicha" HeaderText="Código" />
                            <asp:BoundField DataField="NombrePrograma" HeaderText="Programa" />
                            <asp:BoundField DataField="FechaInicio" HeaderText="Inicio" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="FechaFin" HeaderText="Fin" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Jornada" HeaderText="Jornada" />
                            <asp:BoundField DataField="Estado" HeaderText="Estado" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

</form>
</body>
</html>