<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiPlan.aspx.cs" Inherits="SistemaPlanMejoramiento.MiPlan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mis Planes - SENA</title>

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

        .page-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--text);
        }

        .page-sub {
            font-size: 12px;
            color: var(--muted);
        }

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

        .tabla-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .grid-custom {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            color: var(--text);
            border: none !important;
        }

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

        .grid-row td {
            padding: 14px 20px;
            border-bottom: 1px solid #f1f5f9;
            color: var(--text);
            font-weight: 500;
        }

        .grid-row-alt td {
            padding: 14px 20px;
            border-bottom: 1px solid #f1f5f9;
            background: #fafafa;
            color: var(--text);
            font-weight: 500;
        }

        .grid-row:hover td, .grid-row-alt:hover td {
            background: #f8fafc;
        }

        .grid-empty {
            padding: 32px;
            text-align: center;
            color: var(--muted);
            font-size: 13px;
            font-weight: 500;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
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

        .badge-enproceso {
            background: var(--blue-soft);
            color: var(--blue);
        }

        .acciones-container {
            display: flex;
            gap: 6px;
        }

        .btn-ver, .btn-subir, .btn-descargar {
            padding: 6px 12px;
            border-radius: 6px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-ver {
            background: var(--blue-soft);
            border: 1px solid #bfdbfe;
            color: var(--blue);
        }

            .btn-ver:hover {
                background: #dbeafe;
                transform: translateY(-1px);
            }

        .btn-subir {
            background: var(--green-soft);
            border: 1px solid #bbf7d0;
            color: var(--green);
        }

            .btn-subir:hover {
                background: #dcfce7;
                transform: translateY(-1px);
            }

        .btn-descargar {
            background: var(--purple-soft);
            border: 1px solid #e9d5ff;
            color: var(--purple);
        }

            .btn-descargar:hover {
                background: #f3e8ff;
                transform: translateY(-1px);
            }

        .fade-up {
            animation: fadeUp 0.25s ease-out;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 640px) {
            .topbar {
                padding: 14px 16px;
            }

            .contenido {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-layer-group"></i></div>
                <div>
                    <div class="page-title">Mis Planes de Mejoramiento</div>
                    <div class="page-sub">Consulta tus planes y sube evidencias</div>
                </div>
            </div>
            <a href="MenuAprendiz.aspx" class="btn-volver">
                <i class="fa-solid fa-arrow-left"></i>Volver al menú
            </a>
        </div>

        <div class="contenido fade-up">

            <asp:HiddenField ID="hfIdPlanSeleccionado" runat="server" Value="0" />

            <div class="panel-card">
                <div class="panel-header">
                    <div class="ch-icon"><i class="fa-solid fa-paste"></i></div>
                    <div>
                        <h3>Mis Planes Asignados</h3>
                    </div>
                </div>

                <div class="tabla-wrapper">
                    <asp:GridView ID="gvPlanes" runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="grid-custom"
                        OnRowCommand="gvPlanes_RowCommand"
                        OnPageIndexChanging="gvPlanes_PageIndexChanging"
                        AllowPaging="true" PageSize="10"
                        EmptyDataText="No tienes planes de mejoramiento asignados.">

                        <HeaderStyle CssClass="grid-header" />
                        <RowStyle CssClass="grid-row" />
                        <AlternatingRowStyle CssClass="grid-row-alt" />
                        <EmptyDataRowStyle CssClass="grid-empty" />

                        <Columns>
                            <asp:BoundField DataField="NombreInstructor" HeaderText="Instructor" />
                            <asp:BoundField DataField="TipoPlan" HeaderText="Tipo" />
                            <asp:BoundField DataField="FechaAsignacion" HeaderText="Asignación" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="FechaLimite" HeaderText="Límite" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Actividades" HeaderText="Actividades" />

                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# "badge badge-" + Eval("Estado").ToString().ToLower().Replace(" ", "") %>'>
                                        <i class="fa-solid fa-circle-dot" style="font-size: 8px;"></i><%# Eval("Estado") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="acciones-container">
                                        <%# Eval("ArchivoPlan") != null && Eval("ArchivoPlan").ToString() != "" ?
                "<a href='" + ResolveUrl("~/Planes/" + Eval("ArchivoPlan").ToString()) + "' class='btn-descargar' target='_blank'><i class='fa-solid fa-file-pdf'></i> Ver Plan</a>"
                : "<span style='font-size:11px;color:var(--muted)'>Sin PDF</span>" %>
                                        <asp:Button CommandName="VerEvidencias" CommandArgument='<%# Eval("IdPlan") %>'
                                            Text="📎 Ver Evidencias" CssClass="btn-ver" runat="server" />
                                        <asp:Button CommandName="SubirEvidencia" CommandArgument='<%# Eval("IdPlan") %>'
                                            Text="⬆ Subir" CssClass="btn-subir" runat="server" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <asp:Panel ID="pnlEvidencias" runat="server" Visible="false">
                <div class="panel-card">
                    <div class="panel-header" style="border-left: 4px solid var(--purple);">
                        <div class="ch-icon" style="background: var(--purple-soft); color: var(--purple);"><i class="fa-solid fa-paperclip"></i></div>
                        <div>
                            <h3>Evidencias del Plan Seleccionado</h3>
                        </div>
                    </div>

                    <div class="tabla-wrapper">
                        <asp:GridView ID="gvEvidencias" runat="server"
                            AutoGenerateColumns="false"
                            GridLines="None"
                            CssClass="grid-custom"
                            OnRowCommand="gvEvidencias_RowCommand"
                            OnPageIndexChanging="gvEvidencias_PageIndexChanging"
                            AllowPaging="true" PageSize="5"
                            EmptyDataText="No hay evidencias subidas para este plan.">

                            <HeaderStyle CssClass="grid-header" />
                            <RowStyle CssClass="grid-row" />
                            <AlternatingRowStyle CssClass="grid-row-alt" />
                            <EmptyDataRowStyle CssClass="grid-empty" />

                            <Columns>
                                <asp:BoundField DataField="NombreArchivo" HeaderText="Archivo" />
                                <asp:BoundField DataField="TipoArchivo" HeaderText="Tipo" HeaderStyle-Width="100px" />
                                <asp:BoundField DataField="FechaSubida" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-Width="120px" />
                                <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />

                                <asp:TemplateField HeaderText="Descargar" HeaderStyle-Width="130px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDescargar" runat="server"
                                            CommandName="Descargar"
                                            CommandArgument='<%# Eval("NombreArchivo") %>'
                                            CssClass="btn-descargar">
                                            <i class="fa-solid fa-cloud-arrow-down"></i>Descargar
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </form>
</body>
</html>