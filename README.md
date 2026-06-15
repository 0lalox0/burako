# Burako Tracker

## Setup (5 minutos)

### 1. Supabase (base de datos gratis)

1. Creá cuenta en [supabase.com](https://supabase.com) → New Project
2. Entrá a **SQL Editor** y pegá el contenido de `schema.sql` → Run
3. Copiá de **Project Settings → API**:
   - Project URL
   - anon public key

### 2. Configurar el archivo

Abrí `index.html` y reemplazá las dos líneas al inicio del script:

```js
const SUPABASE_URL      = 'https://xxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGci...';
```

### 3. GitHub Pages (hosting gratis)

1. Creá un repo en GitHub (puede ser privado)
2. Subí `index.html` al repo
3. Settings → Pages → Branch: main → Save
4. En ~1 minuto tenés la URL: `https://tu-usuario.github.io/nombre-repo`

### Primer uso

1. Ir a la pestaña **Jugadores** y agregar los 4 amigos
2. Ir a **Temporadas** y crear la primera temporada
3. ¡Cargar partidos desde **Nuevo partido**!
