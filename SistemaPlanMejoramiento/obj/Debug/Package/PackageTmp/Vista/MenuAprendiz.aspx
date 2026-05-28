<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuAprendiz.aspx.cs" Inherits="SistemaPlanMejoramiento.MenuAprendiz" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Panel Aprendiz - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        :root {
            --green: #2e7d32;
            --green-l: #43a047;
            --green-xl: #e8f5e9;
            --bg: #f0f4f1;
            --sw: 272px;
            --white: #ffffff;
            --dark: #1a2e1b;
            --mid: #4a6350;
            --soft: #8da693;
            --border: #dce8dd;
            --shadow-sm: 0 1px 4px rgba(46,125,50,.07);
            --shadow-md: 0 4px 20px rgba(46,125,50,.11);
            --r: 14px;
            --rs: 9px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Plus Jakarta Sans',sans-serif;
            background: var(--bg);
            color: var(--dark);
            min-height: 100vh;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: var(--sw);
            height: 100vh;
            background: var(--white);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            z-index: 200;
            box-shadow: 2px 0 16px rgba(46,125,50,.06);
        }

        .s-brand {
            padding: 22px 20px 18px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .s-logo {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg,var(--green),var(--green-l));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(46,125,50,.3);
        }

            .s-logo span {
                font-size: 19px;
                font-weight: 800;
                color: #fff;
            }

        .s-brand-text h2 {
            font-size: 16px;
            font-weight: 800;
            color: var(--dark);
            letter-spacing: -.4px;
            line-height: 1;
        }

        .s-brand-text p {
            font-size: 11px;
            color: var(--soft);
            font-weight: 500;
            margin-top: 2px;
        }

        .s-nav {
            flex: 1;
            padding: 14px 12px;
            overflow-y: auto;
        }

        .nav-label {
            font-size: 10px;
            font-weight: 700;
            color: var(--soft);
            letter-spacing: 1.4px;
            text-transform: uppercase;
            padding: 14px 10px 5px;
        }

        .nav-a {
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 10px 12px;
            color: var(--mid);
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 500;
            border-radius: var(--rs);
            transition: all .18s;
            margin-bottom: 2px;
        }

            .nav-a i {
                width: 18px;
                text-align: center;
                font-size: 14px;
                color: var(--soft);
            }

            .nav-a:hover {
                background: var(--green-xl);
                color: var(--green);
            }

                .nav-a:hover i {
                    color: var(--green);
                }

        .s-footer {
            padding: 16px;
            border-top: 1px solid var(--border);
        }

        .u-card {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            background: var(--green-xl);
            border-radius: var(--rs);
            margin-bottom: 10px;
        }

        .u-avatar {
            width: 34px;
            height: 34px;
            background: linear-gradient(135deg,#f59e0b,#d97706);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            color: #fff;
            flex-shrink: 0;
        }

        .u-info h5 {
            font-size: 13px;
            font-weight: 700;
            color: var(--dark);
            margin: 0;
            line-height: 1;
        }

        .u-info p {
            font-size: 11px;
            color: var(--green);
            font-weight: 600;
            margin: 0;
            margin-top: 2px;
        }

        .btn-logout {
            width: 100%;
            padding: 9px;
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: var(--rs);
            color: var(--mid);
            font-family: 'Plus Jakarta Sans',sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all .18s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
        }

            .btn-logout:hover {
                background: #fef2f2;
                border-color: #fca5a5;
                color: #dc2626;
            }

        .main {
            margin-left: var(--sw);
            min-height: 100vh;
        }

        .topbar {
            background: var(--white);
            border-bottom: 1px solid var(--border);
            padding: 0 36px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: var(--shadow-sm);
        }

        .topbar-l h1 {
            font-size: 18px;
            font-weight: 800;
            color: var(--dark);
            letter-spacing: -.4px;
        }

        .topbar-l p {
            font-size: 12px;
            color: var(--soft);
            font-weight: 500;
        }

        .badge-rol {
            padding: 5px 14px;
            background: #fff7ed;
            color: #c2410c;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .content {
            padding: 32px 36px;
        }

        .hero-card {
            background: linear-gradient(135deg,var(--green) 0%,var(--green-l) 60%,#66bb6a 100%);
            border-radius: var(--r);
            padding: 28px 32px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 8px 32px rgba(46,125,50,.2);
            overflow: hidden;
            position: relative;
        }

            .hero-card::before {
                content: '';
                position: absolute;
                right: -40px;
                top: -40px;
                width: 200px;
                height: 200px;
                border-radius: 50%;
                background: rgba(255,255,255,.07);
            }

            .hero-card::after {
                content: '';
                position: absolute;
                right: 60px;
                bottom: -60px;
                width: 160px;
                height: 160px;
                border-radius: 50%;
                background: rgba(255,255,255,.05);
            }

        .hero-left {
            position: relative;
            z-index: 1;
        }

            .hero-left p {
                font-size: 13px;
                color: rgba(255,255,255,.75);
                font-weight: 500;
                margin-bottom: 6px;
            }

            .hero-left h2 {
                font-size: 24px;
                font-weight: 800;
                color: #fff;
                margin-bottom: 14px;
                letter-spacing: -.4px;
            }

        .hero-tags {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .hero-tag {
            display: flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,.15);
            border: 1px solid rgba(255,255,255,.2);
            border-radius: 20px;
            padding: 5px 12px;
            backdrop-filter: blur(4px);
        }

            .hero-tag i {
                font-size: 11px;
                color: rgba(255,255,255,.8);
            }

            .hero-tag span {
                font-size: 12px;
                color: #fff;
                font-weight: 600;
            }

        .hero-right {
            position: relative;
            z-index: 1;
            text-align: right;
        }

        .estado-badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: rgba(255,255,255,.2);
            border: 1px solid rgba(255,255,255,.3);
            border-radius: 30px;
            padding: 8px 18px;
            margin-bottom: 10px;
        }

        .estado-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #a5f3fc;
            flex-shrink: 0;
        }

        .estado-badge span {
            font-size: 13px;
            font-weight: 700;
            color: #fff;
        }

        .hero-right p {
            font-size: 11px;
            color: rgba(255,255,255,.6);
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(4,1fr);
            gap: 16px;
            margin-bottom: 28px;
        }

        .stat-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--r);
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            box-shadow: var(--shadow-sm);
            transition: all .2s;
        }

            .stat-card:hover {
                box-shadow: var(--shadow-md);
                transform: translateY(-2px);
            }

        .stat-icon {
            width: 42px;
            height: 42px;
            border-radius: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            flex-shrink: 0;
        }

        .si-blue {
            background: #e3f2fd;
            color: #1565c0;
        }

        .si-orange {
            background: #fff3e0;
            color: #e65100;
        }

        .si-green {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .si-purple {
            background: #f3e5f5;
            color: #6a1b9a;
        }

        .stat-info p {
            font-size: 11px;
            color: var(--soft);
            font-weight: 600;
            margin: 0;
        }

        .stat-info h4 {
            font-size: 22px;
            font-weight: 800;
            color: var(--dark);
            margin: 0;
            line-height: 1.2;
        }

        .sec-title {
            font-size: 14px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

            .sec-title i {
                color: var(--green);
                font-size: 13px;
            }

            .sec-title::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill,minmax(210px,1fr));
            gap: 16px;
        }

        .mod-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--r);
            padding: 22px 20px;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            transition: all .22s cubic-bezier(.4,0,.2,1);
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

            .mod-card::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: transparent;
                transition: background .22s;
            }

            .mod-card:hover {
                border-color: var(--green);
                box-shadow: var(--shadow-md);
                transform: translateY(-4px);
            }

                .mod-card:hover::after {
                    background: linear-gradient(90deg,var(--green),var(--green-l));
                }

        .mod-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 19px;
            margin-bottom: 14px;
        }

        .mod-card h3 {
            font-size: 14px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .mod-card p {
            font-size: 12px;
            color: var(--soft);
            line-height: 1.4;
            margin: 0;
        }

        .mod-arrow {
            position: absolute;
            right: 16px;
            bottom: 16px;
            font-size: 12px;
            color: var(--border);
            transition: all .2s;
        }

        .mod-card:hover .mod-arrow {
            color: var(--green);
            transform: translateX(3px);
        }

        .fade-in {
            animation: fadeIn .45s ease both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px)
            }

            to {
                opacity: 1;
                transform: translateY(0)
            }
        }

        .fade-in:nth-child(1) {
            animation-delay: .04s
        }

        .fade-in:nth-child(2) {
            animation-delay: .08s
        }

        .fade-in:nth-child(3) {
            animation-delay: .12s
        }

        .fade-in:nth-child(4) {
            animation-delay: .16s
        }

        .fade-in:nth-child(5) {
            animation-delay: .20s
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Label ID="lblNombreCompleto" runat="server" Style="display: none" />
        <asp:Label ID="lblEstado" runat="server" Style="display: none" />
        <asp:Label ID="lblDocumento" runat="server" Style="display: none" />
        <asp:Label ID="lblFicha" runat="server" Style="display: none" />
        <asp:Label ID="lblPrograma" runat="server" Style="display: none" />
        <asp:Label ID="lblFechaFin" runat="server" Style="display: none" />
        <asp:Label ID="lblTotalPlanes" runat="server" Style="display: none" />
        <asp:Label ID="lblPlanesPendientes" runat="server" Style="display: none" />
        <asp:Label ID="lblPlanesAprobados" runat="server" Style="display: none" />
        <asp:Label ID="lblTotalEvidencias" runat="server" Style="display: none" />

        <aside class="sidebar">
            <div class="s-brand">
                <div class="s-logo"><span>S</span></div>
                <div class="s-brand-text">
                    <h2>SENA</h2>
                    <p>Gestión Aprendiz</p>
                </div>
            </div>
            <nav class="s-nav">
                <div class="nav-label">Académico</div>
                <a href="MiPerfil.aspx" class="nav-a"><i class="fas fa-user-circle"></i>Mi Perfil</a>
                <a href="MiFicha.aspx" class="nav-a"><i class="fas fa-id-card"></i>Mi Ficha</a>
                <a href="MisResultados.aspx" class="nav-a"><i class="fas fa-file-alt"></i>Mis Resultados</a>
                <div class="nav-label">Planes de Mejoramiento</div>
                <a href="MiPlan.aspx" class="nav-a"><i class="fas fa-clipboard-check"></i>Mis Planes</a>
                <a href="SubirEvidencia.aspx" class="nav-a"><i class="fas fa-cloud-upload-alt"></i>Subir Evidencias</a>
            </nav>
            <div class="s-footer">
                <div class="u-card">
                    <div class="u-avatar">A</div>
                    <div class="u-info">
                        <h5>
                            <asp:Label ID="lblUsuario" runat="server" Text="" /></h5>
                        <p>Aprendiz</p>
                    </div>
                </div>
                <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión"
                    CssClass="btn-logout" OnClick="btnSalir_Click" />
            </div>
        </aside>

        <main class="main">
            <div class="topbar">
                <div class="topbar-l">
                    <h1>Panel del Aprendiz</h1>
                    <p>Consulta tu proceso formativo y gestiona tus planes</p>
                </div>
                <span class="badge-rol"><i class="fas fa-user-graduate" style="margin-right: 5px"></i>Aprendiz</span>
            </div>

            <div class="content">

                <div class="hero-card fade-in">
                    <div class="hero-left">
                        <p>Bienvenido de vuelta</p>
                        <h2 id="heroNombre">—</h2>
                        <div class="hero-tags">
                            <div class="hero-tag"><i class="fas fa-folder"></i><span id="heroFicha">—</span></div>
                            <div class="hero-tag"><i class="fas fa-book"></i><span id="heroPrograma">—</span></div>
                            <div class="hero-tag"><i class="fas fa-calendar"></i><span id="heroFecha">—</span></div>
                        </div>
                    </div>
                    <div class="hero-right">
                        <div class="estado-badge">
                            <div class="estado-dot"></div>
                            <span id="heroEstado">—</span>
                        </div>
                        <p>Estado académico actual</p>
                    </div>
                </div>

                <div class="stats-row">
                    <div class="stat-card fade-in">
                        <div class="stat-icon si-blue"><i class="fas fa-clipboard-list"></i></div>
                        <div class="stat-info">
                            <p>Total Planes</p>
                            <h4 id="sTotalPlanes">—</h4>
                        </div>
                    </div>
                    <div class="stat-card fade-in">
                        <div class="stat-icon si-orange"><i class="fas fa-hourglass-half"></i></div>
                        <div class="stat-info">
                            <p>Planes Pendientes</p>
                            <h4 id="sPendientes">—</h4>
                        </div>
                    </div>
                    <div class="stat-card fade-in">
                        <div class="stat-icon si-green"><i class="fas fa-check-circle"></i></div>
                        <div class="stat-info">
                            <p>Planes Aprobados</p>
                            <h4 id="sAprobados">—</h4>
                        </div>
                    </div>
                    <div class="stat-card fade-in">
                        <div class="stat-icon si-purple"><i class="fas fa-paperclip"></i></div>
                        <div class="stat-info">
                            <p>Evidencias Subidas</p>
                            <h4 id="sEvidencias">—</h4>
                        </div>
                    </div>
                </div>

                <div class="sec-title"><i class="fas fa-th-large"></i>Accesos Rápidos</div>
                <div class="modules-grid">
                    <a href="MiPerfil.aspx" class="mod-card fade-in">
                        <div class="mod-icon si-blue"><i class="fas fa-user-edit"></i></div>
                        <h3>Mi Perfil</h3>
                        <p>Consulta tus datos personales</p>
                        <i class="fas fa-arrow-right mod-arrow"></i>
                    </a>
                    <a href="MiFicha.aspx" class="mod-card fade-in">
                        <div class="mod-icon si-green"><i class="fas fa-layer-group"></i></div>
                        <h3>Mi Ficha</h3>
                        <p>Información de tu programa de formación</p>
                        <i class="fas fa-arrow-right mod-arrow"></i>
                    </a>
                    <a href="MisResultados.aspx" class="mod-card fade-in">
                        <div class="mod-icon si-purple"><i class="fas fa-file-alt"></i></div>
                        <h3>Mis Resultados</h3>
                        <p>Resultados de aprendizaje de tu ficha</p>
                        <i class="fas fa-arrow-right mod-arrow"></i>
                    </a>
                    <a href="MiPlan.aspx" class="mod-card fade-in">
                        <div class="mod-icon si-orange"><i class="fas fa-clipboard-check"></i></div>
                        <h3>Mis Planes</h3>
                        <p>Consulta y gestiona tus planes de mejoramiento</p>
                        <i class="fas fa-arrow-right mod-arrow"></i>
                    </a>
                    <a href="SubirEvidencia.aspx" class="mod-card fade-in">
                        <div class="mod-icon si-green"><i class="fas fa-cloud-upload-alt"></i></div>
                        <h3>Subir Evidencias</h3>
                        <p>Carga archivos para tus planes activos</p>
                        <i class="fas fa-arrow-right mod-arrow"></i>
                    </a>
                </div>

            </div>
        </main>

    </form>
    <script>
        function txt(id) { var el = document.getElementById(id); return el ? el.textContent.trim() : ''; }
        document.getElementById('heroNombre').textContent = txt('<%= lblNombreCompleto.ClientID %>') || '—';
        document.getElementById('heroEstado').textContent = txt('<%= lblEstado.ClientID %>') || '—';
        document.getElementById('heroFicha').textContent = 'Ficha ' + (txt('<%= lblFicha.ClientID %>') || '—');
        document.getElementById('heroPrograma').textContent = txt('<%= lblPrograma.ClientID %>') || '—';
        document.getElementById('heroFecha').textContent = 'Hasta ' + (txt('<%= lblFechaFin.ClientID %>') || '—');
        document.getElementById('sTotalPlanes').textContent = txt('<%= lblTotalPlanes.ClientID %>') || '0';
        document.getElementById('sPendientes').textContent = txt('<%= lblPlanesPendientes.ClientID %>') || '0';
        document.getElementById('sAprobados').textContent = txt('<%= lblPlanesAprobados.ClientID %>') || '0';
        document.getElementById('sEvidencias').textContent = txt('<%= lblTotalEvidencias.ClientID %>') || '0';
    </script>
</body>
</html>
