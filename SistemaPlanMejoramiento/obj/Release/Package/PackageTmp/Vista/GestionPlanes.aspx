<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionPlanes.aspx.cs" Inherits="SistemaPlanMejoramiento.GestionPlanes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Planes de Mejoramiento - SENA</title>

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

            .nav-link:hover, .nav-link.active {
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
            background: var(--green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--green);
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
            padding: 8px 16px;
            border-radius: 8px;
            background: var(--green-soft);
            color: var(--green);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.18s;
        }

            .btn-back:hover {
                background: var(--green);
                color: #fff;
            }

        .content {
            padding: 24px 28px;
            max-width: 900px;
            margin: 0 auto;
        }

        .alert-ok {
            display: block;
            padding: 12px 16px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: var(--radius);
            color: #15803d;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .alert-err {
            display: block;
            padding: 12px 16px;
            background: #fff1f2;
            border: 1px solid #fecdd3;
            border-radius: var(--radius);
            color: #e11d48;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .card-custom {
            background: #fff;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            margin-bottom: 24px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        }

        .card-header-custom {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .ch-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            background: var(--green-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--green);
            font-size: 14px;
        }

        .ch-title {
            font-size: 14px;
            font-weight: 700;
            color: var(--text);
        }

        .card-body-custom {
            padding: 20px;
        }

        .form-label-custom {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: var(--muted);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control-custom, .form-select-custom {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 13px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text);
            background: #fff;
            transition: border-color 0.18s;
        }

            .form-control-custom:focus, .form-select-custom:focus {
                outline: none;
                border-color: var(--green);
                box-shadow: 0 0 0 3px rgba(46,125,50,0.1);
            }

        .form-area-custom {
            width: 100%;
            padding: 9px 12px;
            min-height: 90px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 13px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text);
            resize: vertical;
        }

            .form-area-custom:focus {
                outline: none;
                border-color: var(--green);
                box-shadow: 0 0 0 3px rgba(46,125,50,0.1);
            }

        /* FILE UPLOAD */
        .file-upload-box {
            border: 2px dashed var(--border);
            border-radius: 10px;
            padding: 16px 20px;
            background: #fafafa;
            display: flex;
            align-items: center;
            gap: 14px;
            transition: border-color 0.2s;
        }

            .file-upload-box:hover {
                border-color: var(--green);
            }

        .file-upload-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--red-soft);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e11d48;
            font-size: 18px;
            flex-shrink: 0;
        }

        .file-upload-info {
            flex: 1;
        }

        .file-upload-label {
            font-size: 13px;
            font-weight: 600;
            color: var(--text);
        }

        .file-upload-hint {
            font-size: 11px;
            color: var(--muted);
            margin-top: 2px;
        }

        .file-upload-input {
            font-size: 12px;
            color: var(--muted);
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .btn-save {
            padding: 9px 22px;
            border-radius: 8px;
            background: var(--green);
            border: none;
            color: #fff;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.18s;
        }

            .btn-save:hover {
                background: var(--green-light);
            }

        .btn-cancel {
            padding: 9px 22px;
            border-radius: 8px;
            background: #f1f5f9;
            border: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        .table-custom {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

            .table-custom thead tr {
                background: #f8fafc;
                border-bottom: 2px solid var(--border);
            }

            .table-custom thead th {
                padding: 11px 14px;
                text-align: left;
                font-size: 11px;
                font-weight: 700;
                color: var(--muted);
                text-transform: uppercase;
                letter-spacing: 0.6px;
                white-space: nowrap;
            }

            .table-custom tbody tr {
                border-bottom: 1px solid var(--border);
                transition: background 0.15s;
            }

                .table-custom tbody tr:hover {
                    background: #f8fafc;
                }

            .table-custom tbody td {
                padding: 11px 14px;
                vertical-align: middle;
            }

        .badge-plan {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .badge-pendiente {
            background: var(--orange-soft);
            color: var(--orange);
        }

        .badge-aprobado {
            background: var(--green-soft);
            color: var(--green);
        }

        .badge-noaprobado {
            background: var(--red-soft);
            color: var(--red);
        }

        .badge-proceso {
            background: var(--blue-soft);
            color: var(--blue);
        }

        .badge-otro {
            background: #f1f5f9;
            color: var(--muted);
        }

        .btn-edit {
            padding: 5px 11px;
            border-radius: 6px;
            background: var(--blue-soft);
            border: 1px solid #bfdbfe;
            color: var(--blue);
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.15s;
            margin-right: 4px;
            margin-bottom: 4px;
        }

        .btn-evaluate {
            display: inline-block;
            padding: 5px 11px;
            border-radius: 6px;
            background: #f5f3ff;
            border: 1px solid #e9d5ff;
            color: var(--purple);
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.15s;
            margin-right: 4px;
            text-decoration: none;
            margin-bottom: 4px;
        }

        .btn-pdf {
            display: inline-block;
            padding: 5px 11px;
            border-radius: 6px;
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #e11d48;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.15s;
            margin-right: 4px;
            text-decoration: none;
        }

            .btn-pdf:hover {
                background: #e11d48;
                color: #fff;
            }

        .btn-del {
            padding: 5px 11px;
            border-radius: 6px;
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #e11d48;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.15s;
            margin-bottom: 4px;
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

        .table-custom tbody td:last-child {
            white-space: nowrap;
            min-width: 180px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
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
                <a href="GestionPlanes.aspx" class="nav-link active"><i class="fa-solid fa-clipboard-list"></i>Planes de Mejoramiento</a>
                <a href="EvaluarPlan.aspx" class="nav-link"><i class="fa-solid fa-star"></i>Evaluar Plan</a>
                <a href="Evidencias.aspx" class="nav-link"><i class="fa-solid fa-paperclip"></i>Evidencias</a>
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
                    <div class="page-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                    <div>
                        <div class="page-title">Planes de Mejoramiento</div>
                        <div class="page-sub">Gestiona los planes de mejoramiento de los aprendices</div>
                    </div>
                </div>

                <a href="MenuInstructor.aspx" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i>Volver al menú
                </a>
            </div>

            <div class="content" style="margin: 0 auto;">
                <asp:Label ID="lblMensajeOk" runat="server" CssClass="alert-ok" Visible="false" />
                <asp:Label ID="lblMensajeError" runat="server" CssClass="alert-err" Visible="false" />

                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="ch-icon"><i class="fa-solid fa-plus"></i></div>
                        <div class="ch-title">
                            <asp:Label ID="lblTituloFormulario" runat="server" Text="Nuevo Plan de Mejoramiento" />
                        </div>
                    </div>

                    <div class="card-body-custom">
                        <asp:HiddenField ID="hfIdPlan" runat="server" Value="0" />

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label-custom">Aprendiz</label>
                                <asp:DropDownList ID="ddlAprendiz" runat="server" CssClass="form-select-custom" />
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-custom">Instructor</label>
                                <asp:DropDownList ID="ddlInstructor" runat="server" CssClass="form-select-custom" />
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label-custom">Fecha Límite</label>
                                <asp:TextBox ID="txtFechaLimite" runat="server" CssClass="form-control-custom" TextMode="Date" />
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-custom">Tipo de Plan</label>
                                <asp:TextBox ID="txtTipoPlan" runat="server" CssClass="form-control-custom" Text="Interno" ReadOnly="true" />
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-12">
                                <label class="form-label-custom">Actividades</label>
                                <asp:TextBox ID="txtActividades" runat="server" CssClass="form-area-custom" TextMode="MultiLine" placeholder="Describe las actividades del plan..." />
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-12">
                                <label class="form-label-custom">Observaciones</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-area-custom" TextMode="MultiLine" placeholder="Observaciones adicionales..." />
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-12">
                                <label class="form-label-custom">Archivo PDF del Plan <span style="color: var(--muted); font-weight: 400; text-transform: none;">(opcional)</span></label>
                                <div class="file-upload-box">
                                    <div class="file-upload-icon">
                                        <i class="fa-solid fa-file-pdf"></i>
                                    </div>
                                    <div class="file-upload-info">
                                        <div class="file-upload-label">Adjuntar documento del plan</div>
                                        <div class="file-upload-hint">El aprendiz podrá descargar este archivo desde Mis Planes · Solo archivos PDF</div>
                                        <asp:FileUpload ID="fuArchivoPlan" runat="server" CssClass="file-upload-input" Accept=".pdf" />
                                    </div>
                                </div>
                                <asp:Label ID="lblArchivoActual" runat="server" Visible="false"
                                    Style="display: block; margin-top: 8px; font-size: 12px; color: var(--green);" />
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn-save" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar" CssClass="btn-cancel" OnClick="btnLimpiar_Click" />
                        </div>
                    </div>
                </div>

                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="ch-icon"><i class="fa-solid fa-table-list"></i></div>
                        <div class="ch-title">Planes Registrados</div>
                    </div>

                    <div class="table-wrapper">
                        <asp:GridView ID="gvPlanes" runat="server"
                            AutoGenerateColumns="false"
                            OnRowCommand="gvPlanes_RowCommand"
                            OnPageIndexChanging="gvPlanes_PageIndexChanging"
                            AllowPaging="true"
                            PageSize="10"
                            CssClass="table-custom"
                            GridLines="None">

                            <EmptyDataTemplate>
                                <div class="empty-state">
                                    <i class="fa-solid fa-clipboard-list"></i>
                                    <p>No hay planes registrados.</p>
                                </div>
                            </EmptyDataTemplate>

                            <Columns>
                                <asp:BoundField DataField="NombreAprendiz" HeaderText="Aprendiz" />
                                <asp:BoundField DataField="NombreInstructor" HeaderText="Instructor" />
                                <asp:BoundField DataField="TipoPlan" HeaderText="Tipo" />
                                <asp:BoundField DataField="FechaAsignacion" HeaderText="Asignación" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="FechaLimite" HeaderText="Límite" DataFormatString="{0:dd/MM/yyyy}" />

                                <asp:TemplateField HeaderText="Estado">
                                    <ItemTemplate>
                                        <span class='<%# GetBadgeClass(Eval("Estado").ToString()) %>'>
                                            <%# Eval("Estado") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>
                                        <asp:Button CommandName="Editar" CommandArgument='<%# Eval("IdPlan") %>'
                                            Text="Editar" CssClass="btn-edit" runat="server" />

                                        <a href='<%# "EvaluarPlan.aspx?id=" + Eval("IdPlan") %>' class="btn-evaluate">Evaluar</a>

                                        <%-- Botón PDF solo si tiene archivo adjunto --%>
                                        <asp:HyperLink ID="hlPdf" runat="server"
                                            NavigateUrl='<%# "~/Planes/" + Eval("ArchivoPlan") %>'
                                            Target="_blank"
                                            CssClass="btn-pdf"
                                            Visible='<%# !string.IsNullOrEmpty(Eval("ArchivoPlan") != null ? Eval("ArchivoPlan").ToString() : "") %>'>
                                            <i class="fa-solid fa-file-pdf"></i> PDF
                                        </asp:HyperLink>

                                        <asp:Button CommandName="Eliminar" CommandArgument='<%# Eval("IdPlan") %>'
                                            Text="Eliminar" CssClass="btn-del" runat="server"
                                            OnClientClick="return confirm('¿Seguro que deseas eliminar este plan?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
