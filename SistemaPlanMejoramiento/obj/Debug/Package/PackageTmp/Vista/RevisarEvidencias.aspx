<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RevisarEvidencias.aspx.cs" Inherits="SistemaPlanMejoramiento.RevisarEvidencias" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Revisar Evidencias - SENA</title>

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
            left: 0; top: 0;
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
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--green), var(--green-light));
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            color: white; font-weight: 800; font-size: 16px;
        }

        .brand-text { font-size: 15px; font-weight: 700; color: var(--text); }
        .brand-sub  { font-size: 11px; color: var(--muted); }

        .sidebar-nav { flex: 1; padding: 16px 0; overflow-y: auto; }

        .nav-section {
            padding: 6px 16px 4px;
            font-size: 10px; font-weight: 700; color: var(--muted);
            letter-spacing: 1.2px; text-transform: uppercase; margin-top: 8px;
        }

        .nav-link {
            display: flex; align-items: center; gap: 10px;
            padding: 9px 16px;
            color: var(--muted); text-decoration: none;
            font-size: 13px; font-weight: 500;
            border-radius: 8px; margin: 1px 8px;
            transition: all 0.18s;
        }
        .nav-link:hover, .nav-link.active {
            background: var(--green-soft); color: var(--green); font-weight: 600;
        }
        .nav-link i { width: 18px; text-align: center; font-size: 14px; }

        .sidebar-footer { padding: 16px; border-top: 1px solid var(--border); }

        .user-row { display: flex; align-items: center; gap: 10px; margin-bottom: 12px; }

        .user-avatar {
            width: 34px; height: 34px; border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), #1976d2);
            display: flex; align-items: center; justify-content: center;
            color: white; font-weight: 700; font-size: 13px;
        }

        .user-name  { font-size: 13px; font-weight: 600; color: var(--text); }
        .user-role  { font-size: 11px; color: var(--muted); }

        .btn-logout {
            width: 100%; padding: 8px;
            background: #fff1f2; border: 1px solid #fecdd3;
            border-radius: 8px; color: #e11d48;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: all 0.18s;
        }
        .btn-logout:hover { background: #ffe4e6; }

        .main { margin-left: var(--sidebar-w); min-height: 100vh; }

        .topbar {
            background: #fff; border-bottom: 1px solid var(--border);
            padding: 14px 28px;
            display: flex; align-items: center; justify-content: space-between;
            position: sticky; top: 0; z-index: 50;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .topbar-left { display: flex; align-items: center; gap: 12px; }

        .page-icon {
            width: 38px; height: 38px; border-radius: 10px;
            background: var(--red-soft);
            display: flex; align-items: center; justify-content: center;
            color: var(--red); font-size: 16px;
        }

        .page-title { font-size: 16px; font-weight: 700; color: var(--text); }
        .page-sub   { font-size: 12px; color: var(--muted); }

        .role-badge {
            padding: 6px 14px; border-radius: 20px;
            background: var(--green-soft); color: var(--green);
            font-size: 12px; font-weight: 700;
        }

        .content { padding: 28px; }

        .filtros-card {
            background: #fff; border: 1px solid var(--border);
            border-radius: var(--radius); padding: 18px 22px;
            margin-bottom: 22px; box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            display: flex; align-items: flex-end; gap: 16px; flex-wrap: wrap;
        }

        .filtro-grupo { display: flex; flex-direction: column; gap: 5px; flex: 1; min-width: 180px; }
        .filtro-grupo label {
            font-size: 11px; font-weight: 700; color: var(--muted);
            text-transform: uppercase; letter-spacing: 0.8px;
        }
        .filtro-grupo select {
            padding: 8px 12px; border: 1px solid var(--border);
            border-radius: 8px; font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px; color: var(--text); background: #fff;
        }

        .btn-filtrar {
            padding: 9px 20px; background: var(--green); color: white;
            border: none; border-radius: 8px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px; font-weight: 600; cursor: pointer;
            transition: all 0.18s; white-space: nowrap;
        }
        .btn-filtrar:hover { background: var(--green-light); }

        .table-card {
            background: #fff; border: 1px solid var(--border);
            border-radius: var(--radius); box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .table-header {
            padding: 16px 22px; border-bottom: 1px solid var(--border);
            display: flex; align-items: center; gap: 10px;
        }

        .th-icon {
            width: 30px; height: 30px; border-radius: 8px;
            background: var(--red-soft); color: var(--red);
            display: flex; align-items: center; justify-content: center; font-size: 13px;
        }

        .table-header h3 { font-size: 14px; font-weight: 700; color: var(--text); margin: 0; }
        .table-header p  { font-size: 11px; color: var(--muted); margin: 1px 0 0; }

        .gv-wrapper { overflow-x: auto; }

        .gv-evidencias { width: 100%; border-collapse: collapse; font-size: 13px; }
        .gv-evidencias th {
            background: #f8fafc; padding: 11px 16px; text-align: left;
            font-size: 11px; font-weight: 700; color: var(--muted);
            text-transform: uppercase; letter-spacing: 0.7px;
            border-bottom: 1px solid var(--border);
        }
        .gv-evidencias td {
            padding: 12px 16px; border-bottom: 1px solid #f1f5f9;
            color: var(--text); vertical-align: middle;
        }
        .gv-evidencias tr:last-child td { border-bottom: none; }
        .gv-evidencias tr:hover td { background: #f8fafc; }

        .badge-tipo {
            display: inline-block; padding: 3px 8px;
            border-radius: 6px; font-size: 11px; font-weight: 700; text-transform: uppercase;
        }
        .badge-pdf  { background: #fee2e2; color: #b91c1c; }
        .badge-img  { background: #dbeafe; color: #1d4ed8; }
        .badge-doc  { background: #dcfce7; color: #15803d; }
        .badge-otro { background: #f3f4f6; color: #374151; }

        .btn-descargar {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 5px 12px;
            background: var(--blue-soft); color: var(--blue);
            border: none; border-radius: 7px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: all 0.18s;
        }
        .btn-descargar:hover { background: var(--blue); color: #fff; }

        .empty-state { text-align: center; padding: 50px 20px; color: var(--muted); }
        .empty-state i { font-size: 36px; opacity: 0.3; margin-bottom: 10px; display: block; }
        .empty-state p { font-size: 13px; }

        .msg-error {
            background: var(--red-soft); color: var(--red);
            border: 1px solid #fca5a5; border-radius: 8px;
            padding: 10px 16px; font-size: 13px; margin-bottom: 16px;
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
                <a href="MisFichas.aspx" class="nav-link"><i class="fa-solid fa-folder-open"></i>Mis Fichas</a>
                <a href="MisAprendices.aspx" class="nav-link"><i class="fa-solid fa-user-graduate"></i>Mis Aprendices</a>

                <div class="nav-section">Planes</div>
                <a href="GestionPlanes.aspx" class="nav-link"><i class="fa-solid fa-clipboard-list"></i>Planes de Mejoramiento</a>
                <a href="EvaluarPlan.aspx" class="nav-link"><i class="fa-solid fa-star"></i>Evaluar Plan</a>
                <a href="RevisarEvidencias.aspx" class="nav-link active"><i class="fa-solid fa-paperclip"></i>Revisar Evidencias</a>
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
                    <div class="page-icon"><i class="fa-solid fa-paperclip"></i></div>
                    <div>
                        <div class="page-title">Revisar Evidencias</div>
                        <div class="page-sub">Evidencias subidas por tus aprendices</div>
                    </div>
                </div>
                <span class="role-badge"><i class="fa-solid fa-user-tie"></i> Instructor</span>
            </div>

            <div class="content">

                <asp:Label ID="lblError" runat="server" CssClass="msg-error" Visible="false" />

                <div class="filtros-card">
                    <div class="filtro-grupo">
                        <label>Filtrar por aprendiz</label>
                        <asp:DropDownList ID="ddlAprendiz" runat="server" AutoPostBack="false" />
                    </div>
                    <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn-filtrar" OnClick="btnFiltrar_Click" />
                </div>

                <div class="table-card">
                    <div class="table-header">
                        <div class="th-icon"><i class="fa-solid fa-paperclip"></i></div>
                        <div>
                            <h3>Evidencias Registradas</h3>
                            <p>Archivos subidos por los aprendices asignados</p>
                        </div>
                    </div>

                    <div class="gv-wrapper">
                        <asp:GridView ID="gvEvidencias" runat="server"
                            CssClass="gv-evidencias"
                            AutoGenerateColumns="false"
                            GridLines="None"
                            EmptyDataText="">
                            <EmptyDataTemplate>
                                <div class="empty-state">
                                    <i class="fa-solid fa-paperclip"></i>
                                    <p>No hay evidencias registradas.</p>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="NombreAprendiz" HeaderText="Aprendiz" />
                                <asp:BoundField DataField="TipoPlan"       HeaderText="Tipo de Plan" />
                                <asp:BoundField DataField="NombreArchivo"  HeaderText="Archivo" />
                                <asp:TemplateField HeaderText="Tipo">
                                    <ItemTemplate>
                                        <span class='<%# GetBadgeTipo(Eval("TipoArchivo").ToString()) %>'>
                                            <%# Eval("TipoArchivo") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="FechaSubida"    HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                                <asp:BoundField DataField="Observaciones"  HeaderText="Observaciones" />
                                <asp:TemplateField HeaderText="Descargar">
                                    <ItemTemplate>
                                        <asp:Button runat="server"
                                            Text="⬇ Descargar"
                                            CommandArgument='<%# Eval("NombreArchivo") %>'
                                            OnClick="btnDescargar_Click"
                                            CssClass="btn-descargar" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>

    </form>
</body>
</html>
