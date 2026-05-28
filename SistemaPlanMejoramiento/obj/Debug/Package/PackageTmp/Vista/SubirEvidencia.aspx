<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubirEvidencia.aspx.cs" Inherits="SistemaPlanMejoramiento.SubirEvidencia" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Subir Evidencia - SENA</title>
    
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
            --red: #c62828;
            --red-soft: #ffebee;
            --purple: #6d28d9;
            --purple-soft: #f3e8ff;
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
            line-height: 1.5;
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

        .btn-volver { 
            padding: 9px 16px; 
            background: #fff; 
            border: 1px solid var(--border); 
            border-radius: 8px; 
            color: var(--text); 
            font-size: 13px; 
            font-weight: 600;
            text-decoration: none; 
            transition: all 0.18s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-volver:hover { 
            border-color: var(--green);
            background: var(--green-soft);
            color: var(--green);
            transform: translateX(-2px);
        }

        .contenido { 
            padding: 28px; 
            max-width: 1000px;
            margin: 0 auto;
        }

        .mensaje-ok {
            background: var(--green-soft);
            border: 1px solid #bbf7d0;
            border-radius: 10px;
            padding: 14px 18px;
            color: var(--green);
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            display: block;
        }

        .mensaje-error {
            background: var(--red-soft);
            border: 1px solid #fca5a5;
            border-radius: 10px;
            padding: 14px 18px;
            color: var(--red);
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            display: block;
        }

        .panel-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            width: 100%;
            overflow: hidden;
            margin-bottom: 28px;
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

        .panel-body {
            padding: 24px 20px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .info-item label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .info-item span {
            font-size: 14px;
            color: var(--text);
            font-weight: 600;
        }

        .actividades-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 16px;
            font-size: 13px;
            color: #334155;
            line-height: 1.6;
        }

        .zona-subida {
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            padding: 36px 20px;
            text-align: center;
            margin-bottom: 20px;
            background: #fafafa;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .zona-subida:hover {
            border-color: var(--green);
            background: var(--green-soft);
        }

        .zona-icono {
            font-size: 36px;
            color: var(--muted);
            margin-bottom: 12px;
            transition: color 0.2s;
        }
        .zona-subida:hover .zona-icono {
            color: var(--green);
        }

        .zona-texto {
            font-size: 14px;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 6px;
        }

        .zona-formatos {
            font-size: 12px;
            color: var(--muted);
        }

        .campo-archivo { display: none; }

        .grupo { margin-bottom: 20px; }
        .grupo label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .campo-area {
            width: 100%;
            padding: 12px 16px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13.5px;
            outline: none;
            resize: vertical;
            min-height: 90px;
            transition: border 0.15s;
        }
        .campo-area:focus {
            border-color: var(--green);
            box-shadow: 0 0 0 3px rgba(46,125,50,0.1);
        }

        .btn-guardar {
            padding: 11px 24px;
            background: var(--green);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.15s;
        }
        .btn-guardar:hover { background: var(--green-light); }

        .tabla-wrapper { width: 100%; overflow-x: auto; }
        .grid-custom { width: 100%; border-collapse: collapse; font-size: 13px; color: var(--text); border: none !important; }
        .grid-header th {
            background: #f8fafc;
            color: var(--muted);
            padding: 14px 20px;
            text-align: left;
            font-weight: 700;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid var(--border);
        }
        .grid-row td { padding: 14px 20px; border-bottom: 1px solid #f1f5f9; font-weight: 500; }
        .grid-row-alt td { padding: 14px 20px; border-bottom: 1px solid #f1f5f9; background: #fafafa; font-weight: 500; }
        .grid-row:hover td, .grid-row-alt:hover td { background: #f8fafc; }
        .grid-empty { padding: 32px; text-align: center; color: var(--muted); font-size: 13px; font-weight: 500; }

        .badge-tipo {
            display: inline-flex;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            background: var(--blue-soft);
            color: var(--blue);
            text-transform: uppercase;
        }

        .btn-descargar {
            padding: 6px 12px;
            background: var(--purple-soft);
            border: 1px solid #e9d5ff;
            border-radius: 6px;
            color: var(--purple);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.15s;
        }
        .btn-descargar:hover { background: #f3e8ff; transform: translateY(-1px); }

        .fade-up { animation: fadeUp 0.25s ease-out; }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
                <div>
                    <div class="page-title">Subir Evidencia</div>
                    <div class="page-sub">Adjunta los archivos soportados de tu plan de mejoramiento</div>
                </div>
            </div>
            <a href="MiPlan.aspx" class="btn-volver">
                <i class="fa-solid fa-arrow-left"></i> Volver a mis planes
            </a>
        </div>

        <div class="contenido fade-up">

            <asp:Label ID="lblMensajeOk" runat="server" CssClass="mensaje-ok" Visible="false" />
            <asp:Label ID="lblMensajeError" runat="server" CssClass="mensaje-error" Visible="false" />

            <asp:HiddenField ID="hfIdPlan" runat="server" Value="0" />

            <div class="panel-card">
                <div class="panel-header">
                    <div class="ch-icon"><i class="fa-solid fa-circle-info"></i></div>
                    <h3>Información del Plan</h3>
                </div>
                <div class="panel-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Tipo de Plan</label>
                            <span><asp:Label ID="lblTipoPlan" runat="server" /></span>
                        </div>
                        <div class="info-item">
                            <label>Fecha Límite</label>
                            <span><asp:Label ID="lblFechaLimite" runat="server" /></span>
                        </div>
                        <div class="info-item">
                            <label>Estado del Plan</label>
                            <span><asp:Label ID="lblEstado" runat="server" /></span>
                        </div>
                    </div>
                    <div class="grupo" style="margin-bottom: 0;">
                        <label>Actividades a Desarrollar</label>
                        <div class="actividades-box">
                            <asp:Label ID="lblActividades" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel-card">
                <div class="panel-header" style="border-left: 4px solid var(--green);">
                    <div class="ch-icon"><i class="fa-solid fa-file-arrow-up"></i></div>
                    <h3>Subir Nueva Evidencia</h3>
                </div>
                <div class="panel-body">
                    
                    <div class="zona-subida" id="dropZone" onclick="document.getElementById('<%= fuArchivo.ClientID %>').click();">
                        <div class="zona-icono" id="uploadIcon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
                        <div class="zona-texto" id="uploadText">Haz clic para seleccionar un archivo</div>
                        <div class="zona-formatos">Formatos permitidos: PDF, DOCX, JPG, PNG, ZIP — Máximo 10 MB</div>
                    </div>

                    <asp:FileUpload ID="fuArchivo" runat="server" CssClass="campo-archivo" onchange="mostrarNombreArchivo(this);" />

                    <div class="grupo">
                        <label>Observaciones del Aprendiz</label>
                        <asp:TextBox ID="txtObservaciones" runat="server" CssClass="campo-area" TextMode="MultiLine" placeholder="Escribe un comentario o descripción breve sobre la evidencia que estás adjuntando..." />
                    </div>

                    <div class="botones">
                        <button type="submit" id="btnSubir" runat="server" class="btn-guardar" onserverclick="btnSubir_Click">
                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Subir Evidencia
                        </button>
                    </div>
                </div>
            </div>

            <div class="panel-card">
                <div class="panel-header" style="border-left: 4px solid var(--purple);">
                    <div class="ch-icon" style="background: var(--purple-soft); color: var(--purple);"><i class="fa-solid fa-paperclip"></i></div>
                    <h3>Evidencias Subidas Corrientemente</h3>
                </div>
                
                <div class="tabla-wrapper">
                    <asp:GridView ID="gvEvidencias" runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="grid-custom"
                        OnPageIndexChanging="gvEvidencias_PageIndexChanging"
                        AllowPaging="true" PageSize="5"
                        EmptyDataText="Aún no has subido evidencias para este plan de mejoramiento.">
                        
                        <HeaderStyle CssClass="grid-header" />
                        <RowStyle CssClass="grid-row" />
                        <AlternatingRowStyle CssClass="grid-row-alt" />
                        <EmptyDataRowStyle CssClass="grid-empty" />

                        <Columns>
                            <asp:BoundField DataField="NombreArchivo" HeaderText="Archivo" />
                            
                            <asp:TemplateField HeaderText="Tipo" HeaderStyle-Width="100px">
                                <ItemTemplate>
                                    <span class="badge-tipo"><%# Eval("TipoArchivo") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="FechaSubida" HeaderText="Fecha y Hora" DataFormatString="{0:dd/MM/yyyy HH:mm}" HeaderStyle-Width="150px" />
                            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                            
                            <asp:TemplateField HeaderText="Descargar" HeaderStyle-Width="130px">
                                <ItemTemplate>
                                    <a href='<%# ResolveUrl(Eval("RutaArchivo").ToString()) %>' class="btn-descargar" target="_blank">
                                        <i class="fa-solid fa-download"></i> Descargar
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </form>

    <script type="text/javascript">
        function mostrarNombreArchivo(input) {
            var box = document.getElementById('dropZone');
            var texto = document.getElementById('uploadText');
            var icono = document.getElementById('uploadIcon');
            
            if (input.files && input.files.length > 0) {
                var nombre = input.files[0].name;
                texto.innerText = "Archivo seleccionado: " + nombre;
                texto.style.color = "#2e7d32";
                box.style.borderColor = "#2e7d32";
                box.style.background = "#e8f5e9";
                icono.innerHTML = '<i class="fa-solid fa-file-circle-check" style="color: #2e7d32;"></i>';
            }
        }
    </script>
</body>
</html>