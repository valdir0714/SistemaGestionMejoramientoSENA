<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Evidencias.aspx.cs" Inherits="SistemaPlanMejoramiento.Evidencias" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Evidencias - SENA</title>

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
            color: #fff; font-weight: 800; font-size: 16px;
        }

        .brand-text { font-size: 15px; font-weight: 700; color: var(--text); }
        .brand-sub  { font-size: 11px; color: var(--muted); }

        .sidebar-nav {
            flex: 1;
            padding: 16px 0;
            overflow-y: auto;
        }

        .nav-section {
            padding: 6px 16px 4px;
            font-size: 10px; font-weight: 700;
            color: var(--muted);
            letter-spacing: 1.2px;
            text-transform: uppercase;
            margin-top: 8px;
        }

        .nav-link {
            display: flex; align-items: center; gap: 10px;
            padding: 9px 16px;
            color: var(--muted);
            text-decoration: none;
            font-size: 13px; font-weight: 500;
            border-radius: 8px;
            margin: 1px 8px;
            transition: all 0.18s;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--green-soft);
            color: var(--green);
            font-weight: 600;
        }

        .nav-link i { width: 18px; text-align: center; font-size: 14px; }

        .sidebar-footer {
            padding: 16px;
            border-top: 1px solid var(--border);
        }

        .user-row { display: flex; align-items: center; gap: 10px; }

        .user-avatar {
            width: 34px; height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), #1976d2);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 700; font-size: 13px;
        }

        .user-name { font-size: 13px; font-weight: 600; color: var(--text); }
        .user-role { font-size: 11px; color: var(--muted); }

        /* ── Main ── */
        .main { margin-left: var(--sidebar-w); min-height: 100vh; }

        .topbar {
            background: #fff;
            border-bottom: 1px solid var(--border);
            padding: 14px 28px;
            display: flex; align-items: center; justify-content: space-between;
            position: sticky; top: 0; z-index: 50;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .topbar-left { display: flex; align-items: center; gap: 12px; }

        .page-icon {
            width: 38px; height: 38px;
            border-radius: 10px;
            background: var(--green-soft);
            display: flex; align-items: center; justify-content: center;
            color: var(--green); font-size: 16px;
        }

        .page-title { font-size: 16px; font-weight: 700; color: var(--text); }
        .page-sub   { font-size: 12px; color: var(--muted); }

        .btn-back {
            display: flex; align-items: center; gap: 6px;
            padding: 7px 14px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--muted);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px; font-weight: 500;
            text-decoration: none;
            transition: all 0.18s;
        }

        .btn-back:hover { border-color: var(--green); color: var(--green); }

        .content { padding: 24px 28px; }

        /* ── Alerts ── */
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

        /* ── Cards ── */
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
            display: flex; align-items: center; gap: 8px;
        }

        .ch-icon {
            width: 28px; height: 28px;
            border-radius: 8px;
            background: var(--green-soft);
            display: flex; align-items: center; justify-content: center;
            color: var(--green); font-size: 13px;
        }

        .ch-title { font-size: 14px; font-weight: 700; color: var(--text); }

        .card-body-custom { padding: 20px 22px; }

        /* ── Form ── */
        .form-label-custom {
            font-size: 11px; font-weight: 700;
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

        /* File upload personalizado */
        .file-upload-wrapper {
            position: relative;
        }

        .file-upload-label {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 9px 13px;
            background: #f8fafc;
            border: 1px dashed var(--border);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.18s;
            font-size: 13px;
            color: var(--muted);
        }

        .file-upload-label:hover {
            border-color: var(--green);
            color: var(--green);
            background: var(--green-soft);
        }

        .file-upload-label i { font-size: 15px; }

        .file-name-display {
            font-size: 12px;
            color: var(--muted);
            margin-top: 5px;
            min-height: 16px;
        }

        /* Ocultar el input file nativo pero mantenerlo funcional */
        .file-input-hidden {
            position: absolute;
            width: 100%; height: 100%;
            top: 0; left: 0;
            opacity: 0;
            cursor: pointer;
        }

        .btn-save {
            padding: 9px 22px;
            background: linear-gradient(135deg, var(--green), var(--green-light));
            border: none;
            border-radius: 8px;
            color: #fff;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px; font-weight: 600;
            cursor: pointer;
            transition: all 0.18s;
            display: inline-flex; align-items: center; gap: 6px;
        }

        .btn-save:hover { opacity: 0.92; transform: translateY(-1px); }

        .btn-cancel {
            padding: 9px 20px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--muted);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px; font-weight: 500;
            cursor: pointer;
            transition: all 0.18s;
        }

        .btn-cancel:hover { border-color: #94a3b8; color: var(--text); }

        /* ── Table ── */
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
            font-size: 11px; font-weight: 700;
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

        /* Badges tipo archivo */
        .badge-tipo {
            display: inline-flex; align-items: center; gap: 4px;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px; font-weight: 600;
        }

        .badge-pdf  { background: #fff1f2; color: #e11d48; }
        .badge-img  { background: #eff6ff; color: #1d4ed8; }
        .badge-doc  { background: #eff6ff; color: #1565c0; }
        .badge-otro { background: #f1f5f9; color: #64748b; }

        .btn-download {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 5px 11px;
            border-radius: 6px;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            color: #1d4ed8;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 11px; font-weight: 600;
            text-decoration: none;
            transition: all 0.15s;
        }

        .btn-download:hover {
            background: #dbeafe;
            color: #1d4ed8;
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

        .filename-cell {
            max-width: 180px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
            <a href="Evidencias.aspx" class="nav-link active"><i class="fa-solid fa-paperclip"></i> Evidencias</a>
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
                <div class="page-icon"><i class="fa-solid fa-paperclip"></i></div>
                <div>
                    <div class="page-title">Evidencias</div>
                    <div class="page-sub">Sube y consulta evidencias de los planes de mejoramiento</div>
                </div>
            </div>
            <a href="MenuInstructor.aspx" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Volver al menú
            </a>
        </div>

        <div class="content">

            <asp:Label ID="lblMensajeOk"    runat="server" CssClass="alert-ok"  Visible="false" />
            <asp:Label ID="lblMensajeError" runat="server" CssClass="alert-err" Visible="false" />

            <div class="card-custom">
                <div class="card-header-custom">
                    <div class="ch-icon"><i class="fa-solid fa-upload"></i></div>
                    <div class="ch-title">Subir Evidencia</div>
                </div>

                <div class="card-body-custom">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label-custom">Plan de Mejoramiento *</label>
                            <asp:DropDownList ID="ddlPlan" runat="server" CssClass="form-select-custom" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label-custom">Archivo *</label>
                            <div class="file-upload-wrapper">
                                <div class="file-upload-label" id="fileLabel">
                                    <i class="fa-solid fa-cloud-arrow-up"></i>
                                    <span id="fileLabelText">Haz clic para seleccionar un archivo</span>
                                </div>
                                <asp:FileUpload ID="fuEvidencia" runat="server" CssClass="file-input-hidden"
                                    onchange="actualizarNombreArchivo(this)" />
                            </div>
                            <div class="file-name-display" id="fileNameDisplay"></div>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-12">
                            <label class="form-label-custom">Observaciones</label>
                            <asp:TextBox ID="txtObservaciones" runat="server"
                                CssClass="form-control-custom"
                                placeholder="Observaciones sobre la evidencia..." />
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <asp:Button ID="btnSubir" runat="server"
                            Text="Subir Evidencia"
                            CssClass="btn-save"
                            OnClick="btnSubir_Click" />
                        <asp:Button ID="btnLimpiar" runat="server"
                            Text="Cancelar"
                            CssClass="btn-cancel"
                            OnClick="btnLimpiar_Click" />
                    </div>
                </div>
            </div>

            <div class="card-custom">
                <div class="card-header-custom">
                    <div class="ch-icon"><i class="fa-solid fa-table-list"></i></div>
                    <div class="ch-title">Evidencias Registradas</div>
                </div>

                <div class="table-wrapper">
                    <asp:GridView ID="gvEvidencias" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table-custom"
                        GridLines="None"
                        OnRowCommand="gvEvidencias_RowCommand">

                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fa-solid fa-paperclip"></i>
                                <p>No hay evidencias registradas.</p>
                            </div>
                        </EmptyDataTemplate>

                        <Columns>
                            <asp:BoundField DataField="NombreAprendiz" HeaderText="Aprendiz" />
                            <asp:BoundField DataField="TipoPlan"       HeaderText="Tipo Plan" />

                            <asp:TemplateField HeaderText="Archivo">
                                <ItemTemplate>
                                    <span class="filename-cell" title='<%# Eval("NombreArchivo") %>'>
                                        <%# Eval("NombreArchivo") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tipo">
                                <ItemTemplate>
                                    <span class='<%# GetBadgeTipo(Eval("TipoArchivo").ToString()) %>'>
                                        <%# Eval("TipoArchivo") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="FechaSubida"    HeaderText="Fecha"   DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Observaciones"  HeaderText="Observaciones" />

                            <asp:TemplateField HeaderText="Descargar">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDescargar" runat="server"
                                        CommandName="Descargar"
                                        CommandArgument='<%# Eval("NombreArchivo") %>'
                                        CssClass="btn-download">
                                        <i class="fa-solid fa-download"></i> Ver
                                    </asp:LinkButton>
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
<script>
    function actualizarNombreArchivo(input) {
        var display = document.getElementById('fileNameDisplay');
        var label = document.getElementById('fileLabelText');
        if (input.files && input.files.length > 0) {
            var nombre = input.files[0].name;
            label.textContent = nombre;
            display.textContent = 'Archivo seleccionado: ' + nombre;
            display.style.color = '#2e7d32';
        } else {
            label.textContent = 'Haz clic para seleccionar un archivo';
            display.textContent = '';
        }
    }
</script>
</body>
</html>