<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiFicha.aspx.cs" Inherits="SistemaPlanMejoramiento.MiFicha" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mi Ficha - SENA</title>

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

        .content { 
            padding: 28px; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
        }

        .panel-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 600px;
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

        .panel-body {
            padding: 24px 20px;
        }

        .campo-info { margin-bottom: 18px; }
        
        .campo-info label { 
            display: block; 
            font-size: 10px; 
            font-weight: 700; 
            color: var(--muted); 
            letter-spacing: 1.2px; 
            text-transform: uppercase; 
            margin-bottom: 6px; 
            margin-left: 2px;
        }
        
        .p-box {
            display: block;
            width: 100%;
            font-size: 13px; 
            color: var(--text); 
            padding: 11px 14px; 
            background: #f8fafc; 
            border: 1px solid var(--border);
            border-radius: 8px;
            transition: all 0.18s;
            font-weight: 500;
        }
        .p-box:hover { 
            border-color: var(--green); 
            background: #fff;
        }

        .fechas-grid {
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 16px;
        }

        .badge-wrapper { padding-top: 4px; }
        .badge-estado { 
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px; 
            border-radius: 20px; 
            background: var(--blue-soft);
            color: var(--blue);
            font-size: 12px;
            font-weight: 700;
        }

        .mensaje-error { 
            background: var(--red-soft); 
            border: 1px solid #fecdd3; 
            border-radius: 8px; 
            padding: 12px 16px; 
            color: var(--red); 
            font-size: 13px; 
            font-weight: 600;
            margin-bottom: 20px;
            width: 100%;
            max-width: 600px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .fade-up { animation: fadeUp 0.25s ease-out; }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 640px) {
            .topbar { padding: 14px 16px; }
            .content { padding: 16px; }
            .fechas-grid { grid-template-columns: 1fr; gap: 0; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="topbar">
            <div class="topbar-left">
                <div class="page-icon"><i class="fa-solid fa-folder-closed"></i></div>
                <div>
                    <div class="page-title">Mi Ficha</div>
                    <div class="page-sub">Información de tu ficha de formación</div>
                </div>
            </div>
            <a href="MenuAprendiz.aspx" class="btn-volver">
                <i class="fa-solid fa-arrow-left"></i> Volver al menú
            </a>
        </div>

        <div class="content fade-up">
            
            <asp:Panel ID="pnlError" runat="server" CssClass="mensaje-error" Visible="false">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Label ID="lblError" runat="server" Text="" />
            </asp:Panel>
            
            <div class="panel-card">
                <div class="panel-header">
                    <div class="ch-icon"><i class="fa-solid fa-graduation-cap"></i></div>
                    <div>
                        <h3>Datos de la Ficha</h3>
                    </div>
                </div>

                <div class="panel-body">
                    <div class="campo-info">
                        <label>Código Ficha</label>
                        <div class="p-box">
                            <asp:Label ID="lblCodigo" runat="server" Text="Cargando..." />
                        </div>
                    </div>

                    <div class="campo-info">
                        <label>Programa de Formación</label>
                        <div class="p-box">
                            <asp:Label ID="lblPrograma" runat="server" Text="Cargando..." />
                        </div>
                    </div>

                    <div class="fechas-grid">
                        <div class="campo-info">
                            <label>Fecha Inicio</label>
                            <div class="p-box">
                                <asp:Label ID="lblFechaInicio" runat="server" Text="-" />
                            </div>
                        </div>
                        <div class="campo-info">
                            <label>Fecha Fin</label>
                            <div class="p-box">
                                <asp:Label ID="lblFechaFin" runat="server" Text="-" />
                            </div>
                        </div>
                    </div>

                    <div class="campo-info">
                        <label>Jornada</label>
                        <div class="p-box">
                            <asp:Label ID="lblJornada" runat="server" Text="-" />
                        </div>
                    </div>

                    <div class="campo-info" style="margin-bottom: 0;">
                        <label>Estado de Ficha</label>
                        <div class="badge-wrapper">
                            <span class="badge-estado">
                                <i class="fa-solid fa-circle-info"></i>
                                <asp:Label ID="lblEstado" runat="server" Text="En Ejecución" />
                            </span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>