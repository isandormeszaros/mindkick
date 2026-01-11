# Tesztjegyzőkönyv

**Tesztelő:** Majnár Patrik
**Utolsó módosítás:** 2026.01.11  

**Operációs rendszer:** Windows 11 Home (25H2)
**Böngészők:** Google Chrome

Ez a dokumentum a MindKick projekt fejlesztési szakaszai során elvégzett tesztek eredményeit, valamint a technikai hibaelhárítási folyamatokat rögzíti.

---

## Alfa teszt

| Vizsgálat | Tesztelés időpontja | Elvárás | Eredmény | Hibák |
|-----------|-------------------|---------|----------|-------|
| Backend & DB Init | 2026.01.06 | Backend csatlakozik a MySQL adatbázishoz, a struktúra újrafelhasználható | Sikeresen csatlakozik a backend az adatbázishoz, a struktúra megfelelő | Nem találtam hibát |
| API Routing & CORS | 2026.01.06 | CORS beállítás, alap routing működik | Sikeresen konfigurálva, backend struktúra rendben | Nem találtam hibát |
| Quiz Interface UI | 2026.01.07 | Kvíz lista és játék interfész megjelenik | UI rendben, funkciók elérhetőek | Nem találtam hibát |


---

## Béta teszt

| Vizsgálat | Tesztelés időpontja | Elvárás | Eredmény | Hibák |
|-----------|-------------------|---------|----------|-------|
| UX & Animációk | 2026.01.04 | Dinamikus időzítő, nehézségi jelvények, animációk | UX javítva, animációk és konfetti működik | Nem találtam hibát |
| Auth Backend (API) | 2026.01.06 | Biztonságos API konfiguráció és JWT alapok | Sikeresen implementálva, a `password_hash` szűrése megoldott | Nem találtam hibát |
| Auth Full Stack | 2026.01.07 | Teljes regisztrációs és login folyamat integrációja | Sikeres integráció, a navigáció és token tárolás stabil | Nem találtam hibát |
| Admin Delete Logic | 2026.01.09 | Admin tudja törölni felhasználót SQL cascade kapcsolattal | Az adatintegritás megmarad törlés után is | Nem találtam hibát |
| Profile API Logic | 2026.01.10 | Statisztikák lekérése `LEFT JOIN` és `COALESCE` használatával | Az új felhasználók is látszanak, a NULL értékek 0-ra cserélődtek | **Javítva: korábban üres profil adatok** |
| Data Seeding & Clean | 2026.01.10 | Adatbázis tisztítása (`DELETE FROM`) és manuális feltöltés | Tiszta tesztkörnyezet, az adatok áramlása hitelesített | Nem találtam hibát |
| Badge Trigger Test | 2026.01.10 | Jelvények odaítélése mérföldkövek és játékadatok alapján | A logikai motor pontosan aktiválja a badge-eket | Nem találtam hibát |

---

## Végleges teszt

| Vizsgálat | Tesztelés időpontja | Elvárás | Eredmény | Hibák |
|-----------|-------------------|---------|----------|-------|
| Full Quiz Flow | 2026.01.10 | Játék teljes logika, UX és eredménykezelés | Minden funkció rendeltetésszerűen működik | Nem találtam hibát |
|** Leaderboard** | 2026.01.10 | Ranglista megjelenítés és statisztikák | Leaderboard rendben, felhasználói statisztikák mutatva | **Javítva: vizuális finomítás kész** |
| Gameplay Mechanics | 2026.01.11 | 10/20/30 mp időzítők és 9 mp vizuális riasztás | Az időzítő pontos, a villogó effekt megfelelően aktiválódik | Nem találtam hibát |
| Navigation & Route | 2026.01.11 | "Játék barátokkal" gomb helyes irányítása a `/playwithfriends` útvonalra | A navigáció azonnal betölti a céloldalt (jelenleg fejlesztés alatt jelenít meg) | **Javítva: korábban üres oldal** |
| Module Resolve | 2026.01.11 | `FriendsGame.jsx` hiba nélküli importálása | A modulfeloldási hiba megszűnt, az oldal renderelődik | **Javítva: Vite import hiba** |
| UI Flat Refactor | 2026.01.11 | Stilizálás, gradiens fejlécek és GIF integráció | Modern, letisztult arculat minden komponensen | Nem találtam hibát |

---

## Összegzés
A fejlesztés során kritikus mérföldkő volt a **Profil API** optimalizálása, ahol az SQL lekérdezést `LEFT JOIN` és `COALESCE` technológiával egészítettük ki a biztonságos adatmegjelenítés érdekében. A Git környezet karbantartása (lock fájl törlés) és a mai napon végzett módosítások után az alkalmazás stabil és átadható állapotba került.

**Befejezve:** 2026.01.11