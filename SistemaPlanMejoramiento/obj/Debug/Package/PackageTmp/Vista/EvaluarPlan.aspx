<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EvaluarPlan.aspx.cs" Inherits="SistemaPlanMejoramiento.EvaluarPlan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Evaluar Plan - SENA</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet" />
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
            --border: #e2e8f0;
            --text: #1e293b;
            --muted: #64748b;
            --radius: 12px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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

        .brand-text {
            font-size: 15px;
            font-weight: 700;
            color: var(--text);
        }

        .brand-sub {
            font-size: 11px;
            color: var(--muted);
        }

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

        .user-name {
            font-size: 13px;
            font-weight: 600;
            color: var(--text);
        }

        .user-role {
            font-size: 11px;
            color: var(--muted);
        }

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
            background: var(--purple-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--purple);
            font-size: 16px;
        }

        .page-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--text);
        }

        .page-sub {
            font-size: 12px;
            color: var(--muted);
        }

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

        .content {
            padding: 24px 28px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .alert-ok {
            padding: 10px 14px;
            border-radius: 8px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #166534;
            font-size: 13px;
            margin-bottom: 16px;
            display: block;
        }

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
            justify-content: space-between;
        }

        .card-header-left {
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

        .card-body-custom {
            padding: 20px 22px;
        }

        .info-label {
            font-size: 11px;
            font-weight: 700;
            color: var(--muted);
            letter-spacing: 0.6px;
            text-transform: uppercase;
            margin-bottom: 4px;
            display: block;
        }

        .info-value {
            font-size: 14px;
            color: var(--text);
            font-weight: 500;
            display: block;
        }

        .actividades-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 14px;
            font-size: 13px;
            color: var(--text);
            line-height: 1.6;
        }

        .criterio-row {
            padding: 16px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .criterio-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .criterio-title {
            font-size: 14px;
            font-weight: 600;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .criterio-desc {
            font-size: 12px;
            color: var(--muted);
            margin-top: 2px;
        }

        .form-select-custom,
        .form-area-custom {
            width: 100%;
            padding: 9px 13px;
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            outline: none;
            transition: all 0.18s;
        }

        .form-area-custom {
            min-height: 90px;
            resize: vertical;
        }

        .form-select-custom:focus,
        .form-area-custom:focus {
            border-color: var(--green);
            box-shadow: 0 0 0 3px rgba(46,125,50,0.1);
            background: #fff;
        }

        .badge-plan {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .badge-interno { background: var(--blue-soft); color: var(--blue); }
        .badge-comite { background: var(--orange-soft); color: var(--orange); }

        .btn-save {
            padding: 10px 24px;
            background: linear-gradient(135deg, var(--green), var(--green-light));
            border: none;
            border-radius: 8px;
            color: #fff;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-save:hover:not(:disabled) {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .btn-save:disabled {
            background: #e2e8f0;
            color: #94a3b8;
            cursor: not-allowed;
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
                <a href="EvaluarPlan.aspx" class="nav-link active"><i class="fa-solid fa-star"></i>Evaluar Plan</a>
                <a href="RevisarEvidencias.aspx" class="nav-link"><i class="fa-solid fa-paperclip"></i>Revisar Evidencias</a>
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
                    <div class="page-icon"><i class="fa-solid fa-star"></i></div>
                    <div>
                        <div class="page-title">Evaluar Plan de Mejoramiento</div>
                        <div class="page-sub">Evalúa los criterios del plan asignado al aprendiz</div>
                    </div>
                </div>

                <a href="GestionPlanes.aspx" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i>Volver a planes
                </a>
            </div>

            <div class="content">
                <asp:Label ID="lblMensajeOk" runat="server" CssClass="alert-ok" Visible="false" />
                <asp:Label ID="lblMensajeError" runat="server" CssClass="alert-err" Visible="false" />

                <asp:HiddenField ID="hfIdPlan" runat="server" Value="0" />
                <asp:HiddenField ID="hfIdAprendiz" runat="server" Value="0" />
                <asp:HiddenField ID="hfIdInstructor" runat="server" Value="0" />
                <asp:HiddenField ID="hfTipoPlan" runat="server" Value="" />

                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="card-header-left">
                            <div class="ch-icon"><i class="fa-solid fa-info"></i></div>
                            <div class="ch-title">Información del Plan</div>
                        </div>
                    </div>

                    <div class="card-body-custom">
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <span class="info-label">Aprendiz</span>
                                <span class="info-value"><asp:Label ID="lblAprendiz" runat="server" /></span>
                            </div>
                            <div class="col-md-4">
                                <span class="info-label">Instructor</span>
                                <span class="info-value"><asp:Label ID="lblInstructor" runat="server" /></span>
                            </div>
                            <div class="col-md-4">
                                <span class="info-label">Tipo de Plan</span>
                                <span class="info-value"><asp:Label ID="lblTipoPlan" runat="server" /></span>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <span class="info-label">Fecha Límite</span>
                                <span class="info-value"><asp:Label ID="lblFechaLimite" runat="server" /></span>
                            </div>
                            <div class="col-md-4">
                                <span class="info-label">Estado Actual</span>
                                <span class="info-value"><asp:Label ID="lblEstadoPlan" runat="server" /></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <span class="info-label">Actividades Registradas</span>
                                <div class="actividades-box">
                                    <asp:Label ID="lblActividades" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="card-header-left">
                            <div class="ch-icon"><i class="fa-solid fa-list-check"></i></div>
                            <div class="ch-title">Evaluación de Criterios</div>
                        </div>
                    </div>

                    <div class="card-body-custom">
                        <div class="criterio-row">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-7">
                                    <div class="criterio-title"><i class="fa-solid fa-box-open text-secondary"></i> Producto</div>
                                    <div class="criterio-desc">Evaluación de la evidencia o producto entregado por el aprendiz.</div>
                                </div>
                                <div class="col-md-5">
                                    <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select-custom">
                                        <asp:ListItem Text="Seleccione..." Value="" />
                                        <asp:ListItem Text="Aprobado" Value="Aprobado" />
                                        <asp:ListItem Text="No Aprobado" Value="No Aprobado" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="criterio-row">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-7">
                                    <div class="criterio-title"><i class="fa-solid fa-user-gear text-secondary"></i> Desempeño</div>
                                    <div class="criterio-desc">Evaluación del comportamiento, puntualidad y ejecución del aprendiz.</div>
                                </div>
                                <div class="col-md-5">
                                    <asp:DropDownList ID="ddlDesempeno" runat="server" CssClass="form-select-custom">
                                        <asp:ListItem Text="Seleccione..." Value="" />
                                        <asp:ListItem Text="Aprobado" Value="Aprobado" />
                                        <asp:ListItem Text="No Aprobado" Value="No Aprobado" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="criterio-row">
                            <div class="row g-3 align-items-center">
                                <div class="col-md-7">
                                    <div class="criterio-title"><i class="fa-solid fa-brain text-secondary"></i> Conocimiento</div>
                                    <div class="criterio-desc">Evaluación del dominio conceptual y teórico demostrado en la sustentación.</div>
                                </div>
                                <div class="col-md-5">
                                    <asp:DropDownList ID="ddlConocimiento" runat="server" CssClass="form-select-custom">
                                        <asp:ListItem Text="Seleccione..." Value="" />
                                        <asp:ListItem Text="Aprobado" Value="Aprobado" />
                                        <asp:ListItem Text="No Aprobado" Value="No Aprobado" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12">
                                <label class="info-label">Observaciones de la Evaluación</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-area-custom" TextMode="MultiLine" placeholder="Escribe aquí los comentarios detallados de la retroalimentación..." />
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12 d-flex gap-2">
                                <asp:Button ID="btnEvaluar" runat="server" Text="Registrar Evaluación" CssClass="btn-save" OnClick="btnEvaluar_Click" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>