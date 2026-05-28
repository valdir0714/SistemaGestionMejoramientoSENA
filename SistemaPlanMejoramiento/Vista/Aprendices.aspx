<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Aprendices.aspx.cs" Inherits="SistemaPlanMejoramiento.Aprendices" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Aprendices - SENA</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        :root {
            --green: #2e7d32;
            --green-light: #43a047;
            --green-soft: #e8f5e9;
            --sidebar-w: 240px;
            --bg: #f0f2f5;
            --card: #ffffff;
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
            color: white;
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
            margin-bottom: 12px;
        }

        .user-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1565c0, #1976d2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
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

        .btn-logout:hover {
            background: #ffe4e6;
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
        }
.tab-pills {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 18px;
}

.tab-pill {
    min-width: 150px;
    padding: 9px 18px;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: #fff;
    color: var(--muted);
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.18s;
    box-shadow: 0 1px 4px rgba(0,0,0,0.04);
}

.tab-pill:hover {
    border-color: var(--green);
    color: var(--green);
    background: var(--green-soft);
}

.tab-pill.activo {
    background: linear-gradient(135deg, var(--green), var(--green-light));
    border-color: var(--green);
    color: #fff;
    box-shadow: 0 4px 12px rgba(46,125,50,0.22);
}

        .card-custom {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            margin-bottom: 22px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
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

        .card-body-custom {
            padding: 20px 22px;
        }

        .form-label-custom {
            font-size: 11px;
            font-weight: 700;
            color: var(--muted);
            letter-spacing: 0.6px;
            text-transform: uppercase;
            margin-bottom: 5px;
            display: block;
        }

        .form-control-custom,
        .form-select-custom {
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

        .form-control-custom:focus,
        .form-select-custom:focus {
            border-color: var(--green);
            box-shadow: 0 0 0 3px rgba(46,125,50,0.1);
            background: #fff;
        }

        .btn-save {
            padding: 9px 22px;
            background: linear-gradient(135deg, var(--green), var(--green-light));
            border: none;
            border-radius: 8px;
            color: white;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-save:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .btn-cancel {
            padding: 9px 20px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--muted);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-cancel:hover {
            border-color: #94a3b8;
            color: var(--text);
        }

        .btn-excel {
            padding: 9px 22px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 8px;
            color: #166534;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-excel:hover {
            background: #dcfce7;
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

        .excel-info {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 10px;
            padding: 14px 18px;
            font-size: 13px;
            color: #1d4ed8;
            line-height: 1.8;
            margin-bottom: 16px;
        }

        .excel-drop {
            border: 2px dashed #d1d5db;
            border-radius: 12px;
            padding: 24px;
            background: #fafafa;
            margin-bottom: 16px;
        }

        .errores-box {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            border-radius: 10px;
            padding: 14px 18px;
        }

        .errores-box p {
            color: #9f1239;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .errores-box li {
            color: #e11d48;
            font-size: 12px;
            padding: 2px 0;
        }

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

        .table-custom tbody tr:hover {
            background: #f8fafc;
        }

        .table-custom tbody td {
            padding: 11px 14px;
            color: var(--text);
            vertical-align: middle;
        }

        .badge-sena {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .badge-formacion {
            background: #dcfce7;
            color: #166534;
        }

        .badge-cancelado {
            background: #fff1f2;
            color: #e11d48;
        }

        .badge-aplazado {
            background: #fef3c7;
            color: #92400e;
        }

        .badge-condicionado {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .badge-otro {
            background: #f1f5f9;
            color: #64748b;
        }

        .btn-edit {
            padding: 5px 11px;
            border-radius: 6px;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            color: #1d4ed8;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
            transition: all 0.15s;
            margin-right: 4px;
        }

        .btn-edit:hover {
            background: #dbeafe;
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
        }

        .btn-del:hover {
            background: #ffe4e6;
        }

        .table-wrapper {
            overflow-x: auto;
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
            <div class="nav-section">Académico</div>
            <a href="Programas.aspx" class="nav-link"><i class="fa-solid fa-book-open"></i> Programas</a>
            <a href="Fichas.aspx" class="nav-link"><i class="fa-solid fa-folder-open"></i> Fichas</a>

            <div class="nav-section">Personas</div>
            <a href="Instructores.aspx" class="nav-link"><i class="fa-solid fa-chalkboard-user"></i> Instructores</a>
            <a href="Aprendices.aspx" class="nav-link active"><i class="fa-solid fa-user-graduate"></i> Aprendices</a>

            <div class="nav-section">Asignaciones</div>
            <a href="AsignarInstructor.aspx" class="nav-link"><i class="fa-solid fa-link"></i> Asignar Instructor</a>
        </nav>

        <div class="sidebar-footer">
            <div class="user-row">
                <div class="user-avatar">A</div>
                <div>
                    <div class="user-name">admin.ceet</div>
                    <div class="user-role">Administrador</div>
                </div>
            </div>

            <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión" CssClass="btn-logout" OnClick="btnSalir_Click" />
        </div>
    </div>

    <div class="main">
        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-user-graduate"></i></div>
                <div>
                    <div class="page-title">Gestión de Aprendices</div>
                    <div class="page-sub">Registra, consulta, modifica y gestiona aprendices del centro</div>
                </div>
            </div>

            <a href="MenuAdmin.aspx" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Volver al menú
            </a>
        </div>

        <div class="content">

            <asp:Label ID="lblMensajeOk" runat="server" CssClass="alert-ok" Visible="false" />
            <asp:Label ID="lblMensajeError" runat="server" CssClass="alert-err" Visible="false" />

            <div class="tab-pills">
                <asp:Button ID="btnTabManual" runat="server" Text="Registro Manual" CssClass="tab-pill activo" OnClick="btnTabManual_Click" />
                <asp:Button ID="btnTabExcel" runat="server" Text="Carga por Excel" CssClass="tab-pill" OnClick="btnTabExcel_Click" />
            </div>

            <asp:Panel ID="pnlManual" runat="server">
                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="ch-icon"><i class="fa-solid fa-user-plus"></i></div>
                        <div class="ch-title">
                            <asp:Label ID="lblTituloFormulario" runat="server" Text="Nuevo Aprendiz" />
                        </div>
                    </div>

                    <div class="card-body-custom">
                        <asp:HiddenField ID="hfIdAprendiz" runat="server" Value="0" />

                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label class="form-label-custom">Tipo de Documento</label>
                                <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="form-select-custom">
                                    <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                    <asp:ListItem Value="CC">Cédula de Ciudadanía</asp:ListItem>
                                    <asp:ListItem Value="TI">Tarjeta de Identidad</asp:ListItem>
                                    <asp:ListItem Value="CE">Cédula Extranjería</asp:ListItem>
                                    <asp:ListItem Value="PA">Pasaporte</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom">Número de Documento</label>
                                <asp:TextBox ID="txtNumeroDoc" runat="server" CssClass="form-control-custom" placeholder="Número de documento" />
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom">Ficha</label>
                                <asp:DropDownList ID="ddlFicha" runat="server" CssClass="form-select-custom" />
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label class="form-label-custom">Nombres</label>
                                <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control-custom" placeholder="Nombres completos" />
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom">Apellidos</label>
                                <asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control-custom" placeholder="Apellidos completos" />
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control-custom" placeholder="Número de teléfono" />
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label-custom">Correo Electrónico</label>
                                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control-custom" placeholder="correo@ejemplo.com" />
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-custom">Estado</label>
                                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select-custom">
                                    <asp:ListItem Value="En Formación">En Formación</asp:ListItem>
                                    <asp:ListItem Value="Aplazado">Aplazado</asp:ListItem>
                                    <asp:ListItem Value="Desertado">Desertado</asp:ListItem>
                                    <asp:ListItem Value="Retiro voluntario">Retiro voluntario</asp:ListItem>
                                    <asp:ListItem Value="Condicionado">Condicionado</asp:ListItem>
                                    <asp:ListItem Value="Cancelado">Cancelado</asp:ListItem>
                                    <asp:ListItem Value="Certificado">Certificado</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn-save" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar" CssClass="btn-cancel" OnClick="btnLimpiar_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlExcel" runat="server" Visible="false">
                <div class="card-custom">
                    <div class="card-header-custom">
                        <div class="ch-icon"><i class="fa-solid fa-file-excel"></i></div>
                        <div class="ch-title">Carga Masiva por Excel</div>
                    </div>

                    <div class="card-body-custom">
                        <div class="excel-info">
                            <strong>Formato requerido:</strong><br />
                            <strong>A:</strong> TipoDocumento |
                            <strong>B:</strong> NumeroDocumento |
                            <strong>C:</strong> Nombres |
                            <strong>D:</strong> Apellidos |
                            <strong>E:</strong> Correo |
                            <strong>F:</strong> Telefono |
                            <strong>G:</strong> CodigoFicha<br />
                            La primera fila debe ser el encabezado. Tipos válidos: CC, TI, CE, PA.
                        </div>

                        <div class="excel-drop">
                            <label class="form-label-custom">Seleccionar archivo Excel (.xlsx)</label>
                            <asp:FileUpload ID="fuExcel" runat="server" CssClass="form-control-custom" accept=".xlsx" />
                        </div>

                        <asp:Button ID="btnCargarExcel" runat="server" Text="Procesar Excel" CssClass="btn-excel" OnClick="btnCargarExcel_Click" />

                        <asp:Panel ID="pnlErroresExcel" runat="server" Visible="false">
                            <div class="errores-box mt-3">
                                <p><i class="fa-solid fa-triangle-exclamation"></i> Errores encontrados:</p>
                                <asp:BulletedList ID="blErrores" runat="server" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>

            <div class="card-custom">
                <div class="card-header-custom">
                    <div class="ch-icon"><i class="fa-solid fa-table-list"></i></div>
                    <div class="ch-title">Aprendices Registrados</div>
                </div>

                <div class="table-wrapper">
                    <asp:GridView ID="gvAprendices" runat="server"
                        AutoGenerateColumns="false"
                        OnRowCommand="gvAprendices_RowCommand"
                        OnPageIndexChanging="gvAprendices_PageIndexChanging"
                        AllowPaging="true"
                        PageSize="10"
                        CssClass="table-custom"
                        GridLines="None">

                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fa-solid fa-user-graduate"></i>
                                <p>No hay aprendices registrados.</p>
                            </div>
                        </EmptyDataTemplate>

                        <Columns>
                            <asp:BoundField DataField="TipoDocumento" HeaderText="Tipo Doc" />
                            <asp:BoundField DataField="NumeroDocumento" HeaderText="Documento" />
                            <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre Completo" />
                            <asp:BoundField DataField="Correo" HeaderText="Correo" />
                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />

                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# GetBadgeClass(Eval("Estado").ToString()) %>'>
                                        <%# Eval("Estado") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:Button CommandName="Editar"
                                        CommandArgument='<%# Eval("IdAprendiz") %>'
                                        Text="Editar"
                                        CssClass="btn-edit"
                                        runat="server" />

                                    <asp:Button CommandName="Eliminar"
                                        CommandArgument='<%# Eval("IdAprendiz") %>'
                                        Text="Eliminar"
                                        CssClass="btn-del"
                                        runat="server"
                                        OnClientClick="return confirm('¿Seguro que deseas eliminar este aprendiz?');" />
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