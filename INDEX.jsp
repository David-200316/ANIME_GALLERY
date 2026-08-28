<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anime Gallery</title>
    <style>
        * {
            box-sizing: border-box;
            user-select: none;
        }
        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background:
                radial-gradient(circle at top left, #24104f 0%, transparent 35%),
                radial-gradient(circle at bottom right, #071b3d 0%, transparent 35%),
                #090914;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
        }
        .main-container {
            width: 95%;
            max-width: 1250px;
            height: 88vh;
            display: flex;
            background: rgba(15, 15, 30, 0.94);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 20px;
            overflow: hidden;
            box-shadow:
                0 0 40px rgba(110, 60, 255, 0.25),
                0 20px 60px rgba(0,0,0,0.6);
        }
        /* SIDEBAR */
        .sidebar {
            width: 210px;
            padding: 20px;
            background: rgba(8,8,18,0.95);
            border-right: 1px solid rgba(255,255,255,0.08);
            overflow-y: auto;
        }
        .sidebar-title {
            text-align: center;
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 2px;
            color: #ffffff;
        }
        .sidebar-title span {
            color: #9d5cff;
        }
        .sidebar img {
            width: 100%;
            height: 115px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 14px;
            cursor: pointer;
            border: 2px solid transparent;
            opacity: 0.65;
            transition: all 0.3s ease;
        }
        .sidebar img:hover {
            opacity: 1;
            transform: scale(1.04);
            border-color: #9d5cff;
            box-shadow: 0 0 15px rgba(157,92,255,0.5);
        }
        .sidebar img.selected {
            opacity: 1;
            border-color: #b36bff;
            box-shadow: 0 0 20px rgba(157,92,255,0.7);
        }
        /* VISOR */
        .viewer-container {
            flex: 1;
            position: relative;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background:
                radial-gradient(circle, rgba(50,20,90,0.35), transparent 60%),
                #070711;
        }
        .header {
            height: 75px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            background: rgba(10,10,20,0.7);
            z-index: 10;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 3px;
        }
        .logo span {
            color: #a65cff;
        }
        .counter {
            font-size: 14px;
            color: #aaa;
        }
        /* ÁREA DE IMAGEN */
        .image-area {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
            cursor: grab;
        }
        .image-area.grabbing {
            cursor: grabbing;
        }
        /* LA IMAGEN GRANDE */
        #FOTITOS {
            max-width: 82%;
            max-height: 78%;
            object-fit: contain;
            border-radius: 10px;
            filter: drop-shadow(0 0 25px rgba(130,70,255,0.25));
            transform: scale(1);
            transform-origin: center center;
            transition: transform 0.15s ease;
            will-change: transform;
        }
        /* INFO */
        .character-info {
            position: absolute;
            bottom: 20px;
            left: 30px;
            padding: 15px 20px;
            background: rgba(10,10,20,0.85);
            border-left: 3px solid #a65cff;
            border-radius: 8px;
            backdrop-filter: blur(10px);
            z-index: 10;
            pointer-events: none;
        }
        .character-info h2 {
            margin: 0 0 5px 0;
            font-size: 20px;
        }
        .character-info p {
            margin: 0;
            font-size: 13px;
            color: #999;
        }
        /* CONTROLES */
        .controls {
            position: absolute;
            right: 25px;
            bottom: 20px;
            display: flex;
            gap: 8px;
            z-index: 10;
        }
        .controls button {
            width: 42px;
            height: 42px;
            border: none;
            border-radius: 10px;
            background: rgba(30,30,50,0.9);
            color: white;
            font-size: 18px;
            cursor: pointer;
            transition: 0.25s;
        }
        .controls button:hover {
            background: #8b45e8;
            transform: translateY(-2px);
            box-shadow: 0 0 15px rgba(139,69,232,0.6);
        }
        /* SCROLLBAR */
        .sidebar::-webkit-scrollbar {
            width: 5px;
        }
        .sidebar::-webkit-scrollbar-track {
            background: #0b0b14;
        }
        .sidebar::-webkit-scrollbar-thumb {
            background: #6332a8;
            border-radius: 10px;
        }
        @media (max-width: 700px) {
            .main-container {
                width: 100%;
                height: 95vh;
            }
            .sidebar {
                width: 110px;
                padding: 10px;
            }
            .sidebar img {
                height: 80px;
            }
            .header {
                padding: 0 15px;
            }
            .logo {
                font-size: 18px;
            }
            .character-info {
                left: 15px;
                bottom: 15px;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="sidebar">
        <div class="sidebar-title">
            <span>ANIME</span> GALLERY
        </div>
        <div id="sidebar"></div>
    </div>
    <div class="viewer-container">
        <div class="header">
            <div class="logo">
                ANIME <span>GALLERY</span>
            </div>
            <div class="counter" id="counter">1 / 28</div>
        </div>
        <div class="image-area" id="imageArea">
            <img id="FOTITOS" src="FOTOS/C0001.jpg" alt="Personaje de anime">
            <div class="character-info">
                <h2 id="characterName">Personaje 01</h2>
                <p id="characterDescription">Selecciona una imagen</p>
            </div>
            <div class="controls">
                <button onclick="alejar()" title="Alejar">−</button>
                <button onclick="normal()" title="Normal">⟳</button>
                <button onclick="acercar()" title="Acercar">+</button>
            </div>
        </div>
    </div>
</div>

<script>
    // ========== LISTA DE FOTOS ==========
    const fotos = [
        'FOTOS/C0001.jpg',
        'FOTOS/C0002.jpg',
        'FOTOS/C0003.jpg',
        'FOTOS/C0004.jpg',
        'FOTOS/C0005.jpg',
        'FOTOS/C0006.jpg',
        'FOTOS/C0007.jpg',
        'FOTOS/C0008.jpg',
        'FOTOS/C0009.jpg',
        'FOTOS/C0010.jpg',
        'FOTOS/C0011.jpg',
        'FOTOS/C0012.jpg',
        'FOTOS/C0013.jpg',
        'FOTOS/C0014.jpg',
        'FOTOS/C0015.jpg',
        'FOTOS/C0016.jpg'
    ];

    const personajes = fotos.map((_, i) => ({
        nombre: 'Personaje ' + String(i + 1).padStart(2, '0'),
        descripcion: 'Personaje de anime'
    }));

    // ========== ELEMENTOS ==========
    const sidebar = document.getElementById('sidebar');
    const foto = document.getElementById('FOTITOS');
    const imageArea = document.getElementById('imageArea');
    const counter = document.getElementById('counter');
    const characterName = document.getElementById('characterName');
    const characterDescription = document.getElementById('characterDescription');

    // ========== ESTADO DEL ZOOM ==========
    let zoom = 1;
    let imagenActual = 0;

    // ========== CREAR MINIATURAS ==========
    fotos.forEach((src, index) => {
        const img = document.createElement('img');
        img.src = src;
        img.alt = personajes[index].nombre;
        img.onclick = function() { seleccionarImagen(index); };
        sidebar.appendChild(img);
    });

    // ========== SELECCIONAR IMAGEN ==========
    function seleccionarImagen(index) {
        imagenActual = index;
        foto.src = fotos[index];
        normal();
        characterName.textContent = personajes[index].nombre;
        characterDescription.textContent = personajes[index].descripcion;
        counter.textContent = (index + 1) + ' / ' + fotos.length;

        var thumbs = document.querySelectorAll('.sidebar img');
        for (var i = 0; i < thumbs.length; i++) {
            if (i === index) {
                thumbs[i].classList.add('selected');
            } else {
                thumbs[i].classList.remove('selected');
            }
        }
    }

    // ========== ZOOM (el que sí funciona) ==========
    function acercar() {
        zoom = zoom + 0.25;
        if (zoom > 5) zoom = 5;
        foto.style.transform = 'scale(' + zoom + ')';
    }

    function alejar() {
        zoom = zoom - 0.25;
        if (zoom < 0.5) zoom = 0.5;
        foto.style.transform = 'scale(' + zoom + ')';
    }

    function normal() {
        zoom = 1;
        foto.style.transform = 'scale(1)';
        foto.style.transformOrigin = 'center center';
    }

    // ========== ZOOM CON LA RUEDA DEL RATÓN ==========
    imageArea.addEventListener('wheel', function(e) {
        e.preventDefault();
        if (e.deltaY < 0) {
            acercar();
        } else {
            alejar();
        }
    }, { passive: false });

    // ========== TECLADO ==========
    document.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowRight') {
            seleccionarImagen((imagenActual + 1) % fotos.length);
        } else if (e.key === 'ArrowLeft') {
            seleccionarImagen((imagenActual - 1 + fotos.length) % fotos.length);
        } else if (e.key === '+' || e.key === '=') {
            acercar();
        } else if (e.key === '-') {
            alejar();
        } else if (e.key === '0') {
            normal();
        }
    });

    // ========== INICIAR ==========
    seleccionarImagen(0);
</script>
</body>
</html>