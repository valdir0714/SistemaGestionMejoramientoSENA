<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuAdmin.aspx.cs" Inherits="SistemaPlanMejoramiento.MenuAdmin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Panel Administrador - SENA</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <style>
        :root {
            --green:      #2e7d32;
            --green-l:    #43a047;
            --green-xl:   #e8f5e9;
            --green-acc:  #00c853;
            --bg:         #f0f4f1;
            --sw:         272px;
            --white:      #ffffff;
            --dark:       #1a2e1b;
            --mid:        #4a6350;
            --soft:       #8da693;
            --border:     #dce8dd;
            --shadow-sm:  0 1px 4px rgba(46,125,50,.07);
            --shadow-md:  0 4px 20px rgba(46,125,50,.11);
            --r:          14px;
            --rs:         9px;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Plus Jakarta Sans',sans-serif; background:var(--bg); color:var(--dark); min-height:100vh; }

        .sidebar {
            position:fixed; left:0; top:0; width:var(--sw); height:100vh;
            background:var(--white); border-right:1px solid var(--border);
            display:flex; flex-direction:column; z-index:200;
            box-shadow:2px 0 16px rgba(46,125,50,.06);
        }
        .s-brand {
            padding:22px 20px 18px; border-bottom:1px solid var(--border);
            display:flex; align-items:center; gap:13px;
        }
        .s-logo {
            width:42px; height:42px;
            background:linear-gradient(135deg,var(--green),var(--green-l));
            border-radius:12px; display:flex; align-items:center; justify-content:center;
            box-shadow:0 4px 12px rgba(46,125,50,.3);
        }
        .s-logo span { font-size:19px; font-weight:800; color:#fff; }
        .s-brand-text h2 { font-size:16px; font-weight:800; color:var(--dark); letter-spacing:-.4px; line-height:1; }
        .s-brand-text p  { font-size:11px; color:var(--soft); font-weight:500; margin-top:2px; }
        .s-nav { flex:1; padding:14px 12px; overflow-y:auto; }
        .nav-label { font-size:10px; font-weight:700; color:var(--soft); letter-spacing:1.4px; text-transform:uppercase; padding:14px 10px 5px; }
        .nav-a {
            display:flex; align-items:center; gap:11px; padding:10px 12px;
            color:var(--mid); text-decoration:none; font-size:13.5px; font-weight:500;
            border-radius:var(--rs); transition:all .18s; margin-bottom:2px;
        }
        .nav-a i { width:18px; text-align:center; font-size:14px; color:var(--soft); transition:color .18s; }
        .nav-a:hover { background:var(--green-xl); color:var(--green); }
        .nav-a:hover i { color:var(--green); }
        .s-footer { padding:16px; border-top:1px solid var(--border); }
        .u-card {
            display:flex; align-items:center; gap:10px; padding:10px 12px;
            background:var(--green-xl); border-radius:var(--rs); margin-bottom:10px;
        }
        .u-avatar {
            width:34px; height:34px;
            background:linear-gradient(135deg,var(--green),var(--green-l));
            border-radius:50%; display:flex; align-items:center; justify-content:center;
            font-size:13px; font-weight:700; color:#fff; flex-shrink:0;
        }
        .u-info h5 { font-size:13px; font-weight:700; color:var(--dark); margin:0; line-height:1; }
        .u-info p  { font-size:11px; color:var(--green); font-weight:600; margin:0; margin-top:2px; }
        .btn-logout {
            width:100%; padding:9px; background:transparent;
            border:1.5px solid var(--border); border-radius:var(--rs);
            color:var(--mid); font-family:'Plus Jakarta Sans',sans-serif;
            font-size:13px; font-weight:600; cursor:pointer; transition:all .18s;
            display:flex; align-items:center; justify-content:center; gap:7px;
        }
        .btn-logout:hover { background:#fef2f2; border-color:#fca5a5; color:#dc2626; }

        /* MAIN */
        .main { margin-left:var(--sw); min-height:100vh; }
        .topbar {
            background:var(--white); border-bottom:1px solid var(--border);
            padding:0 36px; height:64px;
            display:flex; align-items:center; justify-content:space-between;
            position:sticky; top:0; z-index:100;
            box-shadow:var(--shadow-sm);
        }
        .topbar-l h1 { font-size:18px; font-weight:800; color:var(--dark); letter-spacing:-.4px; }
        .topbar-l p  { font-size:12px; color:var(--soft); font-weight:500; }
        .badge-rol {
            padding:5px 14px; background:var(--green-xl); color:var(--green);
            border-radius:20px; font-size:12px; font-weight:700;
        }

        /* CONTENT */
        .content { padding:32px 36px; }

        /* TOTALS STRIP */
        .totals-strip {
            display:flex; gap:14px; margin-bottom:30px; flex-wrap:wrap;
        }
        .total-chip {
            display:flex; align-items:center; gap:10px;
            background:var(--white); border:1px solid var(--border);
            border-radius:var(--r); padding:14px 20px;
            flex:1; min-width:150px;
            box-shadow:var(--shadow-sm); transition:all .2s;
        }
        .total-chip:hover { box-shadow:var(--shadow-md); transform:translateY(-2px); }
        .tc-icon {
            width:38px; height:38px; border-radius:10px;
            display:flex; align-items:center; justify-content:center;
            font-size:16px; flex-shrink:0;
        }
        .tc-green  { background:#e8f5e9; color:#2e7d32; }
        .tc-blue   { background:#e3f2fd; color:#1565c0; }
        .tc-orange { background:#fff3e0; color:#e65100; }
        .tc-purple { background:#f3e5f5; color:#6a1b9a; }
        .tc-info p  { font-size:11px; color:var(--soft); font-weight:600; margin:0; }
        .tc-info h4 { font-size:20px; font-weight:800; color:var(--dark); margin:0; line-height:1.2; }

        /* SECTION TITLE */
        .sec-title {
            font-size:14px; font-weight:700; color:var(--dark);
            margin-bottom:16px; letter-spacing:-.2px;
            display:flex; align-items:center; gap:10px;
        }
        .sec-title i { color:var(--green); font-size:13px; }
        .sec-title::after { content:''; flex:1; height:1px; background:var(--border); }

        /* MODULES CENTERED */
        .modules-wrap {
            display:flex; justify-content:center; margin-bottom:36px;
        }
        .modules-grid {
            display:grid;
            grid-template-columns: repeat(5, 180px);
            gap:16px;
        }
        .mod-card {
            background:var(--white); border:1px solid var(--border);
            border-radius:var(--r); padding:22px 18px;
            text-decoration:none; display:flex; flex-direction:column;
            align-items:center; text-align:center;
            transition:all .22s cubic-bezier(.4,0,.2,1);
            box-shadow:var(--shadow-sm); position:relative; overflow:hidden;
        }
        .mod-card::after {
            content:''; position:absolute; bottom:0; left:0; right:0;
            height:3px; background:transparent; transition:background .22s;
        }
        .mod-card:hover { border-color:var(--green); box-shadow:var(--shadow-md); transform:translateY(-4px); }
        .mod-card:hover::after { background:linear-gradient(90deg,var(--green),var(--green-l)); }
        .mod-icon {
            width:48px; height:48px; border-radius:13px;
            display:flex; align-items:center; justify-content:center;
            font-size:20px; margin-bottom:13px;
        }
        .mod-card h3 { font-size:13px; font-weight:700; color:var(--dark); margin-bottom:4px; }
        .mod-card p  { font-size:11px; color:var(--soft); line-height:1.4; margin:0; }

        .charts-grid {
            display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:24px;
        }
        .chart-card {
            background:var(--white); border:1px solid var(--border);
            border-radius:var(--r); overflow:hidden;
            box-shadow:var(--shadow-sm);
        }
        .chart-card-full {
            background:var(--white); border:1px solid var(--border);
            border-radius:var(--r); overflow:hidden;
            box-shadow:var(--shadow-sm); margin-bottom:24px;
        }
        .chart-header {
            padding:16px 22px; border-bottom:1px solid var(--border);
            display:flex; align-items:center; gap:9px;
        }
        .chart-header i { color:var(--green); font-size:14px; }
        .chart-header h3 { font-size:13.5px; font-weight:700; color:var(--dark); margin:0; }
        .chart-header p  { font-size:11px; color:var(--soft); margin:0 0 0 auto; }
        .chart-body { padding:20px 22px; }
        .chart-canvas-wrap { position:relative; height:260px; }
        .chart-canvas-wrap-sm { position:relative; height:220px; }

        .fade-in { animation:fadeIn .45s ease both; }
        @keyframes fadeIn { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }
        .fade-in:nth-child(1){animation-delay:.04s}
        .fade-in:nth-child(2){animation-delay:.08s}
        .fade-in:nth-child(3){animation-delay:.12s}
        .fade-in:nth-child(4){animation-delay:.16s}
        .fade-in:nth-child(5){animation-delay:.20s}
    </style>
</head>
<body>
<form id="form1" runat="server">

    <asp:HiddenField ID="hfAprendizLabels" runat="server"/>
    <asp:HiddenField ID="hfAprendizData"   runat="server"/>
    <asp:HiddenField ID="hfPlanLabels"     runat="server"/>
    <asp:HiddenField ID="hfPlanData"       runat="server"/>
    <asp:HiddenField ID="hfFichaLabels"    runat="server"/>
    <asp:HiddenField ID="hfFichaData"      runat="server"/>

    <!-- Totales (ocultos, para chips) -->
    <asp:Label ID="lblTotalProgramas"    runat="server" style="display:none"/>
    <asp:Label ID="lblTotalFichas"       runat="server" style="display:none"/>
    <asp:Label ID="lblTotalInstructores" runat="server" style="display:none"/>
    <asp:Label ID="lblTotalAprendices"   runat="server" style="display:none"/>

    <aside class="sidebar">
        <div class="s-brand">
            <div class="s-logo"><span>S</span></div>
            <div class="s-brand-text">
                <h2>SENA</h2>
                <p>Sistema de Gestión</p>
            </div>
        </div>
        <nav class="s-nav">
            <div class="nav-label">Académico</div>
            <a href="Programas.aspx"       class="nav-a"><i class="fas fa-book-open"></i> Programas</a>
            <a href="Fichas.aspx"          class="nav-a"><i class="fas fa-folder-open"></i> Fichas</a>
            <div class="nav-label">Personas</div>
            <a href="Instructores.aspx"    class="nav-a"><i class="fas fa-chalkboard-teacher"></i> Instructores</a>
            <a href="Aprendices.aspx"      class="nav-a"><i class="fas fa-user-graduate"></i> Aprendices</a>
            <div class="nav-label">Asignaciones</div>
            <a href="AsignarInstructor.aspx" class="nav-a"><i class="fas fa-link"></i> Asignar Instructor</a>
        </nav>
        <div class="s-footer">
            <div class="u-card">
                <div class="u-avatar">A</div>
                <div class="u-info">
                    <h5><asp:Label ID="lblUsuario" runat="server" Text=""/></h5>
                    <p>Administrador</p>
                </div>
            </div>
            <asp:Button ID="btnSalir" runat="server" Text="Cerrar Sesión"
                CssClass="btn-logout" OnClick="btnSalir_Click"/>
        </div>
    </aside>

    <main class="main">
        <div class="topbar">
            <div class="topbar-l">
                <h1>Panel de Administración</h1>
                <p>Gestiona la información académica del centro de formación</p>
            </div>
            <span class="badge-rol"><i class="fas fa-shield-alt" style="margin-right:5px"></i>Administrador</span>
        </div>

        <div class="content">

            <div class="totals-strip">
                <div class="total-chip fade-in">
                    <div class="tc-icon tc-green"><i class="fas fa-book-open"></i></div>
                    <div class="tc-info">
                        <p>Programas</p>
                        <h4 id="chipProgramas">—</h4>
                    </div>
                </div>
                <div class="total-chip fade-in">
                    <div class="tc-icon tc-blue"><i class="fas fa-folder-open"></i></div>
                    <div class="tc-info">
                        <p>Fichas en Ejecución</p>
                        <h4 id="chipFichas">—</h4>
                    </div>
                </div>
                <div class="total-chip fade-in">
                    <div class="tc-icon tc-orange"><i class="fas fa-chalkboard-teacher"></i></div>
                    <div class="tc-info">
                        <p>Instructores Activos</p>
                        <h4 id="chipInstructores">—</h4>
                    </div>
                </div>
                <div class="total-chip fade-in">
                    <div class="tc-icon tc-purple"><i class="fas fa-user-graduate"></i></div>
                    <div class="tc-info">
                        <p>Aprendices</p>
                        <h4 id="chipAprendices">—</h4>
                    </div>
                </div>
            </div>

            <div class="sec-title"><i class="fas fa-th-large"></i> Módulos del Sistema</div>
            <div class="modules-wrap">
                <div class="modules-grid">
                    <a href="Programas.aspx" class="mod-card fade-in">
                        <div class="mod-icon tc-green"><i class="fas fa-book-open"></i></div>
                        <h3>Programas</h3>
                        <p>Gestionar programas</p>
                    </a>
                    <a href="Fichas.aspx" class="mod-card fade-in">
                        <div class="mod-icon tc-blue"><i class="fas fa-folder-open"></i></div>
                        <h3>Fichas</h3>
                        <p>Registrar fichas</p>
                    </a>
                    <a href="Instructores.aspx" class="mod-card fade-in">
                        <div class="mod-icon tc-orange"><i class="fas fa-chalkboard-teacher"></i></div>
                        <h3>Instructores</h3>
                        <p>Gestionar instructores</p>
                    </a>
                    <a href="Aprendices.aspx" class="mod-card fade-in">
                        <div class="mod-icon tc-purple"><i class="fas fa-user-graduate"></i></div>
                        <h3>Aprendices</h3>
                        <p>Gestionar aprendices</p>
                    </a>
                    <a href="AsignarInstructor.aspx" class="mod-card fade-in">
                        <div class="mod-icon tc-green"><i class="fas fa-link"></i></div>
                        <h3>Asignar</h3>
                        <p>Instructor a ficha</p>
                    </a>
                </div>
            </div>

            <div class="sec-title"><i class="fas fa-chart-bar"></i> Estadísticas</div>
            <div class="charts-grid">
                <div class="chart-card fade-in">
                    <div class="chart-header">
                        <i class="fas fa-users"></i>
                        <h3>Aprendices por Estado</h3>
                        <p>Distribución actual</p>
                    </div>
                    <div class="chart-body">
                        <div class="chart-canvas-wrap">
                            <canvas id="chartAprendiz"></canvas>
                        </div>
                    </div>
                </div>
                <div class="chart-card fade-in">
                    <div class="chart-header">
                        <i class="fas fa-clipboard-list"></i>
                        <h3>Planes de Mejoramiento</h3>
                        <p>Por estado</p>
                    </div>
                    <div class="chart-body">
                        <div class="chart-canvas-wrap">
                            <canvas id="chartPlanes"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="chart-card-full fade-in">
                <div class="chart-header">
                    <i class="fas fa-layer-group"></i>
                    <h3>Aprendices por Ficha</h3>
                    <p>Total de aprendices registrados en cada ficha</p>
                </div>
                <div class="chart-body">
                    <div class="chart-canvas-wrap-sm">
                        <canvas id="chartFichas"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </main>

</form>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    const G = ['#2e7d32', '#1565c0', '#e65100', '#6a1b9a', '#c62828', '#00838f', '#f9a825', '#4e342e'];   


    function getVal(id){ return document.getElementById(id).value; }

    document.getElementById('chipProgramas').textContent    = document.getElementById('<%= lblTotalProgramas.ClientID %>').textContent || '—';
    document.getElementById('chipFichas').textContent       = document.getElementById('<%= lblTotalFichas.ClientID %>').textContent || '—';
    document.getElementById('chipInstructores').textContent = document.getElementById('<%= lblTotalInstructores.ClientID %>').textContent || '—';
    document.getElementById('chipAprendices').textContent   = document.getElementById('<%= lblTotalAprendices.ClientID %>').textContent || '—';

    const baseOpts = {
        responsive: true, maintainAspectRatio: false,
        plugins: {
            legend: { labels: { font:{ family:"'Plus Jakarta Sans',sans-serif", size:12 }, color:'#4a6350', padding:16 } }
        }
    };

    (function(){
        const labels = JSON.parse(getVal('<%= hfAprendizLabels.ClientID %>') || '[]');
        const data   = JSON.parse(getVal('<%= hfAprendizData.ClientID %>') || '[]');
        if(!labels.length){ document.getElementById('chartAprendiz').parentElement.innerHTML='<p style="text-align:center;color:#8da693;padding:40px;font-size:13px">Sin datos</p>'; return; }
        new Chart(document.getElementById('chartAprendiz'), {
            type:'doughnut',
            data:{ labels, datasets:[{ data, backgroundColor:G, borderWidth:2, borderColor:'#fff', hoverOffset:8 }] },
            options:{ ...baseOpts, cutout:'62%', plugins:{ ...baseOpts.plugins, tooltip:{ callbacks:{ label: ctx => ` ${ctx.label}: ${ctx.parsed} aprendices` } } } }
        });
    })();

    (function(){
        const labels = JSON.parse(getVal('<%= hfPlanLabels.ClientID %>') || '[]');
        const data   = JSON.parse(getVal('<%= hfPlanData.ClientID %>') || '[]');
        if(!labels.length){ document.getElementById('chartPlanes').parentElement.innerHTML='<p style="text-align:center;color:#8da693;padding:40px;font-size:13px">Sin datos</p>'; return; }
        new Chart(document.getElementById('chartPlanes'), {
            type:'bar',
            data:{ labels, datasets:[{ label:'Planes', data, backgroundColor: labels.map((_,i)=>G[i%G.length]), borderRadius:8, borderSkipped:false }] },
            options:{ ...baseOpts, scales:{
                x:{ grid:{display:false}, ticks:{font:{family:"'Plus Jakarta Sans',sans-serif",size:11},color:'#8da693'} },
                y:{ grid:{color:'#f0f4f1'}, ticks:{font:{family:"'Plus Jakarta Sans',sans-serif",size:11},color:'#8da693', stepSize:1} }
            }, plugins:{ ...baseOpts.plugins, legend:{display:false} } }
        });
    })();

    (function(){
        const labels = JSON.parse(getVal('<%= hfFichaLabels.ClientID %>') || '[]');
        const data   = JSON.parse(getVal('<%= hfFichaData.ClientID %>') || '[]');
        if(!labels.length){ document.getElementById('chartFichas').parentElement.innerHTML='<p style="text-align:center;color:#8da693;padding:40px;font-size:13px">Sin datos</p>'; return; }
        new Chart(document.getElementById('chartFichas'), {
            type:'bar',
            data:{ labels, datasets:[{
                label:'Aprendices', data,
                backgroundColor: ['#2e7d32', '#1565c0', '#e65100', '#6a1b9a', '#c62828', '#00838f'].map(c => c),
                borderColor: ['#2e7d32', '#1565c0', '#e65100', '#6a1b9a', '#c62828', '#00838f'],
                borderRadius:6, borderSkipped:false
            }] },
            options:{ ...baseOpts, indexAxis:'y', scales:{
                x:{ grid:{color:'#f0f4f1'}, ticks:{font:{family:"'Plus Jakarta Sans',sans-serif",size:11},color:'#8da693', stepSize:1} },
                y:{ grid:{display:false}, ticks:{font:{family:"'Plus Jakarta Sans',sans-serif",size:11},color:'#4a6350'} }
            }, plugins:{ ...baseOpts.plugins, legend:{display:false} } }
        });
    })();
</script>
</body>
</html>
