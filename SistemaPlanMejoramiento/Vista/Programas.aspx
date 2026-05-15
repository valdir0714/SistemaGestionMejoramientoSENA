<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Programas.aspx.cs" Inherits="SistemaPlanMejoramiento.Programas" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Programas - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: #0f172a; min-height: 100vh; color: #f9fafb; }

        .topbar {
            background: #111827;
            border-bottom: 1px solid #1f2937;
            padding: 16px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .topbar h1 { font-size: 20px; font-weight: 700; color: #f9fafb; }
        .topbar p { font-size: 13px; color: #6b7280; }
        .btn-volver {
            padding: 8px 16px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 8px;
            color: #9ca3af;
            font-family: 'Outfit', sans-serif;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-volver:hover { background: #374151; color: #f9fafb; }

        .contenido { padding: 32px; }

        /* Formulario */
        .panel {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 28px;
        }
        .panel-titulo {
            font-size: 16px;
            font-weight: 600;
            color: #f9fafb;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #1f2937;
        }
        .fila { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; margin-bottom: 16px; }
        .fila-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; }
        .grupo label {
            display: block;
            font-size: 12px;
            font-weight: 500;
            color: #9ca3af;
            margin-bottom: 6px;
            letter-spacing: 0.5px;
        }
        .campo {
            width: 100%;
            padding: 11px 14px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 10px;
            color: #f9fafb;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            outline: none;
            transition: all 0.2s;
        }
        .campo:focus { border-color: #39a900; box-shadow: 0 0 0 3px rgba(57,169,0,0.1); }
        .campo option { background: #1f2937; }

        .botones { display: flex; gap: 10px; margin-top: 8px; }
        .btn-guardar {
            padding: 11px 24px;
            background: linear-gradient(135deg, #39a900, #2d8200);
            border: none;
            border-radius: 10px;
            color: white;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-guardar:hover { background: linear-gradient(135deg, #44c200, #39a900); }
        .btn-limpiar {
            padding: 11px 24px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 10px;
            color: #9ca3af;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-limpiar:hover { background: #374151; color: #f9fafb; }

        .mensaje-ok {
            background: rgba(57,169,0,0.1);
            border: 1px solid rgba(57,169,0,0.3);
            border-radius: 10px;
            padding: 12px 16px;
            color: #86efac;
            font-size: 13px;
            margin-bottom: 16px;
        }
        .mensaje-error {
            background: rgba(220,38,38,0.1);
            border: 1px solid rgba(220,38,38,0.3);
            border-radius: 10px;
            padding: 12px 16px;
            color: #fca5a5;
            font-size: 13px;
            margin-bottom: 16px;
        }

        /* Tabla */
        .buscador-wrapper { margin-bottom: 16px; }
        .buscador-wrapper input {
            width: 300px;
            padding: 10px 14px;
            background: #1f2937;
            border: 1px solid #374151;
            border-radius: 10px;
            color: #f9fafb;
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            outline: none;
        }
        .buscador-wrapper input:focus { border-color: #39a900; }

        .tabla-wrapper { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; font-size: 13px; }
        thead th {
            background: #1f2937;
            color: #9ca3af;
            padding: 12px 16px;
            text-align: left;
            font-weight: 600;
            font-size: 11px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        tbody tr { border-bottom: 1px solid #1f2937; transition: background 0.2s; }
        tbody tr:hover { background: #1a2535; }
        tbody td { padding: 13px 16px; color: #d1d5db; }

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-activo { background: rgba(57,169,0,0.15); color: #86efac; }
        .badge-inactivo { background: rgba(107,114,128,0.15); color: #9ca3af; }

        .btn-editar {
            padding: 5px 12px;
            background: rgba(59,130,246,0.1);
            border: 1px solid rgba(59,130,246,0.2);
            border-radius: 6px;
            color: #93c5fd;
            font-family: 'Outfit', sans-serif;
            font-size: 12px;
            cursor: pointer;
            margin-right: 4px;
            transition: all 0.2s;
        }
        .btn-editar:hover { background: rgba(59,130,246,0.2); }
        .btn-eliminar {
            padding: 5px 12px;
            background: rgba(220,38,38,0.1);
            border: 1px solid rgba(220,38,38,0.2);
            border-radius: 6px;
            color: #fca5a5;
            font-family: 'Outfit', sans-serif;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-eliminar:hover { background: rgba(220,38,38,0.2); }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div>
                <h1>📚 Gestión de Programas</h1>
                <p>Registra, consulta, modifica y elimina programas de formación</p>
            </div>
            <a href="MenuAdmin.aspx" class="btn-volver">← Volver al menú</a>
        </div>

        <div class="contenido">

            <!-- Mensajes -->
            <asp:Label ID="lblMensajeOk" runat="server" CssClass="mensaje-ok" Visible="false"/>
            <asp:Label ID="lblMensajeError" runat="server" CssClass="mensaje-error" Visible="false"/>

            <!-- Formulario -->
            <div class="panel">
                <div class="panel-titulo">
                    <asp:Label ID="lblTituloFormulario" runat="server" Text="Nuevo Programa"/>
                </div>

                <asp:HiddenField ID="hfIdPrograma" runat="server" Value="0"/>

                <div class="fila">
                    <div class="grupo">
                        <label>CÓDIGO DEL PROGRAMA</label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="campo" placeholder="Ej: 228106"/>
                    </div>
                    <div class="grupo">
                        <label>NOMBRE DEL PROGRAMA</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="campo" placeholder="Nombre completo"/>
                    </div>
                    <div class="grupo">
                        <label>VERSIÓN</label>
                        <asp:TextBox ID="txtVersion" runat="server" CssClass="campo" placeholder="Ej: 102"/>
                    </div>
                </div>

                <div class="fila-2">
                    <div class="grupo">
                        <label>NIVEL DE FORMACIÓN</label>
                        <asp:DropDownList ID="ddlNivel" runat="server" CssClass="campo">
                            <asp:ListItem Value="">-- Selecciona --</asp:ListItem>
                            <asp:ListItem Value="Técnico">Técnico</asp:ListItem>
                            <asp:ListItem Value="Tecnólogo">Tecnólogo</asp:ListItem>
                            <asp:ListItem Value="Especialización Tecnológica">Especialización Tecnológica</asp:ListItem>
                            <asp:ListItem Value="Operario">Operario</asp:ListItem>
                            <asp:ListItem Value="Auxiliar">Auxiliar</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="grupo">
                        <label>DURACIÓN (horas)</label>
                        <asp:TextBox ID="txtDuracion" runat="server" CssClass="campo" placeholder="Ej: 2200"/>
                    </div>
                </div>

                <div class="fila-2">
                    <div class="grupo">
                        <label>ESTADO</label>
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="campo">
                            <asp:ListItem Value="Activo">Activo</asp:ListItem>
                            <asp:ListItem Value="Inactivo">Inactivo</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="botones">
                    <asp:Button ID="btnGuardar" runat="server" Text="💾 Guardar" CssClass="btn-guardar" OnClick="btnGuardar_Click"/>
                    <asp:Button ID="btnLimpiar" runat="server" Text="✖ Cancelar" CssClass="btn-limpiar" OnClick="btnLimpiar_Click"/>
                </div>
            </div>

            <!-- Tabla -->
            <div class="panel">
                <div class="panel-titulo">Programas Registrados</div>

                <div class="buscador-wrapper">
                    <asp:TextBox ID="txtBuscar" runat="server" placeholder="🔍 Buscar por nombre o código..." AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged"/>
                </div>

                <div class="tabla-wrapper">
                    <asp:GridView ID="gvProgramas" runat="server"
                        AutoGenerateColumns="false"
                        OnRowCommand="gvProgramas_RowCommand"
                        EmptyDataText="No hay programas registrados."
                        CssClass="tabla">
                        <Columns>
                            <asp:BoundField DataField="CodigoPrograma" HeaderText="CÓDIGO"/>
                            <asp:BoundField DataField="NombrePrograma" HeaderText="NOMBRE"/>
                            <asp:BoundField DataField="Version" HeaderText="VERSIÓN"/>
                            <asp:BoundField DataField="NivelFormacion" HeaderText="NIVEL"/>
                            <asp:BoundField DataField="Duracion" HeaderText="DURACIÓN (h)"/>
                            <asp:TemplateField HeaderText="ESTADO">
                                <ItemTemplate>
                                    <span class='<%# Eval("Estado").ToString() == "Activo" ? "badge badge-activo" : "badge badge-inactivo" %>'>
                                        <%# Eval("Estado") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACCIONES">
                                <ItemTemplate>
                                    <asp:Button CommandName="Editar" CommandArgument='<%# Eval("IdPrograma") %>'
                                        Text="✏ Editar" CssClass="btn-editar" runat="server"/>
                                    <asp:Button CommandName="Eliminar" CommandArgument='<%# Eval("IdPrograma") %>'
                                        Text="🗑 Eliminar" CssClass="btn-eliminar" runat="server"
                                        OnClientClick="return confirm('¿Seguro que deseas eliminar este programa?');"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
    </form>
</body>
</html>